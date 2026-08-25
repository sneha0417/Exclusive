package com.finance.transactions.multiplecashpurchase;

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
import com.common.ClsApplyDelete;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsmultipleCashPurchaseDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsApplyDelete applyDeleteDAO = new ClsApplyDelete();
	ClsmultipleCashPurchaseBean multipleCashPurchaseBean = new ClsmultipleCashPurchaseBean();
	
	  public int insert(Date mcpdate, String formdetailcode, String txtrefno,double txtrate,double txtamount, String txtdescription, ArrayList<String> mcparray,
			  HttpSession session,HttpServletRequest request,String mode,String vendorid, String tinno, String invno, Date invdate, String taxamt, String total1,int acno) throws SQLException {
		  	
		  	Connection conn = null;
		  	
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtPC = conn.prepareCall("{CALL mcpbmDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtPC.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtPC.registerOutParameter(11, java.sql.Types.INTEGER);
			
			stmtPC.setDate(1,mcpdate);
			//stmtPC.setString(2,txtrefno);
			stmtPC.setString(2,(txtrefno.trim().equalsIgnoreCase("undefined") || txtrefno.trim().equalsIgnoreCase("NaN") || txtrefno.trim().isEmpty()?0:txtrefno.trim()).toString());
			stmtPC.setString(3,txtdescription);
			stmtPC.setDouble(4,commonDAO.Round(txtamount,2));
			stmtPC.setDouble(5,txtrate);
			stmtPC.setString(6,formdetailcode);
			stmtPC.setString(7,company);
			stmtPC.setString(8,branch);
			stmtPC.setString(9,userid);
			stmtPC.setString(12,mode);
			stmtPC.setInt(13,acno);
			/*stmtPC.setString(13,vendorid);
			stmtPC.setString(14,tinno);
			stmtPC.setString(15,invno);
			stmtPC.setDate(16,invdate);
			stmtPC.setDouble(17,Double.parseDouble(taxamt));
			stmtPC.setDouble(18,Double.parseDouble(total1));*/
			
			int datas=stmtPC.executeUpdate();
			if(datas<=0){
				stmtPC.close();
				conn.close();
				return 0;
			}
			int docno=stmtPC.getInt("docNo");
			int trno=stmtPC.getInt("itranNo");
			request.setAttribute("tranno", trno);
			multipleCashPurchaseBean.setTxtpettycashdocno(docno);
			if (docno > 0) {
				
				int insertData=insertion(conn, docno, trno, formdetailcode, mcpdate, txtrefno, txtrate, txtdescription, txtamount, mcparray, session,mode,vendorid,tinno, invno,invdate,taxamt,total1);
				if(insertData<=0){
					stmtPC.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_cashbd,my_jvtran,my_outd Ends*/
					
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
				 }else{
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
			
	
	public boolean edit(int txtpettycashdocno, String formdetailcode, Date mcpdate,String txtrefno, String txtdescription, double txtrate, double txtamount, 
			int txtdocno, int txttrno, ArrayList<String> mcparray,
			HttpSession session,String mode,String vendorid, String tinno, String invno, Date invdate, String taxamt, String total1 ) throws SQLException {
		
		 	Connection conn = null;
		 	
		 try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtPC = conn.createStatement();
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
				
				/*Updating my_MCPbm*/
                String sql=("update my_mcpbm set date='"+mcpdate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+commonDAO.Round(txtamount,2)+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where TR_NO='"+trno+"' and doc_no="+txtpettycashdocno);
//                System.out.println("update query-->"+sql);
                int data = stmtPC.executeUpdate(sql);
				if(data<=0){
					conn.close();
					return false;
				}
				/*Updating my_MCPbm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtPC.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql3=("DELETE FROM my_mcpbm WHERE TR_NO="+trno+"");
//			    System.out.println("delete query sql3-->"+sql3);
			    int data3 = stmtPC.executeUpdate(sql3);
			    	 
				 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
//				 System.out.println("delete query sql4-->"+sql4);
				 int data4 = stmtPC.executeUpdate(sql4);
				 
				 String sql6=("DELETE FROM my_costtran WHERE TR_NO="+trno+"");
//				 System.out.println("delete query sql6-->"+sql6);
				 int data6 = stmtPC.executeUpdate(sql6);
			    			    
			    int docno=txtpettycashdocno;
			    multipleCashPurchaseBean.setTxtpettycashdocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_mcpbd,my_jvtran*/
					int insertData=insertion(conn, docno, trno, formdetailcode, mcpdate, txtrefno, txtrate, txtdescription, txtamount, mcparray, session,mode,vendorid,tinno,invno,invdate,taxamt,total1);
//					System.out.println("--insert call for mcpbd--"+insertData);
					if(insertData<=0){
						stmtPC.close();
						conn.close();
						return false;
					}
					/*Insertion to my_mcpbd,my_jvtran Ends*/
					
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
				        //System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
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
	
	public boolean editMaster(int txtpettycashdocno,  String formdetailcode, Date mcpdate,String txtrefno, String txtdescription, double txtrate, double txtamount, ArrayList<String> mcparray, HttpSession session,String mode, String vendorid, String tinno, String invno, Date invdate,
			int txtdocno, int txttrno, String taxamt, String total1, int docno ) throws SQLException {
//		System.out.println("in edit mass");
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtPC = conn.createStatement();

			int trno = txtdocno;  
		
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_mcpbm*/
            String sql=("update my_mcpbm set date='"+mcpdate+"',RefNo='"+txtrefno+"',DESC1='"+txtdescription+"',mrate='"+txtrate+"',trMode=2,totalAmount='"+commonDAO.Round(txtamount,2)+"',DTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"' where doc_no="+txtpettycashdocno);
//			System.out.println("update my_mcpbm---"+sql);
            int data = stmtPC.executeUpdate(sql);
			if(data<=0){
				conn.close();
				return false;
			}
			/*Updating my_mcpbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int data1 = stmtPC.executeUpdate(sqls);
			
			Statement stmtBPV=conn.createStatement();
			  
		    String sql3=("DELETE FROM my_mcpbd WHERE TR_NO="+trno);
		    int data12 = stmtBPV.executeUpdate(sql3);
		    
			ClsApplyDelete applyDelete = new ClsApplyDelete();
			int applydelete=applyDelete.getFinanceApplyDelete(conn, trno);
			if(applydelete<0){
				System.out.println("*** ERROR IN APPLY DELETE ***");
				stmtBPV.close();
				conn.close();
				return false;
			}
			 
			 String sql4=("DELETE FROM my_jvtran WHERE TR_NO="+trno);
			 int data3 = stmtBPV.executeUpdate(sql4);
			 
			 String sql6=("DELETE FROM my_costtran WHERE TR_NO="+trno);
			 int data6 = stmtBPV.executeUpdate(sql6);
		    
			// System.out.println("before insertion---");
			int insertData=insertion(conn, docno, trno, formdetailcode, mcpdate, txtrefno, txtrate, txtdescription, txtamount, mcparray, session,mode,vendorid,tinno,invno,invdate,taxamt,total1);
			// System.out.println("--insert call for mcpbd--"+insertData);
			if(insertData<=0){
				stmtPC.close();
				conn.close();
				return false;
			}
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
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				int trno = txttrno;
					
                /*Applying Delete*/
				applyDeleteDAO.getFinanceApplyDelete(conn, trno);
				/*Applying Delete Ends*/
				
				 /*Status change in my_mcpbm*/
				 String sql=("update my_mcpbm set STATUS=7 where doc_no="+txtpettycashdocno+" and TR_NO="+trno+"");
				 int data = stmtPC.executeUpdate(sql);
				/*Status change in my_mcpbm Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtpettycashdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtPC.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				
				/*Status change in my_jvtran*/
				 String sql1=("update my_jvtran set STATUS=7 where doc_no="+txtpettycashdocno+" and TR_NO="+trno+"");
				 int data1 = stmtPC.executeUpdate(sql1);
				/*Status change in my_jvtran Ends*/
				 
				int docno=txtpettycashdocno;
				multipleCashPurchaseBean.setTxtpettycashdocno(docno);
				if (docno > 0) {
					conn.commit();
					stmtPC.close();
				    conn.close();
					return true;
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
            			+ "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') and den='305'";
				
//				System.out.println("accdetails--> "+sql);
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
						+ "(if(t1.dramount<0,(t1.dramount*1),t1.dramount)- t1.out_amount) tramt from my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join "
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
				//System.out.println("gridreloading-->"+sql);
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
	
	
	public   JSONArray productSearch(HttpSession session) throws SQLException {
			
			JSONArray RESULTDATA=new JSONArray();
			String brcid=session.getAttribute("BRANCHID").toString();
			   Connection conn=null;
	  try {
		  conn= connDAO.getMyConnection();
	    Statement stmtCPV = conn.createStatement ();
	    String productsql="select bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
				+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
				+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "	;
	    System.out.println("-----productsql---"+productsql);    
	    ResultSet resultSet = stmtCPV.executeQuery (productsql);
	 // System.out.println("----resultSet-------"+resultSet);
	    RESULTDATA=commonDAO.convertToJSON(resultSet);     
	    
	    stmtCPV.close();
	    conn.close();
	  }
	  catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }
	        return RESULTDATA;
	    }
	public JSONArray multipleCashPurchaseGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
        
        //System.out.println("==branch==="+branch);
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
			
				String sqlnew=("SELECT d.qty,d.unitprice,d.psrno,d.tr_no,d.tax srvtaxper,m.date,ma.refname vendor,ma.doc_no vendorid,d.tinno,d.invno,d.invdate,DATE_FORMAT(invdate,'%d.%m.%Y') AS hidinvdate,m.RefNo,t.doc_no docno,d.rowno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,"
						+ "d.rate rate,d.taxamt,d.AMOUNT amount1,d.total,d.baseamount,d.description,d.SR_NO sr_no,d.costtype,d.costcode,"
						+ "f.costgroup FROM my_mcpbm m left join my_mcpbd d on m.tr_no=d.tr_no left join my_costunit f on d.costtype=f.costtype left join my_acbook ma on d.vendid=ma.doc_no and ma.dtype='VND' left join my_head t on "
						+ "d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='MCP' and m.brhId="+branch+" and m.doc_no="+docNo+" and d.SR_NO>=0");
				
				
				//System.out.println("==gridreloading--->>>"+sqlnew);
				
				ResultSet resultSet = stmtPC.executeQuery (sqlnew);
                
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
	
	public JSONArray multipleCashPurchaseGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
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
			        
		           sql="select t.doc_no,t.account,t.description,t.gr_type,c.code curr,c.doc_no curid,c.type,round(cb.rate,2) c_rate from my_head t left join my_curr c "
						+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
						+ "cr.frmDate from my_curbook cr group by cr.curid) as bo "
						+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"'"+sqltest+"";
			       
//		           System.out.println("mcpgridSearch-->"+sql);
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
	
	public JSONArray mcpMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String check) throws SQLException {

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
	       
	        String mcpmainsearch = "select 0 cldocno,coalesce(m.tr_no,0) trno,m.date,m.doc_no, m.brhid,m.totalAmount amount,if(h.description is null,' ',h.description) description from  my_mcpbm m  left join my_head h on m.acno=h.doc_no  "
	        		+ "where  m.brhid=1 and m.dtype='MCP' and m.status <> 7" +sqltest;
	        
//	        System.out.println("mcpMainSearch-->"+mcpmainsearch);
	        
	       ResultSet resultSet = stmtPC.executeQuery(mcpmainsearch);
	       
	       
	       
	       
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
	
	 public ClsmultipleCashPurchaseBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		 ClsmultipleCashPurchaseBean multipleCashPurchaseBean = new ClsmultipleCashPurchaseBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
		
			String branch = session.getAttribute("BRANCHID").toString();
			String sql=" SELECT d.tax,m.date,m.RefNo,t.account,t.description,t.doc_no accno,d.curId,d.rate,(M.TOTALAMOUNT) amount,m.DESC1,d.SR_NO,d.TR_NO,c.type FROM my_mcpbm m left join my_mcpbd d on m.tr_no=d.tr_no left join my_head t on m.acno=t.doc_no left join my_curr c on d.curId=c.doc_no "
					+ " WHERE m.dtype='MCP' and m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" group by m.tr_no";
//			System.out.println("viewdetails=========="+sql);
			ResultSet resultSet = stmtPC.executeQuery (sql);

			while (resultSet.next()) {
				multipleCashPurchaseBean.setTxtpettycashdocno(docNo);
				multipleCashPurchaseBean.setJqxmcpdate(resultSet.getDate("date").toString());
				multipleCashPurchaseBean.setTxtrefno(resultSet.getString("RefNo"));
				//multipleCashPurchaseBean.setTxttranid(resultSet.getInt("tranid"));
				multipleCashPurchaseBean.setTxttrno(resultSet.getInt("TR_NO"));
				
				multipleCashPurchaseBean.setTxtdocno(resultSet.getInt("accno"));
				multipleCashPurchaseBean.setTxtaccid(resultSet.getString("account"));
				multipleCashPurchaseBean.setTxtaccname(resultSet.getString("description"));
				multipleCashPurchaseBean.setHidcmbcurrency(resultSet.getString("curId"));
				multipleCashPurchaseBean.setHidcurrencytype(resultSet.getString("type"));
				multipleCashPurchaseBean.setTxtrate(resultSet.getDouble("rate"));
				multipleCashPurchaseBean.setTxtamount(resultSet.getDouble("amount"));
				multipleCashPurchaseBean.setTxtbaseamount(resultSet.getDouble("amount"));
				multipleCashPurchaseBean.setTxtdescription(resultSet.getString("DESC1"));
				multipleCashPurchaseBean.setMaindate(resultSet.getDate("date").toString());
				multipleCashPurchaseBean.setSrvtaxper(resultSet.getString("tax"));
		    }
		 stmtPC.close();
		 conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		}
		return multipleCashPurchaseBean;
		}

	public ClsmultipleCashPurchaseBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		ClsmultipleCashPurchaseBean bean = new ClsmultipleCashPurchaseBean();
		 Connection conn = null;
		 
		try {
			
			conn = connDAO.getMyConnection();
			Statement stmtPC = conn.createStatement();
			
			String headersql="select if(m.dtype='PC','Petty Cash',' ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.tinno,"
					+ "b.cstno from my_mcpbm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='MCP' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtPC.executeQuery(headersql);
				
				while(resultSetHead.next()){
					bean.setLblcomptrn(resultSetHead.getString("tinno"));
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
			
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,round(m.totalAmount,2) netAmount,u.user_name from my_mcpbm m left join my_user u on "
						+ "m.userid=u.doc_no where m.dtype='MCP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
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
			
			String sql="select round(m.totalAmount,2) netAmount,h.description from my_mcpbm m  left join my_head h on "
				+ "m.acno=h.doc_no where m.dtype='MCP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet = stmtPC.executeQuery(sql);
			//System.out.println("hr"+sql);
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSet.next()){
				
				bean.setLblname(resultSet.getString("description"));
				bean.setLblnetamount(resultSet.getString("netAmount"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
			}

			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,c.code currency,d.description,concat(coalesce(v.reg_no,''),' - ',coalesce(p.code_name,'')) regno,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*1),2),' ') credit FROM my_mcpbm m left join my_mcpbd d on m.tr_no=d.tr_no "
				+ "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId left join gl_vehmaster v on v.fleet_no=d.costcode and costtype=6 left join gl_vehplate p on v.pltid=p.doc_no WHERE m.dtype='MCP' and m.brhid="+branch+" and m.doc_no="+docNo+" order by d.amount desc";
			// System.out.println("===== "+sql1);
			ResultSet resultSet1 = stmtPC.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("regno")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_mcpbm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='MCP' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
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
	 
	
	
	public JSONArray vendorSearch(HttpSession session) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();

		Connection conn =null;
		Statement stmt =null;
		try {
			conn = connDAO.getMyConnection();
			stmt = conn.createStatement ();


			String sql= "select ma.cldocno vendorid,ma.refname vendor, ma.tinno, ma.tax from my_acbook ma where ma.status=3 and ma.dtype='VND'";
//			System.out.println("Vendor search--------------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=commonDAO.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	
	
	
	 public int insertion(Connection conn,int docno,int trno,String formdetailcode,Date mcpdate, String txtrefno, double txtrate, 
			 String txtdescription, double txtamount, ArrayList<String> mcparray, HttpSession session,String mode, String vendorid, String tinno, String invno, Date invdate, String taxamt, String total1) throws SQLException{
//		 System.out.println("inside insertion---");
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtPC;
				Statement stmtPC1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				int rowno=0;
				
				/*Multiple Cash Grid and Details Saving*/
				for(int i=0;i< mcparray.size();i++){
				
//					 System.out.println(" grid ===== "+mcparray.get(i));
					String[] pettycash=mcparray.get(i).split("::");
					
					if(!pettycash[0].trim().equalsIgnoreCase("undefined") && !pettycash[0].trim().equalsIgnoreCase("NaN")){
					
//					System.out.println("Array-->"+pettycash);
					int cash = 0,trid = 0;
					int id = 0;
					if(pettycash[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(pettycash[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					
					rowno=pettycash[16].trim().equalsIgnoreCase("undefined") || pettycash[16].trim().equalsIgnoreCase("NaN") || pettycash[16].trim().equalsIgnoreCase("") || pettycash[16].trim().equalsIgnoreCase("0") || pettycash[16].trim().isEmpty()?0:Integer.parseInt(pettycash[16].trim());
				//	System.out.println("==== "+pettycash[13]);
				//	java.sql.Date stdt=(pettycash[13].trim().equalsIgnoreCase("undefined") || pettycash[13].trim().equalsIgnoreCase("NaN") || pettycash[13].trim().equalsIgnoreCase("") || pettycash[13].isEmpty()?null:pettycash[13])); //Invdate
					// System.out.println("invdate====="+stdt);
					// if(mode.equalsIgnoreCase("E")){
					
					
						
						/*if(rowno>0){
						stmtPC = conn.prepareCall("update my_mcpbd set description=?,amount=?,tr_no=?,rate=?,baseamount=?,sr_no=?,acno=?,vendid=?,invno=?,invdate=?,taxamt=?,total=? where tr_no=? and rowno='"+rowno+"'");
						System.out.println("if srno>0"+stmtPC);
						
						Insertion to my_mcpbd
						stmtPC.setString(1,(pettycash[5].trim().equalsIgnoreCase("undefined") || pettycash[5].trim().equalsIgnoreCase("NaN") || pettycash[5].trim().isEmpty()?0:pettycash[5].trim()).toString()); //description
						stmtPC.setString(2,(pettycash[4].trim().equalsIgnoreCase("undefined") || pettycash[4].trim().equalsIgnoreCase("NaN") || pettycash[4].trim().isEmpty()?0:pettycash[4].trim()).toString()); //amount
						stmtPC.setInt(3,trno); 
						stmtPC.setString(4,(pettycash[2].trim().equalsIgnoreCase("undefined") || pettycash[2].trim().equalsIgnoreCase("NaN") || pettycash[2].trim().equals(0) || pettycash[2].trim().isEmpty()?1:pettycash[2].trim()).toString()); //rate
						stmtPC.setString(5,(pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().isEmpty()?0:pettycash[6].trim()).toString()); //baseamount
						stmtPC.setInt(6,pettycash[16].trim().equalsIgnoreCase("undefined") || pettycash[16].trim().equalsIgnoreCase("NaN") || pettycash[16].trim().equalsIgnoreCase("") || pettycash[16].trim().equalsIgnoreCase("0") || pettycash[16].trim().isEmpty()?0:Integer.parseInt(pettycash[16].trim()));
						stmtPC.setString(7,(pettycash[11].trim().equalsIgnoreCase("undefined") || pettycash[11].trim().equalsIgnoreCase("NaN") || pettycash[11].trim().equalsIgnoreCase("") || pettycash[11].trim().equalsIgnoreCase("0") || pettycash[11].trim().isEmpty()?0:pettycash[11].trim()).toString()); //tinno
						stmtPC.setString(8,(pettycash[10].trim().equalsIgnoreCase("undefined") || pettycash[10].trim().equalsIgnoreCase("NaN") || pettycash[10].trim().equalsIgnoreCase("") || pettycash[10].trim().equalsIgnoreCase("0") || pettycash[10].trim().isEmpty()?0:pettycash[10].trim()).toString()); //Vendorid
						stmtPC.setString(9,(pettycash[12].trim().equalsIgnoreCase("undefined") || pettycash[12].trim().equalsIgnoreCase("NaN") || pettycash[12].trim().equalsIgnoreCase("") || pettycash[12].trim().equalsIgnoreCase("0") || pettycash[12].trim().isEmpty()?0:pettycash[12].trim()).toString()); //invno
						//stmtPC.setString(10,stdt); //Invdate
						stmtPC.setString(10,(pettycash[13].trim().equalsIgnoreCase("undefined") || pettycash[13].trim().equalsIgnoreCase("NaN") || pettycash[13].trim().equalsIgnoreCase("") || pettycash[13].isEmpty()?null:pettycash[13]));
						stmtPC.setString(11,(pettycash[14].trim().equalsIgnoreCase("undefined") || pettycash[14].trim().equalsIgnoreCase("NaN") || pettycash[14].trim().equalsIgnoreCase("") || pettycash[14].trim().equalsIgnoreCase("0") || pettycash[14].trim().isEmpty()?0:pettycash[14].trim()).toString()); //taxamt
						stmtPC.setString(12,(pettycash[15].trim().equalsIgnoreCase("undefined") || pettycash[15].trim().equalsIgnoreCase("NaN") || pettycash[15].trim().equalsIgnoreCase("") || pettycash[15].trim().equalsIgnoreCase("0") || pettycash[15].trim().isEmpty()?0:pettycash[15].trim()).toString()); //total
					*/	
						//stmtPC.registerOutParameter(23, java.sql.Types.INTEGER); //trno
						//stmtPC.registerOutParameter(24, java.sql.Types.INTEGER); //docno
						//stmtPC.registerOutParameter(25, java.sql.Types.INTEGER); //rowid
						//stmtPC.setString(26,mode);
						//stmtPC.setInt(1,i); //SR_NO
						//stmtPC.setString(2,(pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().isEmpty()?0:pettycash[0].trim()).toString());  //doc_no of my_head
						//stmtPC.setString(3,(pettycash[1].trim().equalsIgnoreCase("undefined") || pettycash[1].trim().equalsIgnoreCase("NaN") || pettycash[1].trim().isEmpty()?0:pettycash[1].trim()).toString()); //curId
						
						//stmtPC.setInt(5,id); //#credit -1 / debit 1 
						
						
						
						//stmtPC.setInt(9,cash); //For cash = 0/ party = 1
						//null:commonDAO.changeStringtoSqlDate(pettycash[13].trim())).toString()
						//stmtPC.setString(8,(pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().equalsIgnoreCase("0") || pettycash[8].trim().isEmpty()?0:pettycash[8].trim()).toString()); //Cost type
						//stmtPC.setString(9,(pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().equalsIgnoreCase("") || pettycash[9].trim().equalsIgnoreCase("0") || pettycash[9].trim().isEmpty()?0:pettycash[9].trim()).toString()); //Cost Code
						//stmtPC.setString(10,(pettycash[10].trim().equalsIgnoreCase("undefined") || pettycash[10].trim().equalsIgnoreCase("NaN") || pettycash[10].trim().equalsIgnoreCase("") || pettycash[10].trim().equalsIgnoreCase("0") || pettycash[10].trim().isEmpty()?0:pettycash[10].trim()).toString()); //Vendorid
						//stmtPC.setString(11,(pettycash[11].trim().equalsIgnoreCase("undefined") || pettycash[11].trim().equalsIgnoreCase("NaN") || pettycash[11].trim().equalsIgnoreCase("") || pettycash[11].trim().equalsIgnoreCase("0") || pettycash[11].trim().isEmpty()?0:pettycash[11].trim()).toString()); //tinno
						
						//System.out.println(i+"tot===="+pettycash[15].trim());
						/*my_cashbd Ends*/
						
						/*Insertion to my_jvtran*/
						//stmtPC.setDate(16,mcpdate);
						//stmtPC.setString(17,(txtrefno.trim().equalsIgnoreCase("undefined") || txtrefno.trim().equalsIgnoreCase("NaN") || txtrefno.trim().isEmpty()?0:txtrefno.trim()).toString());
						//stmtPC.setInt(18,id);  //id
						//stmtPC.setString(19,(pettycash[7].trim().equalsIgnoreCase("undefined") || pettycash[7].trim().equalsIgnoreCase("NaN") || pettycash[7].trim().isEmpty()?0:pettycash[7].trim()).toString());  //out-amount
						/*my_jvtran Ends*/
						
						/*stmtPC.setString(20,formdetailcode);
						stmtPC.setString(21,branch);
						stmtPC.setString(22,userid);
						//stmtPC.setString(28,mode);
						int detail=stmtPC.executeUpdate();
							if(detail<=0){
								stmtPC.close();
								conn.close();
								return 0;
							}*/	
						
					
					// }
//					System.out.println("===== "+pettycash[13].trim());
					java.sql.Date xtdt=(pettycash[13].trim().equalsIgnoreCase("undefined") || pettycash[13].trim().equalsIgnoreCase("NaN") || pettycash[13].trim().equalsIgnoreCase("") || pettycash[13].isEmpty()?null:commonDAO.changeStringtoSqlDate(pettycash[13].trim())); //Invdate
					stmtPC = conn.prepareCall("{CALL mcpDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					
					/*Insertion to my_mcpbd*/    
					stmtPC.setInt(23,trno);   
					stmtPC.setInt(24,docno);
					//stmtPC.registerOutParameter(23, java.sql.Types.INTEGER); //trno
					//stmtPC.registerOutParameter(24, java.sql.Types.INTEGER); //docno
					stmtPC.registerOutParameter(25, java.sql.Types.INTEGER); //rowid
					stmtPC.setString(26,mode);
					stmtPC.setDouble(27,(pettycash[17].trim().equalsIgnoreCase("undefined") || pettycash[17].trim().equalsIgnoreCase("NaN") || pettycash[17].trim().equalsIgnoreCase("") || pettycash[17].trim().equalsIgnoreCase("0") || pettycash[17].trim().isEmpty()?0.0:Double.parseDouble(pettycash[17].trim())));
					stmtPC.setString(28,(pettycash[18].trim().equalsIgnoreCase("undefined") || pettycash[18].trim().equalsIgnoreCase("NaN") || pettycash[18].trim().isEmpty()?0:pettycash[18].trim()).toString());
					stmtPC.setString(29,(pettycash[19].trim().equalsIgnoreCase("undefined") || pettycash[19].trim().equalsIgnoreCase("NaN") || pettycash[19].trim().isEmpty()?0:pettycash[19].trim()).toString());
					stmtPC.setDouble(30,commonDAO.Round((pettycash[20].trim().equalsIgnoreCase("undefined") || pettycash[20].trim().equalsIgnoreCase("NaN") || pettycash[20].trim().isEmpty()?0.0:Double.parseDouble(pettycash[20].trim())),2));
					stmtPC.setInt(1,i); //SR_NO    
					stmtPC.setString(2,(pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().isEmpty()?0:pettycash[0].trim()).toString());  //doc_no of my_head
					stmtPC.setString(3,(pettycash[1].trim().equalsIgnoreCase("undefined") || pettycash[1].trim().equalsIgnoreCase("NaN") || pettycash[1].trim().isEmpty()?0:pettycash[1].trim()).toString()); //curId
					stmtPC.setString(4,(pettycash[2].trim().equalsIgnoreCase("undefined") || pettycash[2].trim().equalsIgnoreCase("NaN") || pettycash[2].trim().equals(0) || pettycash[2].trim().isEmpty()?1:pettycash[2].trim()).toString()); //rate 
					//stmtPC.setInt(5,id); //#credit -1 / debit 1 
					stmtPC.setDouble(5,commonDAO.Round((pettycash[4].trim().equalsIgnoreCase("undefined") || pettycash[4].trim().equalsIgnoreCase("NaN") || pettycash[4].trim().isEmpty()?0.0:Double.parseDouble(pettycash[4].trim())),2)); //amount
					stmtPC.setString(6,(pettycash[5].trim().equalsIgnoreCase("undefined") || pettycash[5].trim().equalsIgnoreCase("NaN") || pettycash[5].trim().isEmpty()?0:pettycash[5].trim()).toString()); //description
					stmtPC.setDouble(7,commonDAO.Round((pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().isEmpty()?0.0:Double.parseDouble(pettycash[6].trim())),2)); //baseamount
					//stmtPC.setInt(9,cash); //For cash = 0/ party = 1
					//null:commonDAO.changeStringtoSqlDate(pettycash[13].trim())).toString()
					stmtPC.setString(8,(pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().equalsIgnoreCase("0") || pettycash[8].trim().isEmpty()?0:pettycash[8].trim()).toString()); //Cost type
					stmtPC.setString(9,(pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().equalsIgnoreCase("") || pettycash[9].trim().equalsIgnoreCase("0") || pettycash[9].trim().isEmpty()?0:pettycash[9].trim()).toString()); //Cost Code
					stmtPC.setString(10,(pettycash[10].trim().equalsIgnoreCase("undefined") || pettycash[10].trim().equalsIgnoreCase("NaN") || pettycash[10].trim().equalsIgnoreCase("") || pettycash[10].trim().equalsIgnoreCase("0") || pettycash[10].trim().isEmpty()?0:pettycash[10].trim()).toString()); //Vendorid
					stmtPC.setString(11,(pettycash[11].trim().equalsIgnoreCase("undefined") || pettycash[11].trim().equalsIgnoreCase("NaN") || pettycash[11].trim().equalsIgnoreCase("") || pettycash[11].trim().equalsIgnoreCase("0") || pettycash[11].trim().isEmpty()?0:pettycash[11].trim()).toString()); //tinno
					stmtPC.setString(12,(pettycash[12].trim().equalsIgnoreCase("undefined") || pettycash[12].trim().equalsIgnoreCase("NaN") || pettycash[12].trim().equalsIgnoreCase("") || pettycash[12].trim().equalsIgnoreCase("0") || pettycash[12].trim().isEmpty()?0:pettycash[12].trim()).toString()); //invno
					stmtPC.setDate(13,xtdt);
					stmtPC.setDouble(14,commonDAO.Round((pettycash[14].trim().equalsIgnoreCase("undefined") || pettycash[14].trim().equalsIgnoreCase("NaN") || pettycash[14].trim().equalsIgnoreCase("") || pettycash[14].trim().equalsIgnoreCase("0") || pettycash[14].trim().isEmpty()?0.0:Double.parseDouble(pettycash[14].trim())),2)); //taxamt
					stmtPC.setDouble(15,commonDAO.Round((pettycash[15].trim().equalsIgnoreCase("undefined") || pettycash[15].trim().equalsIgnoreCase("NaN") || pettycash[15].trim().equalsIgnoreCase("") || pettycash[15].trim().equalsIgnoreCase("0") || pettycash[15].trim().isEmpty()?0.0:Double.parseDouble(pettycash[15].trim())),2)); //total
					//System.out.println(i+"tot===="+pettycash[15].trim());
					/*my_cashbd Ends*/
					
					/*Insertion to my_jvtran*/
					stmtPC.setDate(16,mcpdate);
					stmtPC.setString(17,(txtrefno.trim().equalsIgnoreCase("undefined") || txtrefno.trim().equalsIgnoreCase("NaN") || txtrefno.trim().isEmpty()?0:txtrefno.trim()).toString());
					stmtPC.setInt(18,id);  //id
					stmtPC.setDouble(19,commonDAO.Round((pettycash[7].trim().equalsIgnoreCase("undefined") || pettycash[7].trim().equalsIgnoreCase("NaN") || pettycash[7].trim().isEmpty()?0.0:Double.parseDouble(pettycash[7].trim())),2));  //out-amount
					/*my_jvtran Ends*/
					
					stmtPC.setString(20,formdetailcode);
					stmtPC.setString(21,branch);
					stmtPC.setString(22,userid);
					//stmtPC.setString(28,mode);
//					System.out.println("data_======="+stmtPC);
					int detail=stmtPC.executeUpdate();
						if(detail<=0){
							System.out.println("========= insertion error=======");
							stmtPC.close();
							conn.close();
							return 0;
						}
					
						if((pettycash[10].trim().equalsIgnoreCase("undefined") || pettycash[10].trim().equalsIgnoreCase("NaN") || pettycash[10].trim().isEmpty()?0:pettycash[10].trim())=="0"){
							 String sql3="SELECT TRANID FROM my_jvtran where TR_NO="+trno+" and acno="+(pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().isEmpty()?0:pettycash[0].trim());
							 ResultSet resultSet2 = stmtPC1.executeQuery(sql3);
							    System.out.println("======tranid ======"+sql3);
							 while (resultSet2.next()) {
							 trid = resultSet2.getInt("TRANID");
							 }
						}				
				 if((!pettycash[8].trim().equalsIgnoreCase("0") && !pettycash[8].trim().equalsIgnoreCase("")) && trid!=0){
				 String sql4="insert into my_costtran(acno,costtype,amount,sr_no,jobid,tranid,tr_no) values("+(pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().isEmpty()?0:pettycash[0].trim())+","
				 		+ ""+(pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().isEmpty()?0:pettycash[8].trim())+","
				 	    + ""+(pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().isEmpty()?0:pettycash[6].trim())+","+i+","
				 	    + ""+(pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().isEmpty()?0:pettycash[9].trim())+","+trid+","+trno+")";
				 
				 int data2 = stmtPC1.executeUpdate(sql4);
				 if(data2<=0){
					 System.out.println("============costtran update error ========"+sql4);
					    stmtPC1.close();
						conn.close();
						return 0;
					  }
				 
				 String sql5="update my_jvtran set costtype="+(pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().isEmpty()?0:pettycash[8].trim())+","
				 		+ "costcode="+(pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().isEmpty()?0:pettycash[9].trim())+" where tranid="+trid+"";
				 int data3 = stmtPC1.executeUpdate(sql5);
				 if(data3<=0){
					 System.out.println("============jv update error ========"+sql5);
					    stmtPC1.close();
						conn.close();
						return 0;
					  }
				 	}	
  				  }
			    }
			    /*Petty Cash Grid and Details Saving Ends*/
				
				/*Deleting account of value zero*/
				String sql2=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
			    int data = stmtPC1.executeUpdate(sql2);
			     
			    String sql4=("DELETE FROM my_mcpbd where TR_NO="+trno+" and acno=0");
			    int data1 = stmtPC1.executeUpdate(sql4);
			    /*Deleting account of value zero ends*/
			    
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

}
