package com.finance.posting.prePayment;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedHashSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.journalvouchers.ClsJournalVouchersDAO;

public class ClsPrePaymentDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsPrePaymentBean prePaymentBean = new ClsPrePaymentBean();
	
	public int insert(String formdetailcode,String cmbtype,int txtaccountdocno, int txttrno, int txttranid, String txtdtype, String txtdistributiondocno, int txtcosttype, int txtcostno,double txtamount, Date startDate, String cmbfrequency,int txtdueafter, int txtinstnos, 
			double txtinstamt,String txtdescription,double txtdebittotal,String txtrowno, Date toDate, ArrayList<String> distributionarray,ArrayList<String> journalvouchersarray,HttpSession session,HttpServletRequest request) throws SQLException {
		
		Connection conn = null;
		
		try{
	        int docno = 0, trno=0, trid=0;
			
	        conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtPREP = conn.createStatement();
			
			DateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
	        java.util.Date date = new java.util.Date();
	        String paymentDate=dateFormat.format(date);
	        java.sql.Date prePaymentDate = commonDAO.changeStringtoSqlDate(paymentDate);
	        
			/*For Distribution*/
			if(cmbtype.equalsIgnoreCase("1")){	
				int masterDocno=prepaymentMasterInsertion(conn,formdetailcode,prePaymentDate,docno,txtaccountdocno,txttrno,txttranid,Integer.parseInt(txtdistributiondocno),txtcosttype,txtcostno,txtamount,startDate,cmbfrequency,txtdueafter,txtinstnos,txtinstamt,txtdescription,session, request);
				if(masterDocno>0){
					
					/*Distribution Grid Saving*/
					int data=0;
					for(int i=0;i< distributionarray.size();i++){
					CallableStatement stmtPREP1=null;
					String[] distribution=distributionarray.get(i).toString().split("::");
					
					if(!distribution[2].equalsIgnoreCase("undefined") && !distribution[2].equalsIgnoreCase("NaN")){
						
						java.sql.Date distributionDate=null;
						
						//System.out.println("distribution date = "+distribution[1].trim().toString());
						
						if(!((distribution[1].trim().toString()) == null)){
							distributionDate=(distribution[1].trim().equalsIgnoreCase("undefined") || distribution[1].trim().equalsIgnoreCase("NaN") || distribution[1].trim().equalsIgnoreCase("") ||  distribution[1].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(distribution[1].trim().toString()));
						}
						
						stmtPREP1 = conn.prepareCall("insert into my_prepd(tranId, sr_no, date, posted, postacno, jobid, amount) values(?,?,?,?,?,?,?)");
						
						stmtPREP1.setInt(1,txttranid);
						stmtPREP1.setInt(2,(i+1));
						stmtPREP1.setDate(3,distributionDate);
						stmtPREP1.setString(4,"0");
						stmtPREP1.setString(5,txtdistributiondocno);
						stmtPREP1.setInt(6,0);
						stmtPREP1.setString(7,(distribution[2].trim().equalsIgnoreCase("undefined") || distribution[2].trim().equalsIgnoreCase("NaN") || distribution[2].trim().equalsIgnoreCase("") || distribution[2].trim().isEmpty()?0:distribution[2].trim()).toString());
						data = stmtPREP1.executeUpdate();
						if(data<=0){
							stmtPREP.close();
							conn.close();
							return 0;
						}
					 }
					
					}
					/*Distribution Grid Saving Ends*/
					
					/*Updating my_jvtran*/
	                String sql1=("update my_jvtran set prep=1 where tr_no="+txttrno+" and tranid="+txttranid);
	                int data1 = stmtPREP.executeUpdate(sql1);
					if(data1<=0){
						stmtPREP.close();
						conn.close();
						return 0;
					}
					/*Updating my_jvtran Ends*/
					
					conn.commit();
					stmtPREP.close();
					conn.close();
					return masterDocno;
				 }
			}
			/*For Distribution Ends*/
			
			
			/*Summary*/
			if(cmbtype.equalsIgnoreCase("2")){
			
				/* Updating my_prepm */
				 String sqls=("select sum(posted) posted from my_prepd where tranid="+txttranid);
				 ResultSet resultSets = stmtPREP.executeQuery(sqls);
				 double posted=0.00; 
				 while (resultSets.next()) {
					 posted = resultSets.getDouble("posted");
				 }
				 
				 if(posted==0 || posted==0.00){
					 String sql1=("update my_prepm set postacno='"+txtdistributiondocno+"',costtype='"+txtcosttype+"',costcode='"+txtcostno+"' where tr_no="+txttrno+" and tranid="+txttranid);
		             int data1 = stmtPREP.executeUpdate(sql1);
					 if(data1<=0){
						stmtPREP.close();
						conn.close();
						return 0;
					}
						
				 }
				 /* Updating my_prepm Ends */
				 
				int data=0;
				/*Distribution Grid Updating*/
				CallableStatement stmtPREP1=null;
				for(int i=0;i< distributionarray.size();i++){
				String[] distribution=distributionarray.get(i).toString().split("::");
				
				if(!distribution[2].equalsIgnoreCase("undefined") && !distribution[2].equalsIgnoreCase("NaN")){
					
					java.sql.Date distributionDate=null;
					
					if(!((distribution[1].toString()) == null)){
						distributionDate = (distribution[1].trim().equalsIgnoreCase("undefined") || distribution[1].trim().equalsIgnoreCase("NaN") || distribution[1].trim().equalsIgnoreCase("") ||  distribution[1].trim().isEmpty()?null:commonDAO.changetstmptoSqlDate(distribution[1].trim()));
					}
				
					stmtPREP1 = conn.prepareCall("update my_prepd set date=?,amount=? where rowno=?");
				     
					stmtPREP1.setDate(1,distributionDate); // Date
					stmtPREP1.setString(2,(distribution[2].trim().equalsIgnoreCase("undefined") || distribution[2].trim().equalsIgnoreCase("NaN") || distribution[2].trim().equalsIgnoreCase("") ||distribution[2].trim().isEmpty()?"0":distribution[2].trim()).toString()); // Amount
					stmtPREP1.setString(3,(distribution[4].trim().equalsIgnoreCase("undefined") || distribution[4].trim().equalsIgnoreCase("NaN") || distribution[4].trim().equalsIgnoreCase("") ||distribution[4].trim().isEmpty()?"0":distribution[4].trim()).toString()); //rowno
					data = stmtPREP1.executeUpdate();
				 }
					if(data<=0){
						stmtPREP1.close();
						conn.close();
						return 0;
					}
				}
				/*Distribution Grid Updating Ends*/
				
				conn.commit();
				stmtPREP.close();
				stmtPREP1.close();
				conn.close();
				return 1;
			}
			/*Summary Ends*/
			
			/*To be Posted*/
			if(cmbtype.equalsIgnoreCase("3")){
			    prePaymentDate=toDate;
				ClsJournalVouchersDAO jvt = new ClsJournalVouchersDAO();
				docno=jvt.insert(prePaymentDate,"JVT".concat("-4"), txtdtype+"-"+txttrno, ""+txtdtype+"-"+txtaccountdocno,txtdebittotal, txtdebittotal, journalvouchersarray, session, request);
				trno=Integer.parseInt(request.getAttribute("tranno").toString());
				
				int rownoLength=txtrowno.length();
				String[] rownos=txtrowno.split(",");
				String[] postacno=txtdistributiondocno.split(",");
				int postacnoLength=postacno.length;
				 
				ArrayList<String> tranidarray=new ArrayList<>();
				for(int m=0;m<postacnoLength;m++){
					 String sql=("SELECT TRANID FROM my_jvtran where ref_row!=1 and TR_NO="+trno+" and acno="+postacno[m]);
					 ResultSet resultSet = stmtPREP.executeQuery(sql);
					    
					 while (resultSet.next()) {
					 tranidarray.add(resultSet.getString("TRANID"));
					 }
				 }
				 
				LinkedHashSet<String> s = new LinkedHashSet<>(tranidarray);
				tranidarray.clear();tranidarray.addAll(s);
				
				for(int i=0;i<tranidarray.size();i++){ 
					String sql1 = "update my_prepd set posted="+tranidarray.get(i)+",jvtrno="+trno+" where rowno="+rownos[i];
					int data = stmtPREP.executeUpdate(sql1);
					if(data<=0){
						stmtPREP.close();
						conn.close();
						return 0;
					}
				}
				
				conn.commit();
				stmtPREP.close();
				conn.close();
				return docno;
			}
			/*To be Posted Ends*/
			
			stmtPREP.close();
			conn.close();		
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
		return 0;
	}
	
	public JSONArray accountsDetails(HttpSession session,String searchtype,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = connDAO.getMyConnection();
		       Statement stmt = conn.createStatement();
			       	           
	           java.sql.Date sqlDate=null;
		       
		        
		        if(check.equalsIgnoreCase("1")){
		        	
	        	   date.trim();
		           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		           {
		        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
		           }
		           
		            String sqltest="";
			        String sql="";
			        String den= "";
			           
		            if(searchtype.equalsIgnoreCase("1")){
						den="604";
					}
					else{
						den="350";
					}
			        
			        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
			        }
			        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
			        }
			        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and c.code like '%"+currency+"%'";
				    }
		        	
			        if(searchtype.equalsIgnoreCase("2")){
		        
		        	sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type,t.gr_type from my_head t left join my_curr c on t.curid=c.doc_no "
		  	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
		  	        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
		  	        	  + "where t.atype='GL' and t.m_s=0 and t.den='"+den+"'"+sqltest;
			        
			        }
			        else if(searchtype.equalsIgnoreCase("1")){
			        sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,cb.rate,c.type,t.gr_type from my_head t left join my_curr c on t.curid=c.doc_no "
			  	        	  + "left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr "
			  	        	  + "where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
			  	        	  + "where t.atype='GL'  and t.m_s=0 "+sqltest;
		        
			        }
			    // System.out.println("==== "+sql);   
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		     stmt.close();
			 conn.close();		        
	     }catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
	    	 conn.close();
	     }
	       return RESULTDATA;
	  }
	
	public JSONArray prePaymentGridLoading(HttpSession session,String cmbtype,String txtaccid,String fromDate,String toDate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
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
        String branch=session.getAttribute("BRANCHID").toString();        
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
				
				String selacno;
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
		        }
			        
				String xsql = "",sqls="";
				String joins="";String casestatement="";
						
				if(!(sqlFromDate==null)){
		        	xsql+=" and jv.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	xsql+=" and jv.date<='"+sqlToDate+"'";
			    }
		       
		        if(!(txtaccid.equalsIgnoreCase("0")) && !(txtaccid.equalsIgnoreCase("")))	    
	            {selacno=txtaccid;
	           
	            if(cmbtype.equalsIgnoreCase("1"))
	            xsql+=" and jv.acno="+selacno+"";else  xsql+=" and he.doc_no="+selacno+"";
				sqls+=" and jv.acno="+selacno+"";
	            }
		        
		        if(!(cmbtype.equalsIgnoreCase("0")) && !(cmbtype.equalsIgnoreCase(""))){
		        	
		        joins=commonDAO.getFinanceVocTablesJoins(conn);
				casestatement=commonDAO.getFinanceVocTablesCase(conn);	
		        	
				if(cmbtype.equalsIgnoreCase("1"))
	    		{
	    			/*For Distribution*/
					xsql = "select "+casestatement+"a.account, a.accountname, a.description, a.date, a.trno, a.tranid, a.doc_no, a.dtype, a.brhId, a.branch, a.atype, a.acno, a.curId,"
							+ "a.curr, a.rate, a.costtype, a.costcode, a.costgroup, a.dramount, a.pendamount from (select he.account,he.description accountname,jv.description,"
							+ "jv.date,jv.tr_no trno,jv.tranid,jv.doc_no,jv.dtype,jv.brhId,b.branchname branch,he.atype,jv.acno,jv.curId,c.code curr,jv.rate,jv.costtype,jv.costcode,"
							+ "co.costgroup,abs(jv.dramount) dramount,abs(jv.dramount) pendamount,jv.doc_no transno,jv.dtype transType from my_jvtran jv inner join MY_BRCH b on "
							+ "jv.brhid=b.doc_no inner join my_head he on jv.acno = he.doc_no inner join my_curr c on jv.curId=c.doc_no left join my_costunit co on jv.costtype=co.costtype "
							+ "left join my_prepd d on jv.tr_no=d.jvtrno where he.den=350 and jv.status=3 and jv.brhid="+branch+" and jv.prep=0 and jv.dramount>0 and d.jvtrno is null"+xsql+") a "+joins+"";
										
	    		}
				
	    		else if(cmbtype.equalsIgnoreCase("2"))
	    		{
	    			/*Summary*/
	    			xsql = "select "+casestatement+"a.account, a.accountname, a.acno, a.atype, a.curid, a.c_rate, a.postacno, a.paccount, a.paccountname, a.freq, a.freqtype,a.noofins, a.instamt, "
	    					+ "a.costcde, a.doc_no, a.date, a.desc1, a.aa, a.brhId, a.trno, a.stdate, a.enddate, a.branch, a.amount,a.rowno, a.posted, a.description, a.dtype, a.tranid, a.costtype, a.costcode, a.costgroup, "
	    					+ "a.postamount, a.dramount, a.pendamount from (select he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,c.c_rate,m.postacno,pe.account paccount,pe.description paccountname,m.freq,m.freqtype,m.noofins,m.instamt,convert(concat(coalesce(cc.description,''),coalesce(v.fleet_no,'')),char(50)) as costcde,"
	    					+ "jv.doc_no,m.date,m.desc1,m.tranid aa,m.brhId,m.tr_no trno,m.stdate,m.enddate,b.branchname branch,d.amount,d.rowno,d.posted,jv.description,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,"
	    					+ "(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 and d.tranid=aa) postamount ,abs(m.amount) dramount,(select m.amount-postamount) pendamount,jv.doc_no transno,jv.dtype transType "
	    					+ "from my_prepm m inner join my_prepd d on m.tranId=d.tranId inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no "
	    					+ "inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype left join my_ccentre cc on(cc.doc_no=m.costcode) "
	    					+ "left join gl_vehmaster v on(v.fleet_no=m.costcode)  where m.brhid="+branch+""+xsql+" group by d.tranId) a "+joins+"";
	    			    			
	    		}
	    		
	    		else if(cmbtype.equalsIgnoreCase("3"))
	    		{
	    			/*To be Posted*/
	    			/*xsql = "select he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,c.c_rate,m.postacno,pe.account paccount,pe.description paccountname,m.doc_no,m.desc1,"
	    					+ "m.tranid aa,m.brhId,m.tr_no trno,b.branchname branch,d.amount dramount,d.rowno,d.date,d.posted,jv.dtype,jv.tranid,jv.costtype,jv.costcode,co.costgroup,(select coalesce(sum(d.amount),0) "
	    					+ "from my_prepd d where posted!=0 and d.tranid=aa) postamount ,coalesce(abs(m.amount)) totalamount,(select d.amount-postamount) pendamount from my_prepm m inner join "
	    					+ "my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no "
	    					+ "inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on jv.costtype=co.costtype where posted=0 and jv.brhid="+branch+"" + xsql;
	    			 			*/
	    			
	    			/*xsql = "select "+casestatement+"a.account, a.accountname, a.acno, a.atype, a.curid, a.c_rate, a.postacno, a.paccount, a.paccountname, a.doc_no, a.desc1, a.aa, a.brhId, a.trno, a.branch, a.dramount, a.rowno, a.date, a.posted, a.description, a.dtype, a.tranid, a.costtype," 
	    					+ "a.costcode, a.costgroup, a.postamount, a.totalamount, a.pendamount from ( select he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,c.c_rate,m.postacno,pe.account paccount,pe.description paccountname,m.doc_no,m.desc1,"
	    					+ "m.tranid aa,m.brhId,m.tr_no trno,b.branchname branch,d.amount dramount,d.rowno,d.date,d.posted,jv.description,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,(select coalesce(sum(d.amount),0) "
	    					+ "from my_prepd d where posted!=0 and d.tranid=aa) postamount ,coalesce(abs(m.amount)) totalamount,(select d.amount-postamount) pendamount,m.doc_no transno,jv.dtype transType from my_prepm m inner join "
	    					+ "my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no "
	    					+ "inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype where d.date>='"+sqlFromDate+"' and"
   							+ " d.date<='"+sqlToDate+"' and  posted=0 and jv.brhid="+branch+""+sqls+") a "+joins+"";*/
	    			
	    			xsql = "select "+casestatement+"a.account, a.accountname, a.acno, a.atype, a.curid, a.c_rate, a.postacno, a.paccount, a.paccountname, a.doc_no, a.desc1, a.aa, a.brhId, a.trno, a.branch, a.dramount, a.rowno, a.date, a.posted, a.description, a.dtype, a.tranid, a.costtype," 
	    					+ "a.costcode, a.costgroup, a.postamount, a.totalamount, a.pendamount from ( select he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,c.c_rate,m.postacno,pe.account paccount,pe.description paccountname,m.doc_no,m.desc1,"
	    					+ "m.tranid aa,m.brhId,m.tr_no trno,b.branchname branch,d.amount dramount,d.rowno,d.date,d.posted,jv.description,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,coalesce(b.postamount,0) postamount,coalesce(abs(m.amount)) totalamount,"
	    					+ "(select d.amount-coalesce(b.postamount,0)) pendamount,jv.doc_no transno,jv.dtype transType from my_prepm m inner join "
	    					+ "my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no "
	    					+ "inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype left join (select coalesce(sum(d.amount),0) postamount,d.tranid,"
	    					+ "d.sr_no from my_prepd d where posted!=0 group by d.tranid,d.sr_no) b on b.tranid=d.tranid and b.sr_no=d.sr_no where d.date>='"+sqlFromDate+"' and d.date<='"+sqlToDate+"' and  posted=0 and jv.brhid="+branch+""+sqls+") a "+joins+"";
	    			 			
	    			
	    		}
				System.out.println(xsql);
				ResultSet resultSet = stmtPREP.executeQuery(xsql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
		        }			
				stmtPREP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray distributionGridReloading(HttpSession session,String tranId,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
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
        String branch = session.getAttribute("BRANCHID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
			
				if(!(tranId.trim().equalsIgnoreCase("0")||tranId.trim().equalsIgnoreCase(""))){
				
				String sqlnew=("select sr_no,date,amount,posted,rowno from my_prepd where tranid="+tranId+"");
				ResultSet resultSet = stmtPREP.executeQuery (sqlnew);
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				}
				stmtPREP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray distributionGrid(String date,String enddate,String cmbfrequency,String txtamount, String txtinstnos,String txtinstamt,String txtdueafter,String check) throws SQLException {
        JSONArray jsonArray = new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return jsonArray;
        }
        
        Connection conn = null; 
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
			
				java.sql.Date xdate=null;
				java.sql.Date fdate=null;
				java.sql.Date newdate=null;
				java.sql.Date endsdate=null;
				
				double xtotal=0.0;
				double amount=0.0;
				int xsrno=0;
		        
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		        	xdate = commonDAO.changeStringtoSqlDate(date);
		        	fdate = commonDAO.changeStringtoSqlDate(date);
		        	newdate = commonDAO.changeStringtoSqlDate(date);
		        }
		        
		        if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
		        	endsdate = commonDAO.changeStringtoSqlDate(enddate);
		        }
		        
		        String xsql="";
		        
				xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
				
				if(!(txtdueafter.equalsIgnoreCase("0"))){
					
				do							
				{	
					++xsrno;
					if (Integer.parseInt(txtinstnos)>0 && xsrno>Integer.parseInt(txtinstnos))
					break;
					
					int sr_no= xsrno;							
					int actualNoOfInst=xsrno;
					
					amount=((xtotal+Double.parseDouble(txtinstamt))>Double.parseDouble(txtamount)?(Double.parseDouble(txtamount)-xtotal):Double.parseDouble(txtinstamt));
					xtotal+=amount;
					
					//setting values to grid
					JSONObject obj = new JSONObject();
					obj.put("sr_no",String.valueOf(sr_no));

					if(!(xdate==null)){
						obj.put("date",xdate.toString());
					}
					obj.put("amount",String.valueOf(amount));
					obj.put("posted",0);
					
					jsonArray.add(obj);
					
					if(xtotal>=Double.parseDouble(txtamount)) break;
					//if (Integer.parseInt(txtinstnos)>0 && xsrno==Integer.parseInt(txtinstnos) && MyLib.getSum(txtamount, xtotal*-1, 2)>0)
					//{
						//preBrowse.cache.setData("Amount",MyLib.getSum(preBrowse.cache.getDouble("Amount"),
							//	MyLib.getSum(txtamount, xtotal*-1, 2),2));
								
                    //	xtotal+=MyLib.getSum(txtamount, xtotal*-1, 2);
					//}
					
					ResultSet rs = stmtPREP.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+fdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+fdate+"')))) fdate ");
					
					if(rs.next()) xdate=rs.getDate("fdate");
					
					rs.close();
			} while(true);
				
			} else {
				
				int totalDays=0,noOfDays=0,srno=1;
				double perDay=0.00,instamt=0.00,total=0.00;
				
				JSONObject obj = new JSONObject();
				
				if(endsdate==null){
					conn.close();
					return jsonArray; 
				}
				
				if(xdate==null){
					conn.close();
					return jsonArray; 
				}
				
				String sql1 = "SELECT DATEDIFF(coalesce('"+endsdate+"',null),coalesce('"+xdate+"',null)) totalDays";
				ResultSet rs1 = stmtPREP.executeQuery(sql1);
				
				while(rs1.next()) {
					totalDays=rs1.getInt("totalDays");
				} 
				
				String sql2 = "SELECT ("+txtamount+"/(("+totalDays+")+1)) perDay";
				ResultSet rs2 = stmtPREP.executeQuery(sql2);
				
				while(rs2.next()) {
					perDay=rs2.getDouble("perDay");
				} 

				int i=0;fdate = xdate;newdate = xdate;
				while(!(newdate.after(endsdate) || newdate.equals(endsdate))){
				   
				   if(newdate.after(endsdate) || newdate.equals(endsdate)){
				    	 break;
				   }
					
				   if(i==0){
					   
					   if(cmbfrequency.equalsIgnoreCase("2")){
						   
						   String sql4= "SELECT DATEDIFF(LAST_DAY('"+fdate+"'),'"+fdate+"') noOfDays";
						   ResultSet rs3 = stmtPREP.executeQuery(sql4);
						   
						   while(rs3.next()){
							   noOfDays=rs3.getInt("noOfDays");
						    }
						   
						   String sql5= "SELECT LAST_DAY('"+fdate+"') fdate,LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 1 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+")) newdate,(round("+perDay+",2)*(("+noOfDays+")+1)) installments";
						   ResultSet rs4 = stmtPREP.executeQuery(sql5);
						   
						   while(rs4.next()){
							   	 fdate=rs4.getDate("fdate");
							   	 newdate=rs4.getDate("newdate");
							   	 instamt=rs4.getDouble("installments");
						     }
						   
					   }
					   
					   if(cmbfrequency.equalsIgnoreCase("3")){
						   
						   String sql4= "SELECT DATEDIFF(CONCAT(YEAR('"+fdate+"'),'-12-31'),'"+fdate+"') noOfDays";
						   ResultSet rs3 = stmtPREP.executeQuery(sql4);
						   
						   while(rs3.next()){
							   noOfDays=rs3.getInt("noOfDays");
						    }
						   
						   String sql5= "SELECT CONCAT(YEAR('"+fdate+"'),'-12-31') fdate,DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 1  Year ) newdate,(round("+perDay+",2)*(("+noOfDays+")+1)) installments";
						   ResultSet rs4 = stmtPREP.executeQuery(sql5);
						   
						   while(rs4.next()){
							   	 fdate=rs4.getDate("fdate");
							   	 newdate=rs4.getDate("newdate");
							   	 instamt=rs4.getDouble("installments");
						     }
						   
					   }
					   
					    total+=instamt;
					   
					    obj.put("sr_no",String.valueOf(srno));
						if(!(xdate==null)){
							obj.put("date",fdate.toString());
						}
						obj.put("amount",String.valueOf(instamt));
						obj.put("posted",0);
						
						jsonArray.add(obj);
					   
						srno++;
					   
					} else {
						
						   if(newdate.after(endsdate) || newdate.equals(endsdate)){
							   break;
					       }
						
						   if(cmbfrequency.equalsIgnoreCase("2")){
							   
							   String sql4= "SELECT EXTRACT(DAY FROM LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 1 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+"))) noOfDays";
							   ResultSet rs3 = stmtPREP.executeQuery(sql4);
							   
							   while(rs3.next()){
								   noOfDays=rs3.getInt("noOfDays");
							    }
							   
							   String sql5= "SELECT LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 1 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+")) fdate,LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 2 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+")) newdate,(round("+perDay+",2)*"+noOfDays+") installments";
							   ResultSet rs4 = stmtPREP.executeQuery(sql5);
							   
							   while(rs4.next()){
								   	 fdate=rs4.getDate("fdate");
								   	 newdate=rs4.getDate("newdate");
								   	 instamt=rs4.getDouble("installments");
							     }
						   }
						   
						   if(cmbfrequency.equalsIgnoreCase("3")){
							   
							   if(newdate.after(endsdate) || newdate.equals(endsdate)){
							    	 break;
							      }
							   
							   String sql4= "SELECT DATEDIFF(DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 1  Year ),CONCAT(YEAR('"+fdate+"'),'-12-31')) noOfDays";
							   ResultSet rs3 = stmtPREP.executeQuery(sql4);
							   
							   while(rs3.next()){
								   noOfDays=rs3.getInt("noOfDays");
							    }
							   
							   String sql5= "SELECT DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 1  Year ) fdate,DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 2  Year ) newdate,(round("+perDay+",2)*"+noOfDays+") installments";
							   ResultSet rs4 = stmtPREP.executeQuery(sql5);
							   
							   while(rs4.next()){
								   	 fdate=rs4.getDate("fdate");
								   	 newdate=rs4.getDate("newdate");
								   	 instamt=rs4.getDouble("installments");
							     }
						   }
						   
						    total+=instamt;
						   
						    obj.put("sr_no",String.valueOf(srno));
							if(!(xdate==null)){
								obj.put("date",fdate.toString());
							}
							obj.put("amount",String.valueOf(instamt));
							obj.put("posted",0);
							
							jsonArray.add(obj);
							     
						    srno++;
				   }
				   i++;
				}
				
					   String sql6= "SELECT round("+txtamount+"-"+total+",2) installments";
					   ResultSet rs5 = stmtPREP.executeQuery(sql6);
					   
					   while(rs5.next()){
						   	 instamt=rs5.getDouble("installments");
					     }
					   
					    obj.put("sr_no",String.valueOf(srno));
						if(!(xdate==null)){
							obj.put("date",endsdate.toString());
						}
						obj.put("amount",String.valueOf(instamt));
						obj.put("posted",0);
						
						jsonArray.add(obj);
				
			}
				stmtPREP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return jsonArray;
    }
	
	public JSONArray applyingInvoiceGridLoading(String trno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase(""))){
            	
				String sql="Select t.*,t.curId currencyid,t.out_amount applied,h.den,h.atype,h.gr_type,h.account,h.agroup, if((h.lapply and t.lage=0) or t.lage=1,1,0) lApply,"
						+ "b.doc_no branch,b.branchName, c.code curr,h.description accountname,ref_row,if(dramount>0,dramount,0) debit,if(dramount<0,abs(dramount),0) credit,"
						+ "ldramount lamount  from my_jvtran t,my_head h,my_brch b,my_curr c where t.brhId=b.doc_no and t.acno=h.doc_no and c.doc_no=t.curId and  t.tr_no="+trno+" "
						+ "and t.trtype!=3 order by ref_row";
				
				ResultSet resultSet = stmtPREP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPREP.close();
				conn.close();
				}
			stmtPREP.close();
			conn.close();	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray applyingInvoiceGridLoading3(HttpSession session,String tmp,String startdate,String enddate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
				
            	java.sql.Date sdate=null;
            	java.sql.Date tdate=null;
				
				if(!(startdate.trim().equalsIgnoreCase("0") && enddate.trim().equalsIgnoreCase("0"))){
				
            	if(!(startdate.equalsIgnoreCase("undefined"))&&!(startdate.equalsIgnoreCase(""))&&!(startdate.equalsIgnoreCase("0"))) {
            		sdate = commonDAO.changeStringtoSqlDate(startdate);
 	            }
            	if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))) {
            		tdate = commonDAO.changeStringtoSqlDate(enddate);
            	}
            	tmp=tmp.trim().toString();
            	/*
            	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                get current date time with Date()
                java.util.Date date = new java.util.Date();
                cdate = ClsCommon.changeStringtoSqlDate(dateFormat.format(date));
               
                */ 
            	
            	 String branch = session.getAttribute("BRANCHID").toString();	
				
            	 String sql="select costcde,acno doc_no,atype,account,accountname,costgroup,costtype,costcode,dramount debit,cramount credit,curid currencyid,c_rate rate,desc1 description, 0 as ref_row,rowno,0 as id from "
						+ "(select convert(concat(coalesce(cc.description,''),coalesce(v.fleet_no,'')),char(50)) as costcde,he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,c.c_rate,m.postacno,m.doc_no,m.desc1,m.tranid aa,m.brhId,m.tr_no trno,b.branchname branch,0 dramount,d.amount cramount,d.rowno,d.date,"
						+ " d.posted,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 "
						+ " and d.tranid=aa) postamount ,coalesce(abs(m.amount)) totalamount,(select d.amount-postamount) pendamount from my_prepm m inner join"
						+ " my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no"
						+ " inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join "
						+ " my_costunit co on m.costtype=co.costtype left join my_ccentre cc on(cc.doc_no=m.costcode) left join gl_vehmaster v on(v.fleet_no=m.costcode) where   posted=0 "
						+ "union all "
						+ " select convert(concat(coalesce(cc.description,''),coalesce(v.fleet_no,'')),char(50)) as costcde,pe.account,pe.description accountname,pe.doc_no acno,pe.atype,pe.curid,c.c_rate,m.postacno,m.doc_no,m.desc1,m.tranid aa,m.brhId,m.tr_no trno,b.branchname branch,d.amount dramount,0 cramount,d.rowno,d.date,"
						+ " d.posted,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 "
						+ " and d.tranid=aa) postamount ,coalesce(abs(m.amount)) totalamount,(select d.amount-postamount) pendamount from my_prepm m inner join "
						+ " my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid  inner join"
						+ " my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=pe.curid left join"
						+ " my_costunit co on m.costtype=co.costtype left join my_ccentre cc on(cc.doc_no=m.costcode) left join gl_vehmaster v on(v.fleet_no=m.costcode) where  posted=0 ) as a where trno in("+tmp+") and date>='"+sdate+"' and date<='"+tdate+"' and brhid="+branch+" group by acno order by rowno";
				
				ResultSet resultSet = stmtPREP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				}
				
				stmtPREP.close();
				conn.close();
				
			stmtPREP.close();
			conn.close();	
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray prePaymentGridExcelExport(HttpSession session,String cmbtype,String txtaccid,String fromDate,String toDate,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
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
        String branch=session.getAttribute("BRANCHID").toString();        
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPREP = conn.createStatement();
				
				String selacno;
				java.sql.Date sqlFromDate=null;
				java.sql.Date sqlToDate=null;
			        
				fromDate.trim();
		        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
		        {
		        	sqlFromDate = commonDAO.changeStringtoSqlDate(fromDate);
		        }
		        
		        toDate.trim();
		        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
		        {
		        	sqlToDate = commonDAO.changeStringtoSqlDate(toDate);
		        }
			        
				String xsql = "",sqls="";
				String joins="";String casestatement="";
				
				if(!(sqlFromDate==null)){
		        	xsql+=" and jv.date>='"+sqlFromDate+"'";
			    }
		        
		        if(!(sqlToDate==null)){
		        	xsql+=" and jv.date<='"+sqlToDate+"'";
			    }
		       
		        if(!(txtaccid.equalsIgnoreCase("0")) && !(txtaccid.equalsIgnoreCase("")))	    
	            {selacno=txtaccid;
	           
	            if(cmbtype.equalsIgnoreCase("1"))
	            xsql+=" and jv.acno="+selacno+"";else  xsql+=" and he.doc_no="+selacno+"";
				sqls+=" and jv.acno="+selacno+"";
	            }
		        
		        if(!(cmbtype.equalsIgnoreCase("0")) && !(cmbtype.equalsIgnoreCase(""))){
		        	
		        joins=commonDAO.getFinanceVocTablesJoins(conn);
				casestatement=commonDAO.getFinanceVocTablesCase(conn);	
		        	
		        	
				if(cmbtype.equalsIgnoreCase("1"))
	    		{
	    			/*For Distribution*/
					/*xsql = "select b.branchname 'Branch',jv.dtype 'Doc Type',jv.doc_no 'Doc No.',he.atype 'Type',he.account 'Account No.',he.description 'Account Name',0 'Post A/C No.',"
							+ "0 'Post A/C Name',jv.date 'Date',jv.description 'Description',abs(jv.dramount) 'Amount',0 'Posted',abs(jv.dramount) 'Balance' from my_jvtran jv inner join "
							+ "MY_BRCH b on jv.brhid=b.doc_no inner join my_head he on jv.acno = he.doc_no inner join my_curr c on jv.curId=c.doc_no left join my_costunit co on "
							+ "jv.costtype=co.costtype left join my_prepd d on jv.tr_no=d.jvtrno where he.den=350 and jv.brhid="+branch+" and jv.prep=0 and jv.dramount>0 and d.jvtrno is null" + xsql;*/
					
					xsql = "select a.branch 'Branch',a.dtype 'Doc Type',"+casestatement+"a.atype 'Type', a.account 'Account No.', a.accountname 'Account Name',0 'Post A/C No.', 0 'Post A/C Name', "
							+ "a.date 'Date',a.description 'Description',abs(a.dramount) 'Amount',0 'Posted',abs(a.dramount) 'Balance' from (select he.account,he.description accountname,jv.description,"
							+ "jv.date,jv.tr_no trno,jv.tranid,jv.doc_no,jv.dtype,jv.brhId,b.branchname branch,he.atype,jv.acno,jv.curId,c.code curr,jv.rate,jv.costtype,jv.costcode,"
							+ "co.costgroup,abs(jv.dramount) dramount,abs(jv.dramount) pendamount,jv.doc_no transno,jv.dtype transType from my_jvtran jv inner join MY_BRCH b on "
							+ "jv.brhid=b.doc_no inner join my_head he on jv.acno = he.doc_no inner join my_curr c on jv.curId=c.doc_no left join my_costunit co on jv.costtype=co.costtype "
							+ "left join my_prepd d on jv.tr_no=d.jvtrno where he.den=350 and jv.status=3 and jv.brhid="+branch+" and jv.prep=0 and jv.dramount>0 and d.jvtrno is null"+xsql+") a "+joins+"";
					
										
	    		}
				
	    		else if(cmbtype.equalsIgnoreCase("2"))
	    		{
	    			/*Summary*/
	    			
	    			/*xsql = "select b.branchname 'Branch',jv.dtype 'Doc Type',jv.doc_no 'Doc No.',he.atype 'Type',he.account 'Account No.',he.description 'Account Name',pe.account 'Post A/C No.',"
	    					+ "pe.description 'Post A/C Name',m.date 'Date',jv.description 'Description',abs(m.amount) 'Amount',(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 and d.tranid=m.tranid) 'Posted',"
	    					+ "(select m.amount-posted) 'Balance' from my_prepm m inner join my_prepd d on m.tranId=d.tranId inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no "
	    					+ "inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype left join "
	    					+ "my_ccentre cc on(cc.doc_no=m.costcode) left join gl_vehmaster v on(v.fleet_no=m.costcode)  where m.brhid="+branch+" "+xsql+" group by d.tranId";*/
	    			
	    			
	    			xsql = "select a.branch 'Branch',a.dtype 'Doc Type',"+casestatement+"a.atype 'Type',a.account 'Account No.',a.accountname 'Account Name',a.paccount 'Post A/C No.', a.paccountname 'Post A/C Name',"
	    					+ "a.date 'Date',a.description 'Description',abs(a.dramount) 'Amount',a.postamount 'Posted',a.pendamount 'Balance' from (select he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,c.c_rate,"
	    					+ "m.postacno,pe.account paccount,pe.description paccountname,m.freq,m.freqtype,m.noofins,m.instamt,convert(concat(coalesce(cc.description,''),coalesce(v.fleet_no,'')),char(50)) as costcde,"
	    					+ "jv.doc_no,m.date,m.desc1,m.tranid aa,m.brhId,m.tr_no trno,m.stdate,m.enddate,b.branchname branch,d.amount,d.rowno,d.posted,jv.description,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,"
	    					+ "(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 and d.tranid=aa) postamount ,abs(m.amount) dramount,(select m.amount-postamount) pendamount,jv.doc_no transno,jv.dtype transType "
	    					+ "from my_prepm m inner join my_prepd d on m.tranId=d.tranId inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no "
	    					+ "inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype left join my_ccentre cc on(cc.doc_no=m.costcode) "
	    					+ "left join gl_vehmaster v on(v.fleet_no=m.costcode)  where m.brhid="+branch+""+xsql+" group by d.tranId) a "+joins+"";
	    			    			
	    		}
	    		
	    		else if(cmbtype.equalsIgnoreCase("3"))
	    		{
	    			/*To be Posted*/
	    			/*xsql = "select b.branchname 'Branch',jv.dtype 'Doc Type',m.doc_no 'Doc No.',he.atype 'Type',he.account 'Account No.',he.description 'Account Name',pe.account 'Post A/C No.',"
	    					+ "pe.description 'Post A/C Name',d.date 'Date',jv.description 'Description',d.amount 'Amount',(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 and d.tranid=m.tranid) 'Posted',"
	    					+ "(select d.amount-posted) 'Balance' from my_prepm m inner join my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no "
	    					+ "inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype where "
	    					+ "d.date>='"+sqlFromDate+"' and d.date<='"+sqlToDate+"' and  posted=0 and jv.brhid="+branch+""+sqls+"";*/
	    			
	    			/*xsql = "select a.branch 'Branch',a.dtype 'Doc Type',"+casestatement+"a.atype 'Type',a.account 'Account No.', a.accountname 'Account Name', a.paccount 'Post A/C No.', a.paccountname 'Post A/C Name',"
	    					+ "a.date 'Date',a.description 'Description',a.dramount 'Amount',a.postamount 'Posted',a.pendamount 'Balance' from ( select he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,"
	    					+ "c.c_rate,m.postacno,pe.account paccount,pe.description paccountname,m.doc_no,m.desc1,m.tranid aa,m.brhId,m.tr_no trno,b.branchname branch,d.amount dramount,d.rowno,d.date,d.posted,"
	    					+ "jv.description,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,(select coalesce(sum(d.amount),0) from my_prepd d where posted!=0 and d.tranid=aa) postamount ,coalesce(abs(m.amount)) totalamount,"
	    					+ "(select d.amount-postamount) pendamount,m.doc_no transno,jv.dtype transType from my_prepm m inner join my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he "
	    					+ "on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype where d.date>='"+sqlFromDate+"' and"
   							+ " d.date<='"+sqlToDate+"' and  posted=0 and jv.brhid="+branch+""+sqls+") a "+joins+"";*/
	    			
	    			xsql = "select a.branch 'Branch',a.dtype 'Doc Type',"+casestatement+"a.atype 'Type',a.account 'Account No.', a.accountname 'Account Name', a.paccount 'Post A/C No.', a.paccountname 'Post A/C Name',"
	    					+ "a.date 'Date',a.description 'Description',a.dramount 'Amount',a.postamount 'Posted',a.pendamount 'Balance' from ( select he.account,he.description accountname,he.doc_no acno,he.atype,he.curid,"
	    					+ "c.c_rate,m.postacno,pe.account paccount,pe.description paccountname,m.doc_no,m.desc1,m.tranid aa,m.brhId,m.tr_no trno,b.branchname branch,d.amount dramount,d.rowno,d.date,d.posted,"
	    					+ "jv.description,jv.dtype,jv.tranid,m.costtype,m.costcode,co.costgroup,coalesce(b.postamount,0) postamount ,coalesce(abs(m.amount)) totalamount,"
	    					+ "(select d.amount-coalesce(b.postamount,0)) pendamount,jv.doc_no transno,jv.dtype transType from my_prepm m inner join my_prepd d on m.tranId=d.tranId  inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he "
	    					+ "on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype left join "
	    					+ "(select coalesce(sum(d.amount),0) postamount,d.tranid,d.sr_no from my_prepd d where posted!=0 group by d.tranid,d.sr_no) b on b.tranid=d.tranid and b.sr_no=d.sr_no where d.date>='"+sqlFromDate+"' and "
   							+ "d.date<='"+sqlToDate+"' and  posted=0 and jv.brhid="+branch+""+sqls+") a "+joins+"";
							
	    		}
				
				ResultSet resultSet = stmtPREP.executeQuery(xsql);
				RESULTDATA=commonDAO.convertToEXCEL(resultSet);
		        }			
				stmtPREP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public ClsPrePaymentBean getPrint(HttpServletRequest request,int tranid,int branch) throws SQLException {
		 ClsPrePaymentBean bean = new ClsPrePaymentBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtPREP = conn.createStatement();
			
			String headersql="select 'Prepayment' vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from my_prepm m inner join "
					+ "my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,"
					+ "lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.brhid="+branch+" and m.tranid="+tranid+"";
			
			ResultSet resultSetHead = stmtPREP.executeQuery(headersql);
			
			while(resultSetHead.next()){
				
				bean.setLblcompname(resultSetHead.getString("company"));
				bean.setLblcompaddress(resultSetHead.getString("address"));
				bean.setLblprintname(resultSetHead.getString("vouchername"));
				bean.setLblcomptel(resultSetHead.getString("tel"));
				bean.setLblcompfax(resultSetHead.getString("fax"));
				bean.setLblbranch(resultSetHead.getString("branchname"));
				bean.setLbllocation(resultSetHead.getString("location"));
				bean.setLblcstno(resultSetHead.getString("cstno"));
				bean.setLblpan(resultSetHead.getString("pbno"));
				bean.setLblservicetax(resultSetHead.getString("stcno"));
				bean.setLblpobox(resultSetHead.getString("pbno"));
			}
			
			String frequency="";
			String sqls = "select freqtype from my_prepm where brhid="+branch+" and tranid="+tranid+"";
			ResultSet resultSets = stmtPREP.executeQuery(sqls);
			
			while(resultSets.next()){
				frequency=resultSets.getString("freqtype");
			}
			
			if(frequency.equalsIgnoreCase("2")){
	        	frequency="MONTH";
	        } else if(frequency.equalsIgnoreCase("3")){
	        	frequency="YEAR";
	        } else {
	        	frequency="DAY";
	        }
			
			String sql = "select m.tranid aa,CONCAT(he.account,' - ',he.description) accountname,CONCAT(jv.dtype,' - ',jv.doc_no) voucherno,jv.description,DATE_FORMAT(m.date ,'%d-%m-%Y') voucherdate,"
					+ "round(abs(m.amount),2) amount,(select round(coalesce(sum(d.amount),0),2) from my_prepd d where posted!=0 and d.tranid=aa) postedamount ,(select round(m.amount-postedamount,2)) balanceamount," 
					+ "CONCAT(pe.account,' - ',pe.description) postaccountname,co.costgroup,if(m.freqtype=1,'DAY',if(m.freqtype=2,'MONTH',if(m.freqtype=3,'YEAR',' '))) freqtype,"
					+ "convert(concat(coalesce(cc.description,''),coalesce(v.fleet_no,'')),char(50)) as costcde,m.freq dueafter,m.noofins,coalesce(DATE_FORMAT(m.stDate ,'%d-%m-%Y'),' ') stDate,"
					+ "m.desc1,coalesce(DATE_FORMAT(DATE_ADD(coalesce(m.stDate,null),INTERVAL if(m.noOfIns=0,0,(m.noOfIns-1)) "+frequency+"),'%d-%m-%Y'),' ') endDate,b.branchname branch from my_prepm m inner join "
					+ "my_prepd d on m.tranId=d.tranId inner join my_jvtran jv on m.tranid=jv.tranid inner join my_head he on m.acno=he.doc_no inner join my_head pe on m.postacno=pe.doc_no inner join MY_BRCH b on "
					+ "m.brhid=b.doc_no inner join my_curr c on c.doc_no=he.curid left join my_costunit co on m.costtype=co.costtype left join my_ccentre cc on(cc.doc_no=m.costcode) left join gl_vehmaster v on "
					+ "(v.fleet_no=m.costcode) where m.brhid="+branch+" and d.tranid="+tranid+" group by d.tranId";
			
			ResultSet resultSet = stmtPREP.executeQuery(sql);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				
				bean.setLblaccount(resultSet.getString("accountname"));
				bean.setLblvoucherno(resultSet.getString("voucherno"));
				bean.setLbldescription(resultSet.getString("description"));
				bean.setLblvoucherdate(resultSet.getString("voucherdate"));
				bean.setLblamountwords(c.convertAmountToWords(resultSet.getString("amount")));
				bean.setLblamount(resultSet.getString("amount"));
				bean.setLblpostamountwords(c.convertAmountToWords(resultSet.getString("postedamount")));
				bean.setLblpostedamount(resultSet.getString("postedamount"));
				bean.setLblbalanceamountwords(c.convertAmountToWords(resultSet.getString("balanceamount")));
				bean.setLblbalanceamount(resultSet.getString("balanceamount"));
				
				bean.setLbldistributionaccount(resultSet.getString("postaccountname"));
				bean.setLbldistributionamount(resultSet.getString("amount"));
				bean.setLbldistributioncosttype(resultSet.getString("costgroup"));
				bean.setLbldistributionfrequency(resultSet.getString("freqtype"));
				bean.setLbldistributioncostno(resultSet.getString("costcde"));
				bean.setLbldistributiondueafter(resultSet.getString("dueafter"));
				bean.setLbldistributioninstnos(resultSet.getString("noofins"));
				bean.setLbldistributionstartdate(resultSet.getString("stDate"));
				bean.setLbldistributiondescription(resultSet.getString("desc1"));
				bean.setLbldistributionenddate(resultSet.getString("endDate"));
			}
		
			String sql1="select (DATE_FORMAT(date,'%D %M  %Y ')) date,round(amount,2) amount,if(posted>0,'YES','NO') posted from my_prepd where tranid="+tranid+"";
				
			ResultSet resultSet1 = stmtPREP.executeQuery(sql1);
			
			ArrayList<String> printdistribute= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("date")+"::"+resultSet1.getString("amount")+"::"+resultSet1.getString("posted");
				printdistribute.add(temp);
			}
			
			request.setAttribute("printdistribution", printdistribute);
			
			stmtPREP.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	 
	 public int prepaymentMasterInsertion(Connection conn, String formdetailcode, Date prePaymentDate, int docno,int txtaccountdocno, int txttrno, int txttranid, int txtdistributiondocno, int txtcosttype,int txtcostno, double txtamount,
			    Date startDate,String cmbfrequency, int txtdueafter, int txtinstnos,double txtinstamt,String txtdescription, HttpSession session,HttpServletRequest request) throws SQLException{
	    	try{
				CallableStatement stmtPREP;
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
		    	stmtPREP = conn.prepareCall("{CALL prepaymentmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtPREP.registerOutParameter(18, java.sql.Types.INTEGER);
				
				stmtPREP.setDate(1,prePaymentDate); //date
				stmtPREP.setInt(2,txtaccountdocno); //acno
				stmtPREP.setInt(3,txtdistributiondocno); //Post acno
				stmtPREP.setDate(4,startDate); //start date
				stmtPREP.setInt(5, txtdueafter); //due after
				stmtPREP.setInt(6, txtcosttype); //cost type
				stmtPREP.setInt(7, txtcostno); //cost code
				stmtPREP.setString(8, cmbfrequency); //frequency type
				stmtPREP.setInt(9, txtinstnos); //no of installments
				stmtPREP.setDouble(10, txtamount); //amount
				
				stmtPREP.setDouble(11, txtinstamt); //installment amount
				stmtPREP.setInt(12, 0); //installment type
				
				stmtPREP.setString(13, txtdescription); //description
				stmtPREP.setInt(14, txttranid); //tranid of acno
				
				stmtPREP.setString(15,formdetailcode);
				
				stmtPREP.setString(16,branch);
				stmtPREP.setString(17,userid);
				stmtPREP.setInt(19, txttrno);
				stmtPREP.setString(20,"A");
				int prepaymentmastercheck=stmtPREP.executeUpdate();
				if(prepaymentmastercheck<=0){
					stmtPREP.close();
					conn.close();
					return 0;
				 }
				docno=stmtPREP.getInt("docNo");
				
				stmtPREP.close();
				return docno;
								
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	  }
	}

}
