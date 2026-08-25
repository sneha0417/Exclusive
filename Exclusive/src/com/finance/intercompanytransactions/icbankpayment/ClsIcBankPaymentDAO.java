package com.finance.intercompanytransactions.icbankpayment;

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
import net.sf.json.JSONObject;

import com.common.ClsAmountToWords;
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsIcBankPaymentDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	ClsIcBankPaymentBean icBankPaymentBean = new ClsIcBankPaymentBean();
	ClsApplyDelete applyDeleteDAO = new ClsApplyDelete();
	
	public int insert(Date icBankPaymentsDate, String formdetailcode, String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, String txtchequename, String txtdescription,
			String txtpaymentreceivedfrom, double txtdrtotal, ArrayList<String> icbankpaymentarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		  	Connection conn = null;
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtICBP = conn.prepareCall("{CALL icChqmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtICBP.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtICBP.registerOutParameter(15, java.sql.Types.INTEGER);

			stmtICBP.setDate(1,icBankPaymentsDate);
			stmtICBP.setString(2,txtrefno);
			stmtICBP.setString(3,txtdescription);
			stmtICBP.setString(4,txtchequeno);
			stmtICBP.setDate(5,chequeDate);
			stmtICBP.setString(6,txtchequename);
			stmtICBP.setDouble(7,txtdrtotal);
			stmtICBP.setDouble(8,txtfromrate);
			stmtICBP.setString(9,txtpaymentreceivedfrom);
			stmtICBP.setString(10,formdetailcode);
			stmtICBP.setString(11,company);
			stmtICBP.setString(12,branch);
			stmtICBP.setString(13,userid);
			stmtICBP.setString(16,mode);
			int datas=stmtICBP.executeUpdate();
			if(datas<=0){
				stmtICBP.close();
				conn.close();
				return 0;
			}
			int docno=stmtICBP.getInt("docNo");
			int trno=stmtICBP.getInt("itranNo");
			request.setAttribute("tranno", trno);
			icBankPaymentBean.setTxticbankpaymentdocno(docno);
			if (docno > 0) {
					/*Insertion to my_chqbd,my_chqdet,my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, icBankPaymentsDate, txtrefno, txtfromrate, txtdescription, chequeDate, txtchequeno, txtdrtotal, icbankpaymentarray, session,mode);
					if(insertData<=0){
						stmtICBP.close();
						conn.close();
						return 0;
					}
					/*Insertion to my_chqbd,my_chqdet,my_jvtran Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
					ResultSet resultSet = stmtICBP.executeQuery(sql1);
					while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					}

					 if(total == 0){
						conn.commit();
						stmtICBP.close();
						conn.close();
						return docno;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtICBP.close();
					    return 0;
				    }
			}
			stmtICBP.close();
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
			
	 public boolean edit(int txticbankpaymentdocno, String formdetailcode, Date icBankPaymentsDate, String txtrefno, String txtdescription, double txtfromrate, Date chequeDate, String txtchequeno,
			String txtchequename, String txtpaymentreceivedfrom, double txtdrtotal, int txttotrno, ArrayList<String> icbankpaymentarray, HttpSession session, String mode) throws SQLException {
		
			Connection conn = null;
			
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtICBP = conn.createStatement();
				Statement stmtICBP1 = conn.createStatement();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				int trno = txttotrno;
			    int total = 0;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_chqbm*/
                String sql=("update my_chqbm set date='"+icBankPaymentsDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',description='"+txtpaymentreceivedfrom+"',chqno='"+txtchequeno+"', chqname='"+txtchequename+"', chqdt='"+chequeDate+"',mrate='"+txtfromrate+"',trMode=3,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txticbankpaymentdocno);
                int data = stmtICBP.executeUpdate(sql);
				if(data<=0){
					conn.close();
					stmtICBP.close();
					return false;
				}
				/*Updating my_chqbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txticbankpaymentdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtICBP.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
				String sql3="select ic.tr_no,cp.dbname from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where ic.dtype='"+formdetailcode+"' and ic.doc_no="+txticbankpaymentdocno+"";
				ResultSet resultSet3 = stmtICBP.executeQuery(sql3);
			    
				 while (resultSet3.next()) {
					String dbname=resultSet3.getString("dbname");
					int transno=resultSet3.getInt("tr_no");
					
					String sql4=("DELETE FROM "+dbname+".my_chqbd WHERE TR_NO="+transno+"");
				    int data4 = stmtICBP1.executeUpdate(sql4);
				    
				    String sql5=("DELETE FROM "+dbname+".my_chqdet WHERE TR_NO="+transno+"");
				    int data5 = stmtICBP1.executeUpdate(sql5);
				    
				    String sql6=("DELETE FROM "+dbname+".my_jvtran WHERE TR_NO="+transno+"");
				    int data6 = stmtICBP1.executeUpdate(sql6);
				    
				    String sql7=("DELETE FROM "+dbname+".my_costtran WHERE TR_NO="+transno+"");
				    int data7 = stmtICBP1.executeUpdate(sql7);
				    
				 }
			    
			    int docno=txticbankpaymentdocno;
			    icBankPaymentBean.setTxticbankpaymentdocno(docno);
				if (docno > 0) {
					/*Insertion to my_chqbd,my_chqdet,my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, icBankPaymentsDate, txtrefno, txtfromrate, txtdescription, chequeDate, txtchequeno, txtdrtotal, icbankpaymentarray, session,mode);
					if(insertData<=0){
						stmtICBP.close();
						conn.close();
						return false;
					}
					/*Insertion to my_chqbd,my_chqdet,my_jvtran Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtICBP.executeQuery(sql1);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						conn.commit();
						stmtICBP.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtICBP.close();
					    return false;
				    }
				}
			stmtICBP.close();
		    conn.close();	
		 } catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;	
		 } finally{
				conn.close();
			}
			return false;
	}
	
	 public boolean editMaster(int txticbankpaymentdocno, String formdetailcode, Date icBankPaymentsDate, String txtrefno, String txtdescription, double txtfromrate, Date chequeDate, String txtchequeno,
				String txtchequename, String txtpaymentreceivedfrom, double txtdrtotal, int txttotrno, HttpSession session) throws SQLException {
		 
		Connection conn = null;
			
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtICBP = conn.createStatement();
			
			int trno = txttotrno;
		    
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_chqbm*/
            String sql=("update my_chqbm set date='"+icBankPaymentsDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',description='"+txtpaymentreceivedfrom+"',mrate='"+txtfromrate+"',trMode=3,totalAmount='"+txtdrtotal+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txticbankpaymentdocno+"");
			int data = stmtICBP.executeUpdate(sql);
			if(data<=0){
				stmtICBP.close();
				conn.close();
				return false;
			}
			/*Updating my_chqbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txticbankpaymentdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtICBP.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtICBP.close();
		    conn.close();
			return true;			
      }catch(Exception e){
	 	  e.printStackTrace();
	 	  conn.close();
	 	  return false;
      }finally{
			conn.close();
		}
	}


	public boolean delete(int txticbankpaymentdocno, String formdetailcode, int txttotrno, HttpSession session) throws SQLException {
		
		Connection conn = null; 
		try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtICBP = conn.createStatement();
				Statement stmtICBP1 = conn.createStatement();
				Statement stmtICBP2 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttotrno;
				
                /*Applying Delete*/
				applyDeleteDAO.getFinanceApplyDelete(conn, trno);
				/*Applying Delete Ends*/
				
				 /*Status change in my_chqbm*/
				 String sql=("update my_chqbm set STATUS=7 where doc_no="+txticbankpaymentdocno+" and TR_NO="+trno+"");
				 int data = stmtICBP.executeUpdate(sql);
				/*Status change in my_chqbm Ends*/
				 
				 String sql1=("DELETE FROM my_chqdet WHERE TR_NO="+trno+"");
				 int data1 = stmtICBP.executeUpdate(sql1);
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txticbankpaymentdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtICBP.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				 String sql2="select ic.tr_no,cp.dbname from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where ic.dtype='"+formdetailcode+"'  and ic.doc_no="+txticbankpaymentdocno+"";
				 ResultSet resultSet1 = stmtICBP.executeQuery(sql2);
				    
				 while (resultSet1.next()) {
					String dbname=resultSet1.getString("dbname");
					int transno=resultSet1.getInt("tr_no");
					
					/*Status change in my_jvtran*/
				    String sql3=("update "+dbname+".my_jvtran set STATUS=7 where doc_no="+txticbankpaymentdocno+" and dtype='ICBP'");
					int data2 = stmtICBP1.executeUpdate(sql3);
					/*Status change in my_jvtran Ends*/
					
					/*Status change in my_intrcmptrno*/
					 String sql4=("update intercompany.my_intrcmptrno set STATUS=7 where dtype='"+formdetailcode+"' and doc_no="+txticbankpaymentdocno+" and TR_NO="+transno+"");
					 int data3 = stmtICBP2.executeUpdate(sql4);
					/*Status change in my_intrcmptrno Ends*/
				    
				 }
				
				 int docno=txticbankpaymentdocno;
				 icBankPaymentBean.setTxticbankpaymentdocno(docno);
				 if (docno > 0) {
					conn.commit();
					stmtICBP.close();
				    conn.close();
					return true;
				}	
			stmtICBP.close();
			conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
				conn.close();
			}
				return false;
	    }
	
	public JSONArray interCompanyBranchSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtICBP = conn.createStatement();

				String sql="select CONCAT(compname,' / ',branchname) intercompname,compname,branchname,dbname,brhid,cmpid,doc_no from intercompany.my_intrcomp where status=3 order by cmpid";
				
				ResultSet resultSet = stmtICBP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtICBP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray costTypeSearch(String database) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    
		try {
				Connection conn = connDAO.getMyConnection();
				Statement stmtICBP = conn.createStatement ();
				
				ResultSet resultSet = stmtICBP.executeQuery ("select costtype,costgroup from "+database+".my_costunit where status=1");
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtICBP.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
	
	public  JSONArray costCodeSearch(String type,String database) throws SQLException {
	    JSONArray RESULTDATA=new JSONArray();
	    ClsCommon ClsCommon=new ClsCommon();
	  
		try {
				Connection conn = connDAO.getMyConnection();
				Statement stmtICBP = conn.createStatement ();
			
				/* Cost Center */
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from "+database+".my_ccentre c1 left join "+database+".my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
	        		ResultSet resultSet = stmtICBP.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICBP.close();
					conn.close();
	        	}
	        	/* AMC & SJOB */
	        	else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4"))
	        	{
	        		String dtype="";
	        		if(type.equalsIgnoreCase("3")) {
	        			dtype="AMC";
	        		} else if(type.equalsIgnoreCase("4")) {
	        			dtype="SJOB";
	        		}
	        		
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from "+database+".cm_srvcontrm m left join "+database+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='"+dtype+"'";
	        		ResultSet resultSet = stmtICBP.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICBP.close();
					conn.close();
	        	}
	        	/* Call Register */
	        	else if(type.equalsIgnoreCase("5"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from "+database+".cm_cuscallm m left join "+database+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
	        		ResultSet resultSet = stmtICBP.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICBP.close();
					conn.close();
	        	}
	        	/* Fleet */
	        	else if(type.equalsIgnoreCase("6"))
	        	{
	        		String sql="select doc_no,fleet_no code,flname name,reg_no from "+database+".gl_vehmaster where cost=0";
	        		ResultSet resultSet = stmtICBP.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICBP.close();
					conn.close();
	        	}
	        	/* IJCE */
	        	else if(type.equalsIgnoreCase("7"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from "+database+".is_jobmaster m left join "+database+".my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join "+database+".is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'";
	        		ResultSet resultSet = stmtICBP.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
	        		stmtICBP.close();
					conn.close();
	        	}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
	public JSONArray icbankpaymentGridReloading(HttpSession session,String docNo,String check) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        
	        if(!(check.equalsIgnoreCase("1"))) {
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
					Statement stmtICBP = conn.createStatement();
					Statement stmtICBP1 = conn.createStatement();
					
					String sql = "select d.brhid,ic.dbname FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE "
							+ "m.dtype='ICBP' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO>0";
					
					ResultSet resultSet = stmtICBP.executeQuery (sql);
					
					int srno=1;
					ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
					while(resultSet.next()){
						String dbname=resultSet.getString("dbname");
						
						String sql1="SELECT m.date,m.RefNo,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,"
								+ "d.rate rate,if(d.dr>0,true,false)  dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup,CONCAT(ic.compname,' / ',ic.branchname) compbranch,"
								+ "d.brhid intrcompid,ic.dbname,ic.brhid intrbrhid FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on "
								+ "d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICBP' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO="+srno+"";
						
						ResultSet resultSet1 = stmtICBP1.executeQuery(sql1);
						
						while(resultSet1.next()){
							ArrayList<String> temp=new ArrayList<String>();
							
							temp.add(resultSet1.getString("docno"));
							temp.add(resultSet1.getString("compbranch"));
							temp.add(resultSet1.getString("intrcompid"));
							temp.add(resultSet1.getString("type"));
							temp.add(resultSet1.getString("accounts"));
							temp.add(resultSet1.getString("accountname1"));
							temp.add(resultSet1.getString("currency"));
							temp.add(resultSet1.getString("currencyid"));
							temp.add(resultSet1.getString("rate"));
							temp.add(resultSet1.getString("costtype"));
							temp.add(resultSet1.getString("costgroup"));
							temp.add(resultSet1.getString("costcode"));
							temp.add(resultSet1.getString("dr"));
							temp.add(resultSet1.getString("amount1"));
							temp.add(resultSet1.getString("baseamount1"));
							temp.add(resultSet1.getString("description"));
							temp.add(resultSet1.getString("grtype"));
							temp.add(resultSet1.getString("sr_no"));
							temp.add(resultSet1.getString("currencytype"));
							temp.add(resultSet1.getString("intrbrhid"));
							temp.add(resultSet1.getString("dbname"));
							
							analysisrowarray.add(temp);
							srno++;
						}
						
			        }

					RESULTDATA=convertRowArrayToJSON(analysisrowarray);
					
					stmtICBP.close();
					stmtICBP1.close();
					conn.close();

			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
			return RESULTDATA;
	    }
	
	public  JSONArray convertRowArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		  JSONArray jsonArray = new JSONArray();
		  
		  for (int i = 0; i < rowsAnalysisList.size(); i++) {
		   
		   JSONObject obj = new JSONObject();
		   ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
		   
		   obj.put("docno",analysisRowArray.get(0));
		   obj.put("compbranch",analysisRowArray.get(1));
		   obj.put("intrcompid",analysisRowArray.get(2));
		   obj.put("type",analysisRowArray.get(3));
		   obj.put("accounts",analysisRowArray.get(4));
		   obj.put("accountname1",analysisRowArray.get(5));
		   obj.put("currency",analysisRowArray.get(6));
		   obj.put("currencyid",analysisRowArray.get(7));
		   obj.put("rate",analysisRowArray.get(8));
		   obj.put("costtype",analysisRowArray.get(9));
		   obj.put("costgroup",analysisRowArray.get(10));
		   obj.put("costcode",analysisRowArray.get(11));
		   obj.put("dr",analysisRowArray.get(12));
		   obj.put("amount1",analysisRowArray.get(13));
		   obj.put("baseamount1",analysisRowArray.get(14));
		   obj.put("description",analysisRowArray.get(15));
		   obj.put("grtype",analysisRowArray.get(16));
		   obj.put("sr_no",analysisRowArray.get(17));
		   obj.put("currencytype",analysisRowArray.get(18));
		   obj.put("intrbrhid",analysisRowArray.get(19));
		   obj.put("dbname",analysisRowArray.get(20));

		   jsonArray.add(obj);
		  }
		  return jsonArray;
		  }
	
	 public JSONArray icBankPaymentGridSearch(String type,String database,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
			if(!(check.equalsIgnoreCase("1"))) {
	        	return RESULTDATA;
	        }
			
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtICBP = conn.createStatement();
		
			        String sqltest="";
			        String sql="";
			        java.sql.Date sqlDate=null;
			         
			           date.trim();
			           if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
			           {
			        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
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
			        
		           sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,round(cb.rate,2) c_rate from "+database+".my_head t left join "+database+".my_curr c "
						+ "on t.curid=c.doc_no left join "+database+".my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
						+ "cr.frmDate from "+database+".my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
						+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
			        
			       ResultSet resultSet = stmtICBP.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
		        stmtICBP.close();
				conn.close();
		     } catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     } finally{
				 conn.close();
			 }
		       return RESULTDATA;
		  }
	
	 public JSONArray icbpMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String check) throws SQLException {

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
		        Statement stmtICBP = conn.createStatement();
		        	
		        java.sql.Date sqlReceiptDate=null;
		        
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		        {
		        sqlReceiptDate = commonDAO.changeStringtoSqlDate(date);
		        }

		        String sqltest="";
		        
		        if(!(docNo.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
		        }
		        
		        if(!(partyname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and m.description like '%"+partyname+"%'";
		        }
		        
		        if(!(amount.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and m.totalAmount like '%"+amount+"%'";
		        }
		        
		        if(!(sqlReceiptDate==null)){
			         sqltest=sqltest+" and m.date='"+sqlReceiptDate+"'";
			    } 
		        
		       String sql= "select m.date,m.doc_no,m.totalAmount amount,m.description from  my_chqbm m where m.brhid="+branch+" and m.dtype='ICBP' and m.status <> 7"+sqltest;
		       
		       ResultSet resultSet = stmtICBP.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtICBP.close();
		       conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
			}
	        return RESULTDATA;
	  }
	
	 public ClsIcBankPaymentBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsIcBankPaymentBean icBankPaymentBean = new ClsIcBankPaymentBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtICBP = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtICBP.executeQuery("SELECT m.date,m.RefNo,m.totalAmount,t.atype,t.account,t.description,t.doc_no accno,d.curId,d.rate,d.dr,(d.AMOUNT*d.dr) AMOUNT,"
				+ "(d.lamount*d.dr) lamount,m.chqname,m.DESC1,m.description fromto,d.SR_NO,d.TR_NO,j.tranid,cq.chqno,cq.chqdt,c.type FROM my_chqbm m left join my_chqbd d on (m.tr_no=d.tr_no and d.SR_NO=0) "
				+ "left join my_jvtran j on d.tr_no=j.tr_no left join my_chqdet cq on cq.tr_no=d.tr_no left join my_head t on d.acno=t.doc_no left join my_curr c on d.curId=c.doc_no WHERE m.dtype='ICBP' "
				+ "and m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" group by account");
	
			while (resultSet.next()) {
					icBankPaymentBean.setTxticbankpaymentdocno(docNo);
					icBankPaymentBean.setIcBankPaymentDate(resultSet.getDate("date").toString());
					icBankPaymentBean.setTxtrefno(resultSet.getString("RefNo"));
					icBankPaymentBean.setTxttotranid(resultSet.getInt("tranid"));
					icBankPaymentBean.setTxttotrno(resultSet.getInt("TR_NO"));
				
					icBankPaymentBean.setTxtfromdocno(resultSet.getInt("accno"));
					icBankPaymentBean.setTxtfromaccid(resultSet.getString("account"));
					icBankPaymentBean.setTxtfromaccname(resultSet.getString("description"));
					icBankPaymentBean.setHidcmbfromcurrency(resultSet.getString("curId"));
					icBankPaymentBean.setHidfromcurrencytype(resultSet.getString("type"));
					icBankPaymentBean.setTxtfromrate(resultSet.getDouble("rate"));
					icBankPaymentBean.setTxtfromamount(resultSet.getDouble("AMOUNT"));
					icBankPaymentBean.setTxtfrombaseamount(resultSet.getDouble("lamount"));
					icBankPaymentBean.setTxtchequeno(resultSet.getString("chqno"));
					icBankPaymentBean.setJqxChequeDate(resultSet.getDate("chqdt").toString());
					icBankPaymentBean.setTxtchequename(resultSet.getString("chqname"));
					icBankPaymentBean.setTxtdescription(resultSet.getString("DESC1"));
					icBankPaymentBean.setTxtpaymentreceivedfrom(resultSet.getString("fromto"));
					
					icBankPaymentBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
					icBankPaymentBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
					icBankPaymentBean.setMaindate(resultSet.getDate("date").toString());
		    }
		stmtICBP.close();
		conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return icBankPaymentBean;
		}
	 
	public ClsIcBankPaymentBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsIcBankPaymentBean bean = new ClsIcBankPaymentBean();
		 Connection conn = null;
		 
		try {
			
			conn = connDAO.getMyConnection();
			Statement stmtICBP = conn.createStatement();
			
			int trno=0;
			int acno=0;
			int srno=0;
			
			String headersql="select if(m.dtype='ICBP','IC Bank Payment','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_chqbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='ICBP' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtICBP.executeQuery(headersql);
				
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
			
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,m.description name,m.chqno,DATE_FORMAT(m.chqdt ,'%d-%m-%Y') chqdt,round(m.totalAmount,2) netAmount,u.user_name from my_chqbm m left join my_user u on "
						+ "m.userid=u.doc_no where m.dtype='ICBP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
				ResultSet resultSets = stmtICBP.executeQuery(sqls);
				
				while(resultSets.next()){
					
					bean.setLblvoucherno(resultSets.getString("doc_no"));
					bean.setLbldescription(resultSets.getString("desc1"));
					bean.setLblname(resultSets.getString("name"));
					bean.setLbldate(resultSets.getString("date"));
					bean.setLblchqno(resultSets.getString("chqno"));
					bean.setLblchqdate(resultSets.getString("chqdt"));
					bean.setLbldebittotal(resultSets.getString("netAmount"));
					bean.setLblcredittotal(resultSets.getString("netAmount"));
					bean.setLblpreparedby(resultSets.getString("user_name"));
				}
				
				bean.setTxtheader(header);
			
			String sql="select round(m.totalAmount,2) netAmount,h.description,d.acno,m.tr_no from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head h on "
				+ "d.acno=h.doc_no where m.dtype='ICBP' and d.sr_no=1 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet = stmtICBP.executeQuery(sql);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				srno=1;
				
				trno=resultSet.getInt("tr_no");
				acno=resultSet.getInt("acno");
				
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
			}
			
			if(srno==0){
				String sqld="select round(m.totalAmount,2) netAmount,h.description,d.acno,m.tr_no from my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no left join my_head h on "
						+ "d.acno=h.doc_no where m.dtype='ICBP' and d.sr_no=2 and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
						ResultSet resultSet1 = stmtICBP.executeQuery(sqld);
						
						while(resultSet1.next()){
							trno=resultSet1.getInt("tr_no");
							acno=resultSet1.getInt("acno");
							
							bean.setLblnetamount(resultSet1.getString("netAmount"));
							bean.setLblnetamountwords(c.convertAmountToWords(resultSet1.getString("netAmount")));
							
						}
			}
			
			String sql1 = "";

			sql1="SELECT t.account,t.description accountname,if(d.description='0','  ',d.description) description,c.code currency,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit FROM my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no "
						+ "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='ICBP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet1 = stmtICBP.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){

				bean.setSecarray(2); 
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}
			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_chqbm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='ICBP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtICBP.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
			
			stmtICBP.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	 
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date icbankpaymentDate, String txtrefno, double txtfromrate, String txtdescription, 
			 Date chequeDate, String txtchequeno, double txtdrtotal, ArrayList<String> icbankpaymentarray, HttpSession session,String mode) throws SQLException {

		  try {
			    conn.setAutoCommit(false);
			    CallableStatement stmtICBP;
				Statement stmtICBP1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Ic Bank Payment Grid and Details Saving*/
				for(int i=0;i< icbankpaymentarray.size();i++){
					String[] icbankpayment=icbankpaymentarray.get(i).split("::");
					if(!icbankpayment[0].trim().equalsIgnoreCase("undefined") && !icbankpayment[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0,trid = 0;
					int id = 0;
					if(icbankpayment[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(icbankpayment[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					
					
					if(i==1) {
						
						/*Insertion to my_chqdet*/
						String sql=("insert into my_chqdet(chqno,chqdt,opsacno,pdc,Status,postno,tr_no,brhId) values('"+txtchequeno+"','"+chequeDate+"','"+(icbankpayment[0].trim().equalsIgnoreCase("undefined") || icbankpayment[0].trim().equalsIgnoreCase("NaN") || icbankpayment[0].trim().isEmpty()?0:icbankpayment[0].trim()).toString()+"', 0,'E',0,'"+trno+"','"+(icbankpayment[11].trim().equalsIgnoreCase("undefined") || icbankpayment[11].trim().equalsIgnoreCase("NaN") || icbankpayment[11].trim().equalsIgnoreCase("") || icbankpayment[11].trim().equalsIgnoreCase("0") || icbankpayment[11].trim().isEmpty()?"1":icbankpayment[11].trim()).toString()+"')");
						int data = stmtICBP1.executeUpdate(sql);
						if(data<=0){
							stmtICBP1.close();
							conn.close();
							return 0;
						}
						/*my_chqdet Ends*/
						
					}
					
					stmtICBP = conn.prepareCall("{CALL icChqbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_chqbd*/
					stmtICBP.setInt(22,trno); 
					stmtICBP.setInt(23,docno);
					stmtICBP.registerOutParameter(24, java.sql.Types.INTEGER);
					
					stmtICBP.setInt(1,i); //SR_NO
					stmtICBP.setString(2,(icbankpayment[0].trim().equalsIgnoreCase("undefined") || icbankpayment[0].trim().equalsIgnoreCase("NaN") || icbankpayment[0].trim().isEmpty()?0:icbankpayment[0].trim()).toString());  //doc_no of my_head
					stmtICBP.setString(3,(icbankpayment[1].trim().equalsIgnoreCase("undefined") || icbankpayment[1].trim().equalsIgnoreCase("NaN") || icbankpayment[1].trim().isEmpty()?0:icbankpayment[1].trim()).toString()); //curId
					stmtICBP.setString(4,(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()); //rate 
					stmtICBP.setInt(5,id); //#credit -1 / debit 1 
					stmtICBP.setString(6,(icbankpayment[4].trim().equalsIgnoreCase("undefined") || icbankpayment[4].trim().equalsIgnoreCase("NaN") || icbankpayment[4].trim().isEmpty()?0:icbankpayment[4].trim()).toString()); //amount
					stmtICBP.setString(7,(icbankpayment[5].trim().equalsIgnoreCase("undefined") || icbankpayment[5].trim().equalsIgnoreCase("NaN") || icbankpayment[5].trim().isEmpty()?0:icbankpayment[5].trim()).toString()); //description
					stmtICBP.setString(8,(icbankpayment[6].trim().equalsIgnoreCase("undefined") || icbankpayment[6].trim().equalsIgnoreCase("NaN") || icbankpayment[6].trim().isEmpty()?0:icbankpayment[6].trim()).toString()); //baseamount
					stmtICBP.setInt(9,cash); //For cash = 0/ party = 1
					stmtICBP.setString(10,(icbankpayment[8].trim().equalsIgnoreCase("undefined") || icbankpayment[8].trim().equalsIgnoreCase("NaN") || icbankpayment[8].trim().equalsIgnoreCase("") || icbankpayment[8].trim().equalsIgnoreCase("0") || icbankpayment[8].trim().isEmpty()?0:icbankpayment[8].trim()).toString()); //Cost type
					stmtICBP.setString(11,(icbankpayment[9].trim().equalsIgnoreCase("undefined") || icbankpayment[9].trim().equalsIgnoreCase("NaN") || icbankpayment[9].trim().equalsIgnoreCase("") || icbankpayment[9].trim().equalsIgnoreCase("0") || icbankpayment[9].trim().isEmpty()?0:icbankpayment[9].trim()).toString()); //Cost Code
					/*my_chqbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtICBP.setDate(12,icbankpaymentDate);
					stmtICBP.setString(13,txtrefno);
					stmtICBP.setInt(14,id);  //id
					stmtICBP.setString(15,(icbankpayment[7].trim().equalsIgnoreCase("undefined") || icbankpayment[7].trim().equalsIgnoreCase("NaN") || icbankpayment[7].trim().isEmpty()?0:icbankpayment[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtICBP.setString(16,formdetailcode);
					stmtICBP.setString(17,(icbankpayment[10].trim().equalsIgnoreCase("undefined") || icbankpayment[10].trim().equalsIgnoreCase("NaN") || icbankpayment[10].trim().equalsIgnoreCase("") || icbankpayment[10].trim().equalsIgnoreCase("0") || icbankpayment[10].trim().isEmpty()?" ":icbankpayment[10].trim()).toString()); //Database Name
					stmtICBP.setString(18,(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"1":icbankpayment[12].trim()).toString()); //Inter-Company
					stmtICBP.setString(19,(icbankpayment[13].trim().equalsIgnoreCase("undefined") || icbankpayment[13].trim().equalsIgnoreCase("NaN") || icbankpayment[13].trim().equalsIgnoreCase("") || icbankpayment[13].trim().equalsIgnoreCase("0") || icbankpayment[13].trim().isEmpty()?"1":icbankpayment[13].trim()).toString()); //Main-Company
					stmtICBP.setString(20,(icbankpayment[11].trim().equalsIgnoreCase("undefined") || icbankpayment[11].trim().equalsIgnoreCase("NaN") || icbankpayment[11].trim().equalsIgnoreCase("") || icbankpayment[11].trim().equalsIgnoreCase("0") || icbankpayment[11].trim().isEmpty()?"1":icbankpayment[11].trim()).toString()); //Inter-Branch
					stmtICBP.setString(21,userid);
					stmtICBP.setString(25,mode);
					int detail=stmtICBP.executeUpdate();
					int rowsno=stmtICBP.getInt("irowsNo");
					if(detail<=0){
						stmtICBP.close();
						conn.close();
						return 0;
				    }
					
					/*Inter Company Transfer*/
					if(i!=0) {
						
						if(i==1){
							
							int rowno=0;
							String sql15="select rowno from my_chqbd where sr_no=0 and tr_no="+trno+"";
							ResultSet resultSet15 = stmtICBP1.executeQuery(sql15);
							while (resultSet15.next()) {
								rowno = resultSet15.getInt("rowno");
							}
							
							String sql16="update my_chqdet set rowno="+rowno+",payRowno="+rowsno+" where tr_no="+trno+"";
							int data9 = stmtICBP1.executeUpdate(sql16);
						}
						
						int accountDocNo=0,cldocno=0,lapply=0;
						String sql3="Select h.doc_no as accountDocNo from my_head h INNER JOIN intercompany.my_intrcmp c ON (c.doc_no=h.doc_no) left JOIN intercompany.my_intrcomp co ON (co.doc_no= c.cmp2) "  
								+ "left JOIN intercompany.my_intrcomp co1 ON (co1.doc_no= c.cmp1) where h.doc_no=c.doc_no and ((c.cmp1="+(icbankpayment[13].trim().equalsIgnoreCase("undefined") || icbankpayment[13].trim().equalsIgnoreCase("NaN") || icbankpayment[13].trim().equalsIgnoreCase("") || icbankpayment[13].trim().equalsIgnoreCase("0") || icbankpayment[13].trim().isEmpty()?"1":icbankpayment[13].trim()).toString()+" "
								+ "and  c.cmp2="+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"1":icbankpayment[12].trim()).toString()+") or "
								+ "(c.cmp1="+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"1":icbankpayment[12].trim()).toString()+" and  "
								+ "c.cmp2="+(icbankpayment[13].trim().equalsIgnoreCase("undefined") || icbankpayment[13].trim().equalsIgnoreCase("NaN") || icbankpayment[13].trim().equalsIgnoreCase("") || icbankpayment[13].trim().equalsIgnoreCase("0") || icbankpayment[13].trim().isEmpty()?"1":icbankpayment[13].trim()).toString()+"))";
						ResultSet resultSet2 = stmtICBP1.executeQuery(sql3);
						    
						while (resultSet2.next()) {
							accountDocNo = resultSet2.getInt("accountDocNo");
						}
						
						String sql4="select cldocno,lapply from my_head where doc_no='"+(icbankpayment[0].trim().equalsIgnoreCase("undefined") || icbankpayment[0].trim().equalsIgnoreCase("NaN") || icbankpayment[0].trim().isEmpty()?0:icbankpayment[0].trim()).toString()+"'";
						ResultSet resultSet3 = stmtICBP1.executeQuery(sql4);
						    
						while (resultSet3.next()) {
							cldocno = resultSet3.getInt("cldocno");
							lapply = resultSet3.getInt("lapply");
						}
						
						if(accountDocNo>0){
							
							String sql5="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icbankpaymentDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"','"+(icbankpayment[5].trim().equalsIgnoreCase("undefined") || icbankpayment[5].trim().equalsIgnoreCase("NaN") || icbankpayment[5].trim().isEmpty()?0:icbankpayment[5].trim()).toString()+"',"
									 + "'"+(icbankpayment[1].trim().equalsIgnoreCase("undefined") || icbankpayment[1].trim().equalsIgnoreCase("NaN") || icbankpayment[1].trim().isEmpty()?0:icbankpayment[1].trim()).toString()+"','"+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icbankpayment[4].trim().equalsIgnoreCase("undefined") || icbankpayment[4].trim().equalsIgnoreCase("NaN") || icbankpayment[4].trim().isEmpty()?0:icbankpayment[4].trim()).toString())+","+Double.parseDouble((icbankpayment[6].trim().equalsIgnoreCase("undefined") || icbankpayment[6].trim().equalsIgnoreCase("NaN") || icbankpayment[6].trim().isEmpty()?0:icbankpayment[6].trim()).toString())+","
									 + "0,"+id+",3,"+rowsno+","+lapply+","+cldocno+","+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+",'ICBP','"+session.getAttribute("BRANCHID").toString().trim()+"',"
									 + "'"+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"0":icbankpayment[12].trim()).toString()+"',"+trno+",3)";
							int data3 = stmtICBP1.executeUpdate(sql5);
							 if(data3<=0){
								   stmtICBP1.close();
								   conn.close();
								   return 0;
							 }
						
							 int itranNo=0,idocNo=0,icmpId=0,intrCmpid=0;
							 
							 String sql6="select ic.tr_no,ic.doc_no,ic.cmpid from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where "
									 + "cp.dbname='"+(icbankpayment[10].trim().equalsIgnoreCase("undefined") || icbankpayment[10].trim().equalsIgnoreCase("NaN") || icbankpayment[10].trim().equalsIgnoreCase("") || icbankpayment[10].trim().equalsIgnoreCase("0") || icbankpayment[10].trim().isEmpty()?" ":icbankpayment[10].trim()).toString()+"' "
									 + "and cp.cmpid=(select cmpid from intercompany.my_intrcomp where doc_no='"+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"1":icbankpayment[12].trim()).toString()+"') "
									 + "and ic.dtype='ICBP' and ic.doc_no="+docno+"";
							 ResultSet resultSet6 = stmtICBP1.executeQuery(sql6);
							    
							 while (resultSet6.next()) {
								itranNo = resultSet6.getInt("tr_no");
								idocNo = resultSet6.getInt("doc_no");
								icmpId = resultSet6.getInt("cmpid");
							 }
							 
							 if(itranNo==0) {
								 
								 String sql7="select coalesce((max(trno)+1),1) as itranNo from "+(icbankpayment[10].trim().equalsIgnoreCase("undefined") || icbankpayment[10].trim().equalsIgnoreCase("NaN") || icbankpayment[10].trim().equalsIgnoreCase("") || icbankpayment[10].trim().equalsIgnoreCase("0") || icbankpayment[10].trim().isEmpty()?" ":icbankpayment[10].trim()).toString()+".my_trno";
								 ResultSet resultSet7 = stmtICBP1.executeQuery(sql7);
								    
								 while (resultSet7.next()) {
									itranNo = resultSet7.getInt("itranNo");
								 }
								 
								 String sql8="insert into "+(icbankpayment[10].trim().equalsIgnoreCase("undefined") || icbankpayment[10].trim().equalsIgnoreCase("NaN") || icbankpayment[10].trim().equalsIgnoreCase("") || icbankpayment[10].trim().equalsIgnoreCase("0") || icbankpayment[10].trim().isEmpty()?" ":icbankpayment[10].trim()).toString()+".my_trno(edate,trtype,brhId,USERNO,trno) values('"+icbankpaymentDate+"',2,'"+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"1":icbankpayment[12].trim()).toString()+"','"+userid+"',"+itranNo+")";
								 int data4 = stmtICBP1.executeUpdate(sql8);
								 if(data4<=0){
									   stmtICBP1.close();
									   conn.close();
									   return 0;
								 }
							 
							 }

							 if(idocNo!=docno && icmpId!=Integer.parseInt(icbankpayment[12].trim())){
								 String sql9="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICBP', '"+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"1":icbankpayment[12].trim()).toString()+"', "+itranNo+")";								 
								 int data5 = stmtICBP1.executeUpdate(sql9);
								 if(data5<=0){
									   stmtICBP1.close();
									   conn.close();
									   return 0;
								 }
							 }
							 
							String sql10="insert into "+(icbankpayment[10].trim().equalsIgnoreCase("undefined") || icbankpayment[10].trim().equalsIgnoreCase("NaN") || icbankpayment[10].trim().equalsIgnoreCase("") || icbankpayment[10].trim().equalsIgnoreCase("0") || icbankpayment[10].trim().isEmpty()?" ":icbankpayment[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icbankpaymentDate+"','"+txtrefno+"','"+docno+"','"+(icbankpayment[0].trim().equalsIgnoreCase("undefined") || icbankpayment[0].trim().equalsIgnoreCase("NaN") || icbankpayment[0].trim().isEmpty()?0:icbankpayment[0].trim()).toString()+"',"
									 + "'"+(icbankpayment[5].trim().equalsIgnoreCase("undefined") || icbankpayment[5].trim().equalsIgnoreCase("NaN") || icbankpayment[5].trim().isEmpty()?0:icbankpayment[5].trim()).toString()+"',"
									 + "'"+(icbankpayment[1].trim().equalsIgnoreCase("undefined") || icbankpayment[1].trim().equalsIgnoreCase("NaN") || icbankpayment[1].trim().isEmpty()?0:icbankpayment[1].trim()).toString()+"','"+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icbankpayment[4].trim().equalsIgnoreCase("undefined") || icbankpayment[4].trim().equalsIgnoreCase("NaN") || icbankpayment[4].trim().isEmpty()?0:icbankpayment[4].trim()).toString())+","+Double.parseDouble((icbankpayment[6].trim().equalsIgnoreCase("undefined") || icbankpayment[6].trim().equalsIgnoreCase("NaN") || icbankpayment[6].trim().isEmpty()?0:icbankpayment[6].trim()).toString())+","
									 + "0,"+id+",3,"+rowsno+","+lapply+","+cldocno+","+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+",'ICBP','"+(icbankpayment[11].trim().equalsIgnoreCase("undefined") || icbankpayment[11].trim().equalsIgnoreCase("NaN") || icbankpayment[11].trim().equalsIgnoreCase("") || icbankpayment[11].trim().equalsIgnoreCase("0") || icbankpayment[11].trim().isEmpty()?"0":icbankpayment[11].trim()).toString()+"',"
									 + "'"+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"0":icbankpayment[12].trim()).toString()+"',"+itranNo+",3)";
							int data5 = stmtICBP1.executeUpdate(sql10);
							 if(data5<=0){
								   stmtICBP1.close();
								   conn.close();
								   return 0;
							 }
							 
							 String sql11="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+session.getAttribute("COMPANYID").toString().trim()+"' and brhid='"+session.getAttribute("BRANCHID").toString().trim()+"'";
							 ResultSet resultSet11 = stmtICBP1.executeQuery(sql11);
							 while (resultSet11.next()) {
								 intrCmpid = resultSet11.getInt("doc_no");
							 }
							 
							 String sql12="insert into "+(icbankpayment[10].trim().equalsIgnoreCase("undefined") || icbankpayment[10].trim().equalsIgnoreCase("NaN") || icbankpayment[10].trim().equalsIgnoreCase("") || icbankpayment[10].trim().equalsIgnoreCase("0") || icbankpayment[10].trim().isEmpty()?" ":icbankpayment[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icbankpaymentDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"','"+(icbankpayment[5].trim().equalsIgnoreCase("undefined") || icbankpayment[5].trim().equalsIgnoreCase("NaN") || icbankpayment[5].trim().isEmpty()?0:icbankpayment[5].trim()).toString()+"',"
									 + "'"+(icbankpayment[1].trim().equalsIgnoreCase("undefined") || icbankpayment[1].trim().equalsIgnoreCase("NaN") || icbankpayment[1].trim().isEmpty()?0:icbankpayment[1].trim()).toString()+"','"+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icbankpayment[4].trim().equalsIgnoreCase("undefined") || icbankpayment[4].trim().equalsIgnoreCase("NaN") || icbankpayment[4].trim().isEmpty()?0:icbankpayment[4].trim()).toString())*-1+","+Double.parseDouble((icbankpayment[6].trim().equalsIgnoreCase("undefined") || icbankpayment[6].trim().equalsIgnoreCase("NaN") || icbankpayment[6].trim().isEmpty()?0:icbankpayment[6].trim()).toString())*-1+","
									 + "0,"+(id*-1)+",3,"+rowsno+","+lapply+","+cldocno+","+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+",'ICBP','"+(icbankpayment[11].trim().equalsIgnoreCase("undefined") || icbankpayment[11].trim().equalsIgnoreCase("NaN") || icbankpayment[11].trim().equalsIgnoreCase("") || icbankpayment[11].trim().equalsIgnoreCase("0") || icbankpayment[11].trim().isEmpty()?"0":icbankpayment[11].trim()).toString()+"',"
									 + "'"+intrCmpid+"',"+itranNo+",3)";
							 int data6 = stmtICBP1.executeUpdate(sql12);
							 if(data6<=0){
								   stmtICBP1.close();
								   conn.close();
								   return 0;
							 }
							 
						} else {
							
							String sql12="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icbankpaymentDate+"','"+txtrefno+"','"+docno+"','"+(icbankpayment[0].trim().equalsIgnoreCase("undefined") || icbankpayment[0].trim().equalsIgnoreCase("NaN") || icbankpayment[0].trim().isEmpty()?0:icbankpayment[0].trim()).toString()+"',"
									 + "'"+(icbankpayment[5].trim().equalsIgnoreCase("undefined") || icbankpayment[5].trim().equalsIgnoreCase("NaN") || icbankpayment[5].trim().isEmpty()?0:icbankpayment[5].trim()).toString()+"',"
									 + "'"+(icbankpayment[1].trim().equalsIgnoreCase("undefined") || icbankpayment[1].trim().equalsIgnoreCase("NaN") || icbankpayment[1].trim().isEmpty()?0:icbankpayment[1].trim()).toString()+"','"+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icbankpayment[4].trim().equalsIgnoreCase("undefined") || icbankpayment[4].trim().equalsIgnoreCase("NaN") || icbankpayment[4].trim().isEmpty()?0:icbankpayment[4].trim()).toString())+","+Double.parseDouble((icbankpayment[6].trim().equalsIgnoreCase("undefined") || icbankpayment[6].trim().equalsIgnoreCase("NaN") || icbankpayment[6].trim().isEmpty()?0:icbankpayment[6].trim()).toString())+","
									 + "0,"+id+",3,"+rowsno+","+lapply+","+cldocno+","+(icbankpayment[2].trim().equalsIgnoreCase("undefined") || icbankpayment[2].trim().equalsIgnoreCase("NaN") || icbankpayment[2].trim().equals(0) || icbankpayment[2].trim().isEmpty()?1:icbankpayment[2].trim()).toString()+",'ICBP','"+(icbankpayment[11].trim().equalsIgnoreCase("undefined") || icbankpayment[11].trim().equalsIgnoreCase("NaN") || icbankpayment[11].trim().equalsIgnoreCase("") || icbankpayment[11].trim().equalsIgnoreCase("0") || icbankpayment[11].trim().isEmpty()?"0":icbankpayment[11].trim()).toString()+"',"
									 + "'"+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"0":icbankpayment[12].trim()).toString()+"',"+trno+",3)";
							 int data7 = stmtICBP1.executeUpdate(sql12);
							 if(data7<=0){
								   stmtICBP1.close();
								   conn.close();
								   return 0;
							 }
						}
						
					} else {
						
						 if(mode.equalsIgnoreCase("A")) {
							 
							 String sql13="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICBP', '"+(icbankpayment[12].trim().equalsIgnoreCase("undefined") || icbankpayment[12].trim().equalsIgnoreCase("NaN") || icbankpayment[12].trim().equalsIgnoreCase("") || icbankpayment[12].trim().equalsIgnoreCase("0") || icbankpayment[12].trim().isEmpty()?"1":icbankpayment[12].trim()).toString()+"', "+trno+")";
							 int data7 = stmtICBP1.executeUpdate(sql13);
							 if(data7<=0){
								 stmtICBP1.close();
								 conn.close();
								 return 0;
							 }
							 
						 }
						 
					}
					
					/*Inter Company Transfer Ends*/
						
				 String sql14="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(icbankpayment[0].trim().equalsIgnoreCase("undefined") || icbankpayment[0].trim().equalsIgnoreCase("NaN") || icbankpayment[0].trim().isEmpty()?0:icbankpayment[0].trim());
				 ResultSet resultSet2 = stmtICBP1.executeQuery(sql14);
				    
				 while (resultSet2.next()) {
					 trid = resultSet2.getInt("TRANID");
				 }
				
				 if(!icbankpayment[8].trim().equalsIgnoreCase("0") && !icbankpayment[8].trim().equalsIgnoreCase("")){
					 String sql15="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(icbankpayment[0].trim().equalsIgnoreCase("undefined") || icbankpayment[0].trim().equalsIgnoreCase("NaN") || icbankpayment[0].trim().isEmpty()?0:icbankpayment[0].trim())+","
					 		+ ""+(icbankpayment[8].trim().equalsIgnoreCase("undefined") || icbankpayment[8].trim().equalsIgnoreCase("NaN") || icbankpayment[8].trim().equalsIgnoreCase("") || icbankpayment[8].trim().isEmpty()?0:icbankpayment[8].trim())+","
					 	    + ""+(icbankpayment[6].trim().equalsIgnoreCase("undefined") || icbankpayment[6].trim().equalsIgnoreCase("NaN") || icbankpayment[6].trim().isEmpty()?0:icbankpayment[6].trim())+","+i+","
					 	    + ""+(icbankpayment[9].trim().equalsIgnoreCase("undefined") || icbankpayment[9].trim().equalsIgnoreCase("NaN") || icbankpayment[9].trim().isEmpty()?0:icbankpayment[9].trim())+","+trid+","+trno+")";
					 int data2 = stmtICBP1.executeUpdate(sql15);
					 if(data2<=0){
						    stmtICBP1.close();
							conn.close();
							return 0;
						  }
					 
					 String sql16="update my_jvtran set costtype="+(icbankpayment[8].trim().equalsIgnoreCase("undefined") || icbankpayment[8].trim().equalsIgnoreCase("NaN") || icbankpayment[8].trim().equalsIgnoreCase("") || icbankpayment[8].trim().isEmpty()?0:icbankpayment[8].trim())+","
					 		+ "costcode="+(icbankpayment[9].trim().equalsIgnoreCase("undefined") || icbankpayment[9].trim().equalsIgnoreCase("NaN") || icbankpayment[9].trim().isEmpty()?0:icbankpayment[9].trim())+" where tranid="+trid+"";
					 int data3 = stmtICBP1.executeUpdate(sql16);
					 if(data3<=0){
						    stmtICBP1.close();
							conn.close();
							return 0;
						  }
				 	 }	
				   }
			    }
			    /*Ic Bank Payment Grid and Details Saving Ends*/
				
				/*Deleting account of value zero*/
				String sql17=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtICBP1.executeUpdate(sql17);
			     
			    String sql18=("DELETE FROM my_chqbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtICBP1.executeUpdate(sql18);
			    /*Deleting account of value zero ends*/
			    
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
