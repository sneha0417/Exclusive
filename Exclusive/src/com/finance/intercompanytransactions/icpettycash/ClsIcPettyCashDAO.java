package com.finance.intercompanytransactions.icpettycash;

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

public class ClsIcPettyCashDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsApplyDelete applyDeleteDAO = new ClsApplyDelete();
	ClsIcPettyCashBean icPettyCashBean = new ClsIcPettyCashBean();
	
	  public int insert(Date icPettyCashDate, String formdetailcode, String txtrefno,double txtrate,double txtamount, String txtdescription, ArrayList<String> icpettycasharray,
			  HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		  	
		  	Connection conn = null;
		  	
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtPC = conn.prepareCall("{CALL icCashbmDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtPC.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtPC.registerOutParameter(11, java.sql.Types.INTEGER);
			
			stmtPC.setDate(1,icPettyCashDate);
			stmtPC.setString(2,txtrefno);
			stmtPC.setString(3,txtdescription);
			stmtPC.setDouble(4,txtamount);
			stmtPC.setDouble(5,txtrate);
			stmtPC.setString(6,formdetailcode);
			stmtPC.setString(7,company);
			stmtPC.setString(8,branch);
			stmtPC.setString(9,userid);
			stmtPC.setString(12,mode);
			int datas=stmtPC.executeUpdate();
			if(datas<=0){
				stmtPC.close();
				conn.close();
				return 0;
			}
			int docno=stmtPC.getInt("docNo");
			int trno=stmtPC.getInt("itranNo");
			request.setAttribute("tranno", trno);
			icPettyCashBean.setTxticpettycashdocno(docno);
			if (docno > 0) {
				/*Insertion to intercompany.my_intrcmptrno,my_cashbd,my_jvtran,my_outd*/
				int insertData=insertion(conn, docno, trno, formdetailcode, icPettyCashDate, txtrefno, txtrate, txtdescription, txtamount, icpettycasharray, session,mode);
				if(insertData<=0){
					stmtPC.close();
					conn.close();
					return 0;
				}
				/*Insertion to intercompany.my_intrcmptrno,my_cashbd,my_jvtran,my_outd Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtPC.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }

				 if(total == 0){
					conn.commit();
					stmtPC.close();
					conn.close();
					return docno;
				 } else {
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtPC.close();
					    return 0;
				 }
			}
			
			stmtPC.close();
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
			
	
	public boolean edit(int txtpettycashdocno, String formdetailcode, Date pettyCashDate,String txtrefno, String txtdescription, double txtrate, double txtamount, 
			int txtdocno, int txttrno, ArrayList<String> pettycasharray,
			HttpSession session,String mode) throws SQLException {
		
		 	Connection conn = null;
		 	
		 try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtPC = conn.createStatement();
				Statement stmtPC1 = conn.createStatement();
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttrno,total=0;
			    
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Applying Delete*/
				applyDeleteDAO.getFinanceApplyDelete(conn, trno);
				/*Applying Delete Ends*/
				
				/*Updating my_cashbm*/
                String sql=("update my_cashbm set date='"+pettyCashDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+txtamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtpettycashdocno);
                int data = stmtPC.executeUpdate(sql);
				if(data<=0){
					conn.close();
					return false;
				}
				/*Updating my_cashbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtPC.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
				
				String sql3="select ic.tr_no,cp.dbname from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where ic.dtype='ICPC' and ic.doc_no="+txtpettycashdocno+"";
				ResultSet resultSet3 = stmtPC.executeQuery(sql3);
			    
				 while (resultSet3.next()) {
					String dbname=resultSet3.getString("dbname");
					int transno=resultSet3.getInt("tr_no");
					
					String sql4=("DELETE FROM "+dbname+".my_cashbd WHERE TR_NO="+transno+"");
				    int data4 = stmtPC1.executeUpdate(sql4);
				    
				    String sql5=("DELETE FROM "+dbname+".my_jvtran WHERE TR_NO="+transno+"");
				    int data5 = stmtPC1.executeUpdate(sql5);
				    
				    String sql6=("DELETE FROM "+dbname+".my_costtran WHERE TR_NO="+transno+"");
				    int data6 = stmtPC1.executeUpdate(sql6);
				    
				 }
				 
			    int docno=txtpettycashdocno;
			    icPettyCashBean.setTxticpettycashdocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_cashbd,my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, pettyCashDate, txtrefno, txtrate, txtdescription, txtamount, pettycasharray, session,mode);
					if(insertData<=0){
						stmtPC.close();
						conn.close();
						return false;
					}
					/*Insertion to my_cashbd,my_jvtran Ends*/
					
					String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
					ResultSet resultSet = stmtPC.executeQuery(sql1);
				    
					 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
					 }
					 
					 if(total == 0){
						conn.commit();
						stmtPC.close();
						conn.close();
						return true;
					 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtPC.close();
					    return false;
				    }
				}
				stmtPC.close();
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
	
	public boolean editMaster(int txtpettycashdocno,  String formdetailcode, Date pettyCashDate,String txtrefno, String txtdescription, double txtrate, double txtamount, 
			int txtdocno, int txttrno, HttpSession session) throws SQLException {
		 	
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtPC = conn.createStatement();

			int trno = txttrno;
		
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_cashbm*/
            String sql=("update my_cashbm set date='"+pettyCashDate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+txtamount+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtpettycashdocno);
			int data = stmtPC.executeUpdate(sql);
			if(data<=0){
				conn.close();
				return false;
			}
			/*Updating my_cashbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int data1 = stmtPC.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtPC.close();
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


	public boolean delete(int txtpettycashdocno, int txttrno, String formdetailcode,HttpSession session) throws SQLException {
		 
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtPC = conn.createStatement();
				Statement stmtPC1 = conn.createStatement();
				Statement stmtPC2 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttrno;
					
                /*Applying Delete*/
				applyDeleteDAO.getFinanceApplyDelete(conn, trno);
				/*Applying Delete Ends*/
				
				 /*Status change in my_cashbm*/
				 String sql=("update my_cashbm set STATUS=7 where doc_no="+txtpettycashdocno+" and TR_NO="+trno+"");
				 int data = stmtPC.executeUpdate(sql);
				/*Status change in my_cashbm Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtPC.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				 String sql1="select ic.tr_no,cp.dbname from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where ic.dtype='ICPC'  and ic.doc_no="+txtpettycashdocno+"";
				 ResultSet resultSet1 = stmtPC.executeQuery(sql1);
				    
				 while (resultSet1.next()) {
					String dbname=resultSet1.getString("dbname");
					int transno=resultSet1.getInt("tr_no");
					
					/*Status change in my_jvtran*/
				    String sql2=("update "+dbname+".my_jvtran set STATUS=7 where doc_no="+txtpettycashdocno+" and dtype='ICPC'");
					int data2 = stmtPC1.executeUpdate(sql2);
					/*Status change in my_jvtran Ends*/
					
					/*Status change in my_intrcmptrno*/
					 String sql3=("update intercompany.my_intrcmptrno set STATUS=7 where dtype='ICPC' and doc_no="+txtpettycashdocno+" and TR_NO="+transno+"");
					 int data3 = stmtPC2.executeUpdate(sql3);
					/*Status change in my_intrcmptrno Ends*/
				    
				 }
				 
				int docno=txtpettycashdocno;
				icPettyCashBean.setTxticpettycashdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtPC.close();
					stmtPC1.close();
					stmtPC2.close();
				    conn.close();
					return true;
				}	
				stmtPC.close();
				stmtPC1.close();
				stmtPC2.close();
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
	
	public JSONArray accountsDetails(HttpSession session) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
	    try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
				
				String branch = session.getAttribute("BRANCHID").toString();
			    String company = session.getAttribute("COMPANYID").toString();
            	
				String sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate from my_head t,"
            			+ "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
            			+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='604'";
				
            	ResultSet resultSet = stmtPC.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
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
	
	public JSONArray interCompanyBranchSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();

				String sql="select CONCAT(compname,' / ',branchname) intercompname,compname,branchname,dbname,brhid,cmpid,doc_no from intercompany.my_intrcomp where status=3 order by cmpid";
				
				ResultSet resultSet = stmtPC.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray applyInvoicingGrid(String accountno,String atype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
				
            	String condition="";
            	String sql="";
            	
            	if(!(atype==null || atype.equalsIgnoreCase(""))){
					if(atype.equalsIgnoreCase("AR")){
						condition="and t1.dramount > 0";
					}
					else if(atype.equalsIgnoreCase("AP")){
						condition="and t1.dramount < 0";
					}
            	}
            	
            		sql = "Select t1.doc_no,t1.acno,t1.tranid,t1.date,t1.out_amount,t1.dtype,t1.curid currency,t1.description, "
						+ "(if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- t1.out_amount) tramt from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join "
						+ "my_head h on t1.acno=h.doc_no where t1.acno="+accountno+" "+condition+" and (t1.dramount - out_amount) != 0 group by t1.tranid";
            	
            	
				ResultSet resultSet = stmtPC.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray applyInvoicingGridReloading(String trno,String accountno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
		
        Connection conn = null; 
        		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
				
				if(!(trno.trim().equalsIgnoreCase("0")||trno.trim().equalsIgnoreCase("") && accountno.trim().equalsIgnoreCase("0")||accountno.trim().equalsIgnoreCase(""))){
            	
				String sql="select t.doc_no doc_no,t.dtype dtype,t.description description,t.date date,(t.dramount-t.out_amount+d.amount) tramt,"
						+ "d.amount applying,(t.dramount-t.out_amount) balance,t.out_amount,t.tranid,t.acno,t.curId currency from my_outd d "
						+ "left join my_jvtran t on d.ap_trid=t.tranid where d.tranid=(SELECT tranid FROM my_jvtran where TR_NO='"+trno+"'  and acno='"+accountno+"')";
				
				ResultSet resultSet = stmtPC.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
				conn.close();
				}
			stmtPC.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray pettyCashGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
				Statement stmtPC = conn.createStatement();
				Statement stmtPC1 = conn.createStatement();
				
				String sql = "select d.brhid,ic.dbname FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE "
						+ "m.dtype='ICPC' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO>0";
				
				ResultSet resultSet = stmtPC.executeQuery (sql);
				
				int srno=1;
				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
				while(resultSet.next()){
					String dbname=resultSet.getString("dbname");
					
					String sql1="SELECT m.date,m.RefNo,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,"
							+ "d.rate rate,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup,CONCAT(ic.compname,' / ',ic.branchname) compbranch,"
							+ "d.brhid intrcompid,ic.dbname,ic.brhid intrbrhid FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join "+dbname+".my_costunit f on d.costtype=f.costtype left join "+dbname+".my_head t on "
							+ "d.acno=t.doc_no left join "+dbname+".my_curr c on c.doc_no=d.curId left join intercompany.my_intrcomp ic on ic.doc_no=d.brhid WHERE m.dtype='ICPC' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO="+srno+"";
					
					ResultSet resultSet1 = stmtPC1.executeQuery(sql1);
					
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
						temp.add(resultSet1.getString("amount1"));
						temp.add(resultSet1.getString("baseamount1"));
						temp.add(resultSet1.getString("description"));
						temp.add(resultSet1.getString("grtype"));
						temp.add(resultSet1.getString("sr_no"));
						temp.add(resultSet1.getString("currencytype"));
						temp.add(resultSet1.getString("dbname"));
						temp.add(resultSet1.getString("intrbrhid"));
						
						analysisrowarray.add(temp);
						srno++;
					}
					
		        }

				RESULTDATA=convertRowArrayToJSON(analysisrowarray);
				
				stmtPC.close();
				stmtPC1.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray icPettyCashGridSearch(String type,String database,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
			if(!(check.equalsIgnoreCase("1"))) {
	        	return RESULTDATA;
	        }
			
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtPC = conn.createStatement();
		
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
			        
			       ResultSet resultSet = stmtPC.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
		        stmtPC.close();
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
				Statement stmtPC = conn.createStatement ();
				
				ResultSet resultSet = stmtPC.executeQuery ("select costtype,costgroup from "+database+".my_costunit where status=1");
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtPC.close();
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
				Statement stmtVehclr = conn.createStatement ();
			
				/* Cost Center */
	        	if(type.equalsIgnoreCase("1"))
	        	{
	        		String sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from "+database+".my_ccentre c1 left join "+database+".my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
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
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* Call Register */
	        	else if(type.equalsIgnoreCase("5"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name from "+database+".cm_cuscallm m left join "+database+".my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* Fleet */
	        	else if(type.equalsIgnoreCase("6"))
	        	{
	        		String sql="select doc_no,fleet_no code,flname name,reg_no from "+database+".gl_vehmaster where cost=0";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
	        	/* IJCE */
	        	else if(type.equalsIgnoreCase("7"))
	        	{
	        		String sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from "+database+".is_jobmaster m left join "+database+".my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join "+database+".is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'";
	        		ResultSet resultSet = stmtVehclr.executeQuery (sql);
	        		RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtVehclr.close();
					conn.close();
	        	}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	    return RESULTDATA;
	}
	
	
	public JSONArray icpcMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String check) throws SQLException {

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
        
         String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlPaymentDate=null;
        
     try {
	        conn = connDAO.getMyConnection();
	        Statement stmtPC = conn.createStatement();

	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlPaymentDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and h.description like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.totalAmount like '%"+amount+"%'";
	        }
	        if(!(sqlPaymentDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlPaymentDate+"'";
		        } 
	        
	       ResultSet resultSet = stmtPC.executeQuery("select m.date,m.doc_no,m.totalAmount amount,if(h.description is null,' ',h.description) description from  my_cashbm m "
	       		+ "left join my_cashbd d on m.tr_no=d.tr_no and d.sr_no=0 left join my_head h on d.acno=h.doc_no left join my_brch b on m.brhid=b.doc_no where  m.brhid="+branch+" "
	       		+ "and m.dtype='ICPC' and m.status <> 7" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       stmtPC.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
		 conn.close();
	 }
         return RESULTDATA;
    }
	
	 public ClsIcPettyCashBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		ClsIcPettyCashBean icPettyCashBean = new ClsIcPettyCashBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtPC.executeQuery ("SELECT m.date,m.RefNo,t.account,t.description,t.doc_no accno,d.curId,d.rate,(d.AMOUNT*d.dr) amount,(d.lamount*d.dr) lamount,"
				+ "m.DESC1,d.SR_NO,d.TR_NO,j.tranid,c.type FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_jvtran j on d.tr_no=j.tr_no left join my_head t on "
				+ "d.acno=t.doc_no left join my_curr c on d.curId=c.doc_no WHERE m.dtype='ICPC' and d.sr_no=0 and m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" group by account");

			while (resultSet.next()) {
				icPettyCashBean.setTxticpettycashdocno(docNo);
				icPettyCashBean.setIcPettyCashDate(resultSet.getDate("date").toString());
				icPettyCashBean.setTxtrefno(resultSet.getString("RefNo"));
				icPettyCashBean.setTxttranid(resultSet.getInt("tranid"));
				icPettyCashBean.setTxttrno(resultSet.getInt("TR_NO"));
				
				icPettyCashBean.setTxtdocno(resultSet.getInt("accno"));
				icPettyCashBean.setTxtaccid(resultSet.getString("account"));
				icPettyCashBean.setTxtaccname(resultSet.getString("description"));
				icPettyCashBean.setHidcmbcurrency(resultSet.getString("curId"));
				icPettyCashBean.setHidcurrencytype(resultSet.getString("type"));
				icPettyCashBean.setTxtrate(resultSet.getDouble("rate"));
				icPettyCashBean.setTxtamount(resultSet.getDouble("amount"));
				icPettyCashBean.setTxtbaseamount(resultSet.getDouble("lamount"));
				icPettyCashBean.setTxtdescription(resultSet.getString("DESC1"));
				icPettyCashBean.setMaindate(resultSet.getDate("date").toString());
		    }
		 stmtPC.close();
		 conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
		return icPettyCashBean;
		}

	public ClsIcPettyCashBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsIcPettyCashBean bean = new ClsIcPettyCashBean();
		 Connection conn = null;
		 
		try {
			
			conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
			
			String headersql="select if(m.dtype='ICPC','IC Petty Cash','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_cashbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='ICPC' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtPC.executeQuery(headersql);
				
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
			
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,round(m.totalAmount,2) netAmount,u.user_name from my_cashbm m left join my_user u on "
						+ "m.userid=u.doc_no where m.dtype='ICPC' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtPC.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldescription(resultSets.getString("desc1"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLbldebittotal(resultSets.getString("netAmount"));
				bean.setLblcredittotal(resultSets.getString("netAmount"));
				
				bean.setLblpreparedby(resultSets.getString("user_name"));
			}
			
			bean.setTxtheader(header);
			
			String sql="select round(m.totalAmount,2) netAmount,h.description from my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no left join my_head h on "
				+ "d.acno=h.doc_no where m.dtype='ICPC' and d.sr_no=0 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet = stmtPC.executeQuery(sql);

			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				
				bean.setLblname(resultSet.getString("description"));
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
			}

			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,c.code currency,d.description,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit FROM my_cashbm m left join my_cashbd d on m.tr_no=d.tr_no "
				+ "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='ICPC' and m.brhid="+branch+" and m.doc_no="+docNo+" order by d.amount desc";
			
			ResultSet resultSet1 = stmtPC.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_cashbm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='ICPC' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet2 = stmtPC.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}
		
			stmtPC.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
		return bean;
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
		   obj.put("amount1",analysisRowArray.get(12));
		   obj.put("baseamount1",analysisRowArray.get(13));
		   obj.put("description",analysisRowArray.get(14));
		   obj.put("grtype",analysisRowArray.get(15));
		   obj.put("sr_no",analysisRowArray.get(16));
		   obj.put("currencytype",analysisRowArray.get(17));
		   obj.put("dbname",analysisRowArray.get(18));
		   obj.put("intrbrhid",analysisRowArray.get(19));

		   jsonArray.add(obj);
		  }
		  return jsonArray;
		  }
	 
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date icPettyCashDate, String txtrefno, double txtrate, 
			 String txtdescription, double txtamount, ArrayList<String> icpettycasharray, HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtPC;
				Statement stmtPC1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Ic Petty Cash Grid and Details Saving*/
				for(int i=0;i< icpettycasharray.size();i++){
					String[] icpettycash=icpettycasharray.get(i).split("::");
					if(!icpettycash[0].trim().equalsIgnoreCase("undefined") && !icpettycash[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0,trid = 0;
					int id = 0;
					if(icpettycash[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(icpettycash[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					
					stmtPC = conn.prepareCall("{CALL icCashbdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_cashbd*/
					stmtPC.setInt(22,trno); 
					stmtPC.setInt(23,docno);
					stmtPC.registerOutParameter(24, java.sql.Types.INTEGER);
					
					stmtPC.setInt(1,i); //SR_NO
					stmtPC.setString(2,(icpettycash[0].trim().equalsIgnoreCase("undefined") || icpettycash[0].trim().equalsIgnoreCase("NaN") || icpettycash[0].trim().isEmpty()?0:icpettycash[0].trim()).toString());  //doc_no of my_head
					stmtPC.setString(3,(icpettycash[1].trim().equalsIgnoreCase("undefined") || icpettycash[1].trim().equalsIgnoreCase("NaN") || icpettycash[1].trim().isEmpty()?0:icpettycash[1].trim()).toString()); //curId
					stmtPC.setString(4,(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()); //rate 
					stmtPC.setInt(5,id); //#credit -1 / debit 1 
					stmtPC.setString(6,(icpettycash[4].trim().equalsIgnoreCase("undefined") || icpettycash[4].trim().equalsIgnoreCase("NaN") || icpettycash[4].trim().isEmpty()?0:icpettycash[4].trim()).toString()); //amount
					stmtPC.setString(7,(icpettycash[5].trim().equalsIgnoreCase("undefined") || icpettycash[5].trim().equalsIgnoreCase("NaN") || icpettycash[5].trim().isEmpty()?0:icpettycash[5].trim()).toString()); //description
					stmtPC.setString(8,(icpettycash[6].trim().equalsIgnoreCase("undefined") || icpettycash[6].trim().equalsIgnoreCase("NaN") || icpettycash[6].trim().isEmpty()?0:icpettycash[6].trim()).toString()); //baseamount
					stmtPC.setInt(9,cash); //For cash = 0/ party = 1
					stmtPC.setString(10,(icpettycash[8].trim().equalsIgnoreCase("undefined") || icpettycash[8].trim().equalsIgnoreCase("NaN") || icpettycash[8].trim().equalsIgnoreCase("") || icpettycash[8].trim().equalsIgnoreCase("0") || icpettycash[8].trim().isEmpty()?0:icpettycash[8].trim()).toString()); //Cost type
					stmtPC.setString(11,(icpettycash[9].trim().equalsIgnoreCase("undefined") || icpettycash[9].trim().equalsIgnoreCase("NaN") || icpettycash[9].trim().equalsIgnoreCase("") || icpettycash[9].trim().equalsIgnoreCase("0") || icpettycash[9].trim().isEmpty()?0:icpettycash[9].trim()).toString()); //Cost Code
					/*my_cashbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtPC.setDate(12,icPettyCashDate);
					stmtPC.setString(13,txtrefno);
					stmtPC.setInt(14,id);  //id
					stmtPC.setString(15,(icpettycash[7].trim().equalsIgnoreCase("undefined") || icpettycash[7].trim().equalsIgnoreCase("NaN") || icpettycash[7].trim().isEmpty()?0:icpettycash[7].trim()).toString());  //out-amount
					/*my_jvtran Ends*/
					
					stmtPC.setString(16,formdetailcode);
					stmtPC.setString(17,(icpettycash[10].trim().equalsIgnoreCase("undefined") || icpettycash[10].trim().equalsIgnoreCase("NaN") || icpettycash[10].trim().equalsIgnoreCase("") || icpettycash[10].trim().equalsIgnoreCase("0") || icpettycash[10].trim().isEmpty()?" ":icpettycash[10].trim()).toString()); //Database Name
					stmtPC.setString(18,(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"1":icpettycash[12].trim()).toString()); //Inter-Company
					stmtPC.setString(19,(icpettycash[13].trim().equalsIgnoreCase("undefined") || icpettycash[13].trim().equalsIgnoreCase("NaN") || icpettycash[13].trim().equalsIgnoreCase("") || icpettycash[13].trim().equalsIgnoreCase("0") || icpettycash[13].trim().isEmpty()?"1":icpettycash[13].trim()).toString()); //Main-Company
					stmtPC.setString(20,(icpettycash[11].trim().equalsIgnoreCase("undefined") || icpettycash[11].trim().equalsIgnoreCase("NaN") || icpettycash[11].trim().equalsIgnoreCase("") || icpettycash[11].trim().equalsIgnoreCase("0") || icpettycash[11].trim().isEmpty()?"1":icpettycash[11].trim()).toString()); //Inter-Branch
					stmtPC.setString(21,userid);
					stmtPC.setString(25,mode);
					int detail=stmtPC.executeUpdate();
					int rowsno=stmtPC.getInt("irowsNo");
				    if(detail<=0){
						stmtPC.close();
						conn.close();
						return 0;
				    }
					
					/*Inter Company Transfer*/
					if(i!=0) {
						
						int accountDocNo=0,cldocno=0,lapply=0;
						String sql3="Select h.doc_no as accountDocNo from my_head h INNER JOIN intercompany.my_intrcmp c ON (c.doc_no=h.doc_no) left JOIN intercompany.my_intrcomp co ON (co.doc_no= c.cmp2) "  
								+ "left JOIN intercompany.my_intrcomp co1 ON (co1.doc_no= c.cmp1) where h.doc_no=c.doc_no and ((c.cmp1="+(icpettycash[13].trim().equalsIgnoreCase("undefined") || icpettycash[13].trim().equalsIgnoreCase("NaN") || icpettycash[13].trim().equalsIgnoreCase("") || icpettycash[13].trim().equalsIgnoreCase("0") || icpettycash[13].trim().isEmpty()?"1":icpettycash[13].trim()).toString()+" "
								+ "and  c.cmp2="+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"1":icpettycash[12].trim()).toString()+") or "
								+ "(c.cmp1="+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"1":icpettycash[12].trim()).toString()+" and  "
								+ "c.cmp2="+(icpettycash[13].trim().equalsIgnoreCase("undefined") || icpettycash[13].trim().equalsIgnoreCase("NaN") || icpettycash[13].trim().equalsIgnoreCase("") || icpettycash[13].trim().equalsIgnoreCase("0") || icpettycash[13].trim().isEmpty()?"1":icpettycash[13].trim()).toString()+"))";
						ResultSet resultSet2 = stmtPC1.executeQuery(sql3);
						    
						while (resultSet2.next()) {
							accountDocNo = resultSet2.getInt("accountDocNo");
						}
						
						String sql4="select cldocno,lapply from my_head where doc_no='"+(icpettycash[0].trim().equalsIgnoreCase("undefined") || icpettycash[0].trim().equalsIgnoreCase("NaN") || icpettycash[0].trim().isEmpty()?0:icpettycash[0].trim()).toString()+"'";
						ResultSet resultSet3 = stmtPC1.executeQuery(sql4);
						    
						while (resultSet3.next()) {
							cldocno = resultSet3.getInt("cldocno");
							lapply = resultSet3.getInt("lapply");
						}
						
						if(accountDocNo>0){
							
							String sql5="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icPettyCashDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"','"+(icpettycash[5].trim().equalsIgnoreCase("undefined") || icpettycash[5].trim().equalsIgnoreCase("NaN") || icpettycash[5].trim().isEmpty()?0:icpettycash[5].trim()).toString()+"',"
									 + "'"+(icpettycash[1].trim().equalsIgnoreCase("undefined") || icpettycash[1].trim().equalsIgnoreCase("NaN") || icpettycash[1].trim().isEmpty()?0:icpettycash[1].trim()).toString()+"','"+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icpettycash[4].trim().equalsIgnoreCase("undefined") || icpettycash[4].trim().equalsIgnoreCase("NaN") || icpettycash[4].trim().isEmpty()?0:icpettycash[4].trim()).toString())+","+Double.parseDouble((icpettycash[6].trim().equalsIgnoreCase("undefined") || icpettycash[6].trim().equalsIgnoreCase("NaN") || icpettycash[6].trim().isEmpty()?0:icpettycash[6].trim()).toString())+","
									 + "0,1,2,"+rowsno+","+lapply+","+cldocno+","+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+",'ICPC','"+session.getAttribute("BRANCHID").toString().trim()+"',"
									 + "'"+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"0":icpettycash[12].trim()).toString()+"',"+trno+",3)";
							int data3 = stmtPC1.executeUpdate(sql5);
							 if(data3<=0){
								   stmtPC1.close();
								   conn.close();
								   return 0;
							 }
						
							 int itranNo=0,idocNo=0,icmpId=0,intrCmpid=0;
							 
							 String sql6="select ic.tr_no,ic.doc_no,ic.cmpid from intercompany.my_intrcmptrno ic left join intercompany.my_intrcomp cp on ic.cmpid=cp.doc_no where "
									 + "cp.dbname='"+(icpettycash[10].trim().equalsIgnoreCase("undefined") || icpettycash[10].trim().equalsIgnoreCase("NaN") || icpettycash[10].trim().equalsIgnoreCase("") || icpettycash[10].trim().equalsIgnoreCase("0") || icpettycash[10].trim().isEmpty()?" ":icpettycash[10].trim()).toString()+"' "
									 + "and cp.cmpid=(select cmpid from intercompany.my_intrcomp where doc_no='"+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"1":icpettycash[12].trim()).toString()+"') "
									 + "and ic.dtype='ICPC' and ic.doc_no="+docno+"";
							 ResultSet resultSet6 = stmtPC1.executeQuery(sql6);
							    
							 while (resultSet6.next()) {
								itranNo = resultSet6.getInt("tr_no");
								idocNo = resultSet6.getInt("doc_no");
								icmpId = resultSet6.getInt("cmpid");
							 }
							 
							 if(itranNo==0) {
								 
								 String sql7="select coalesce((max(trno)+1),1) as itranNo from "+(icpettycash[10].trim().equalsIgnoreCase("undefined") || icpettycash[10].trim().equalsIgnoreCase("NaN") || icpettycash[10].trim().equalsIgnoreCase("") || icpettycash[10].trim().equalsIgnoreCase("0") || icpettycash[10].trim().isEmpty()?" ":icpettycash[10].trim()).toString()+".my_trno";
								 ResultSet resultSet7 = stmtPC1.executeQuery(sql7);
								    
								 while (resultSet7.next()) {
									itranNo = resultSet7.getInt("itranNo");
								 }
								 
								 String sql8="insert into "+(icpettycash[10].trim().equalsIgnoreCase("undefined") || icpettycash[10].trim().equalsIgnoreCase("NaN") || icpettycash[10].trim().equalsIgnoreCase("") || icpettycash[10].trim().equalsIgnoreCase("0") || icpettycash[10].trim().isEmpty()?" ":icpettycash[10].trim()).toString()+".my_trno(edate,trtype,brhId,USERNO,trno) values('"+icPettyCashDate+"',2,'"+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"1":icpettycash[12].trim()).toString()+"','"+userid+"',"+itranNo+")";
								 int data4 = stmtPC1.executeUpdate(sql8);
								 if(data4<=0){
									   stmtPC1.close();
									   conn.close();
									   return 0;
								 }
							 
							 }
							 
							 if(idocNo!=docno && icmpId!=Integer.parseInt(icpettycash[12].trim())){
								 String sql9="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICPC', '"+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"1":icpettycash[12].trim()).toString()+"', "+itranNo+")";								 
								 int data5 = stmtPC1.executeUpdate(sql9);
								 if(data5<=0){
									   stmtPC1.close();
									   conn.close();
									   return 0;
								 }
							 }
							 
							String sql10="insert into "+(icpettycash[10].trim().equalsIgnoreCase("undefined") || icpettycash[10].trim().equalsIgnoreCase("NaN") || icpettycash[10].trim().equalsIgnoreCase("") || icpettycash[10].trim().equalsIgnoreCase("0") || icpettycash[10].trim().isEmpty()?" ":icpettycash[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icPettyCashDate+"','"+txtrefno+"','"+docno+"','"+(icpettycash[0].trim().equalsIgnoreCase("undefined") || icpettycash[0].trim().equalsIgnoreCase("NaN") || icpettycash[0].trim().isEmpty()?0:icpettycash[0].trim()).toString()+"',"
									 + "'"+(icpettycash[5].trim().equalsIgnoreCase("undefined") || icpettycash[5].trim().equalsIgnoreCase("NaN") || icpettycash[5].trim().isEmpty()?0:icpettycash[5].trim()).toString()+"',"
									 + "'"+(icpettycash[1].trim().equalsIgnoreCase("undefined") || icpettycash[1].trim().equalsIgnoreCase("NaN") || icpettycash[1].trim().isEmpty()?0:icpettycash[1].trim()).toString()+"','"+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icpettycash[4].trim().equalsIgnoreCase("undefined") || icpettycash[4].trim().equalsIgnoreCase("NaN") || icpettycash[4].trim().isEmpty()?0:icpettycash[4].trim()).toString())+","+Double.parseDouble((icpettycash[6].trim().equalsIgnoreCase("undefined") || icpettycash[6].trim().equalsIgnoreCase("NaN") || icpettycash[6].trim().isEmpty()?0:icpettycash[6].trim()).toString())+","
									 + "0,1,2,"+rowsno+","+lapply+","+cldocno+","+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+",'ICPC','"+(icpettycash[11].trim().equalsIgnoreCase("undefined") || icpettycash[11].trim().equalsIgnoreCase("NaN") || icpettycash[11].trim().equalsIgnoreCase("") || icpettycash[11].trim().equalsIgnoreCase("0") || icpettycash[11].trim().isEmpty()?"0":icpettycash[11].trim()).toString()+"',"
									 + "'"+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"0":icpettycash[12].trim()).toString()+"',"+itranNo+",3)";
							 int data5 = stmtPC1.executeUpdate(sql10);
							 if(data5<=0){
								   stmtPC1.close();
								   conn.close();
								   return 0;
							 }
							 
							 String sql11="SELECT doc_no FROM intercompany.my_intrcomp WHERE cmpid='"+session.getAttribute("COMPANYID").toString().trim()+"' and brhid='"+session.getAttribute("BRANCHID").toString().trim()+"'";
							 ResultSet resultSet11 = stmtPC1.executeQuery(sql11);
							 while (resultSet11.next()) {
								 intrCmpid = resultSet11.getInt("doc_no");
							 }
							 
							 String sql12="insert into "+(icpettycash[10].trim().equalsIgnoreCase("undefined") || icpettycash[10].trim().equalsIgnoreCase("NaN") || icpettycash[10].trim().equalsIgnoreCase("") || icpettycash[10].trim().equalsIgnoreCase("0") || icpettycash[10].trim().isEmpty()?" ":icpettycash[10].trim()).toString()+".my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icPettyCashDate+"','"+txtrefno+"','"+docno+"','"+accountDocNo+"','"+(icpettycash[5].trim().equalsIgnoreCase("undefined") || icpettycash[5].trim().equalsIgnoreCase("NaN") || icpettycash[5].trim().isEmpty()?0:icpettycash[5].trim()).toString()+"',"
									 + "'"+(icpettycash[1].trim().equalsIgnoreCase("undefined") || icpettycash[1].trim().equalsIgnoreCase("NaN") || icpettycash[1].trim().isEmpty()?0:icpettycash[1].trim()).toString()+"','"+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icpettycash[4].trim().equalsIgnoreCase("undefined") || icpettycash[4].trim().equalsIgnoreCase("NaN") || icpettycash[4].trim().isEmpty()?0:icpettycash[4].trim()).toString())*-1+","+Double.parseDouble((icpettycash[6].trim().equalsIgnoreCase("undefined") || icpettycash[6].trim().equalsIgnoreCase("NaN") || icpettycash[6].trim().isEmpty()?0:icpettycash[6].trim()).toString())*-1+","
									 + "0,-1,2,"+rowsno+","+lapply+","+cldocno+","+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+",'ICPC','"+(icpettycash[11].trim().equalsIgnoreCase("undefined") || icpettycash[11].trim().equalsIgnoreCase("NaN") || icpettycash[11].trim().equalsIgnoreCase("") || icpettycash[11].trim().equalsIgnoreCase("0") || icpettycash[11].trim().isEmpty()?"1":icpettycash[11].trim()).toString()+"',"
									 + "'"+intrCmpid+"',"+itranNo+",3)";
							 int data6 = stmtPC1.executeUpdate(sql12);
							 if(data6<=0){
								   stmtPC1.close();
								   conn.close();
								   return 0;
							 }
							 
						} else {
							
							String sql12="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,intrcmpid,tr_no,STATUS) "
									 + "values('"+icPettyCashDate+"','"+txtrefno+"','"+docno+"','"+(icpettycash[0].trim().equalsIgnoreCase("undefined") || icpettycash[0].trim().equalsIgnoreCase("NaN") || icpettycash[0].trim().isEmpty()?0:icpettycash[0].trim()).toString()+"',"
									 + "'"+(icpettycash[5].trim().equalsIgnoreCase("undefined") || icpettycash[5].trim().equalsIgnoreCase("NaN") || icpettycash[5].trim().isEmpty()?0:icpettycash[5].trim()).toString()+"',"
									 + "'"+(icpettycash[1].trim().equalsIgnoreCase("undefined") || icpettycash[1].trim().equalsIgnoreCase("NaN") || icpettycash[1].trim().isEmpty()?0:icpettycash[1].trim()).toString()+"','"+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+"',"
									 + ""+Double.parseDouble((icpettycash[4].trim().equalsIgnoreCase("undefined") || icpettycash[4].trim().equalsIgnoreCase("NaN") || icpettycash[4].trim().isEmpty()?0:icpettycash[4].trim()).toString())+","+Double.parseDouble((icpettycash[6].trim().equalsIgnoreCase("undefined") || icpettycash[6].trim().equalsIgnoreCase("NaN") || icpettycash[6].trim().isEmpty()?0:icpettycash[6].trim()).toString())+","
									 + "0,1,2,"+rowsno+","+lapply+","+cldocno+","+(icpettycash[2].trim().equalsIgnoreCase("undefined") || icpettycash[2].trim().equalsIgnoreCase("NaN") || icpettycash[2].trim().equals(0) || icpettycash[2].trim().isEmpty()?1:icpettycash[2].trim()).toString()+",'ICPC','"+(icpettycash[11].trim().equalsIgnoreCase("undefined") || icpettycash[11].trim().equalsIgnoreCase("NaN") || icpettycash[11].trim().equalsIgnoreCase("") || icpettycash[11].trim().equalsIgnoreCase("0") || icpettycash[11].trim().isEmpty()?"0":icpettycash[11].trim()).toString()+"',"
									 + "'"+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"0":icpettycash[12].trim()).toString()+"',"+trno+",3)";
							 int data7 = stmtPC1.executeUpdate(sql12);
							 if(data7<=0){
								   stmtPC1.close();
								   conn.close();
								   return 0;
							 }
						}
						
					} else {
						
						 if(mode.equalsIgnoreCase("A")) {
							 String sql13="insert into intercompany.my_intrcmptrno(doc_no, dtype, cmpid, tr_no) values('"+docno+"', 'ICPC', '"+(icpettycash[12].trim().equalsIgnoreCase("undefined") || icpettycash[12].trim().equalsIgnoreCase("NaN") || icpettycash[12].trim().equalsIgnoreCase("") || icpettycash[12].trim().equalsIgnoreCase("0") || icpettycash[12].trim().isEmpty()?"1":icpettycash[12].trim()).toString()+"', "+trno+")";
							 int data7 = stmtPC1.executeUpdate(sql13);
							 if(data7<=0){
								 stmtPC1.close();
								 conn.close();
								 return 0;
							 }
						 }
					}
					
					/*Inter Company Transfer Ends*/
						
				 String sql14="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(icpettycash[0].trim().equalsIgnoreCase("undefined") || icpettycash[0].trim().equalsIgnoreCase("NaN") || icpettycash[0].trim().isEmpty()?0:icpettycash[0].trim());
				 ResultSet resultSet2 = stmtPC1.executeQuery(sql14);
				    
				 while (resultSet2.next()) {
					 trid = resultSet2.getInt("TRANID");
				 }
				
				 if(!icpettycash[8].trim().equalsIgnoreCase("0") && !icpettycash[8].trim().equalsIgnoreCase("")){
					 String sql15="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(icpettycash[0].trim().equalsIgnoreCase("undefined") || icpettycash[0].trim().equalsIgnoreCase("NaN") || icpettycash[0].trim().isEmpty()?0:icpettycash[0].trim())+","
					 		+ ""+(icpettycash[8].trim().equalsIgnoreCase("undefined") || icpettycash[8].trim().equalsIgnoreCase("NaN") || icpettycash[8].trim().equalsIgnoreCase("") || icpettycash[8].trim().isEmpty()?0:icpettycash[8].trim())+","
					 	    + ""+(icpettycash[6].trim().equalsIgnoreCase("undefined") || icpettycash[6].trim().equalsIgnoreCase("NaN") || icpettycash[6].trim().isEmpty()?0:icpettycash[6].trim())+","+i+","
					 	    + ""+(icpettycash[9].trim().equalsIgnoreCase("undefined") || icpettycash[9].trim().equalsIgnoreCase("NaN") || icpettycash[9].trim().isEmpty()?0:icpettycash[9].trim())+","+trid+","+trno+")";
					 int data2 = stmtPC1.executeUpdate(sql15);
					 if(data2<=0){
						    stmtPC1.close();
							conn.close();
							return 0;
						  }
					 
					 String sql16="update my_jvtran set costtype="+(icpettycash[8].trim().equalsIgnoreCase("undefined") || icpettycash[8].trim().equalsIgnoreCase("NaN") || icpettycash[8].trim().equalsIgnoreCase("") || icpettycash[8].trim().isEmpty()?0:icpettycash[8].trim())+","
					 		+ "costcode="+(icpettycash[9].trim().equalsIgnoreCase("undefined") || icpettycash[9].trim().equalsIgnoreCase("NaN") || icpettycash[9].trim().isEmpty()?0:icpettycash[9].trim())+" where tranid="+trid+"";
					 int data3 = stmtPC1.executeUpdate(sql16);
					 if(data3<=0){
						    stmtPC1.close();
							conn.close();
							return 0;
						  }
				 	 }	
  				   }
			    }
			    /*Ic Petty Cash Grid and Details Saving Ends*/
				
				/*Deleting account of value zero*/
				String sql17=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtPC1.executeUpdate(sql17);
			     
			    String sql18=("DELETE FROM my_cashbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtPC1.executeUpdate(sql18);
			    /*Deleting account of value zero ends*/
			    
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
