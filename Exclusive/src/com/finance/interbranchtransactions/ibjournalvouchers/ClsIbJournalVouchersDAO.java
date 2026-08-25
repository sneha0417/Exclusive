package com.finance.interbranchtransactions.ibjournalvouchers;

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

public class ClsIbJournalVouchersDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsIbJournalVouchersBean ibJournalVouchersBean = new ClsIbJournalVouchersBean();
	
	public int insert(Date ibJournalVouchersDate, String formdetailcode1, String txtrefno, String txtdescription, double txtdrtotal, double txtcrtotal,
			ArrayList<String> ibJournalvouchersarray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			String formdetailcode ="",referenceId="";
			
			if(formdetailcode1.contains("-")){
				String[] parts = formdetailcode1.split("-");
				formdetailcode = parts[0]; 
				referenceId = parts[1];
			}else{
				formdetailcode=formdetailcode1;
				referenceId="0";
			}
			
			CallableStatement stmtIJV = conn.prepareCall("{CALL jvmaDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtIJV.registerOutParameter(11, java.sql.Types.INTEGER);
			stmtIJV.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtIJV.setDate(1,ibJournalVouchersDate); //Date
			stmtIJV.setString(2,txtrefno); //Ref No
			stmtIJV.setString(3,txtdescription); //Description
			stmtIJV.setDouble(4,txtdrtotal); //Dr Total
			stmtIJV.setDouble(5,txtcrtotal); //Cr Total
			stmtIJV.setString(6,formdetailcode);
			stmtIJV.setString(7,company);
			stmtIJV.setString(8,branch);
			stmtIJV.setString(9,userid);
			stmtIJV.setString(10,referenceId);
			stmtIJV.setString(13,mode);
			int datas=stmtIJV.executeUpdate();
			if(datas<=0){
				stmtIJV.close();
				conn.close();
				return 0;
			}
			int docno=stmtIJV.getInt("docNo");
			int trno=stmtIJV.getInt("itranNo");
			request.setAttribute("tranno", trno);
			ibJournalVouchersBean.setTxtibjournalvouchersdocno(docno);
			
			if (docno > 0) {
				/*Insertion to my_jvtran*/
				int insertData=insertion(conn, docno, trno, formdetailcode, ibJournalVouchersDate, txtrefno, ibJournalvouchersarray, session, mode);
				if(insertData<=0){
					stmtIJV.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_jvtran Ends*/
				
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno;
				ResultSet resultSet = stmtIJV.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0){
					conn.commit();
					stmtIJV.close();
					conn.close();
					return docno;
				 }else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
					    stmtIJV.close();
					    return 0;
				    }
			}
		stmtIJV.close();
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
	
	public boolean edit(int txtibjournalvouchersdocno, String formdetailcode, Date ibJournalVouchersDate,String txtrefno, String txtdescription, int txttrno, double txtdrtotal,
			double txtcrtotal, ArrayList<String> ibJournalvouchersarray,HttpSession session,String mode) throws SQLException {
			
		Connection conn = null; 
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtIJV = conn.createStatement();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
				int trno = txttrno,total = 0,applydelete=0;
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_jvma*/
                String sql=("UPDATE my_jvma set date='"+ibJournalVouchersDate+"',refNo='"+txtrefno+"',description='"+txtdescription+"',drtot='"+txtdrtotal+"',crtot='"+txtcrtotal+"',YearId=0,trtype=4,dtype='"+formdetailcode+"',cmpid='"+company+"',xentbr='"+branch+"',brhId='"+branch+"' where TR_NO="+trno+" and  doc_no="+txtibjournalvouchersdocno);
                int data = stmtIJV.executeUpdate(sql);
                if(data<=0){
					stmtIJV.close();
					conn.close();
					return false;
				}
				/*Updating my_jvma Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibjournalvouchersdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtIJV.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
				 int docno=txtibjournalvouchersdocno;
				 ibJournalVouchersBean.setTxtibjournalvouchersdocno(docno);
					if (docno > 0) {
						
						ClsApplyDelete applyDAO = new ClsApplyDelete();
						applydelete=applyDAO.getFinanceApplyDelete(conn, trno);
					    if(applydelete<0){
					    	System.out.println("*** ERROR IN APPLY DELETE ***");
					        stmtIJV.close();
					        conn.close();
					        return false;
				        }
						
						String sql1=("DELETE FROM my_jvtran WHERE TR_NO="+trno+"");
						int data1 = stmtIJV.executeUpdate(sql1);
							 
						String sql6=("DELETE FROM my_costtran WHERE TR_NO="+trno+"");
						int data2 = stmtIJV.executeUpdate(sql6);
						  
						/*Insertion to my_jvtran*/
						int insertData=insertion(conn, docno, trno, formdetailcode, ibJournalVouchersDate, txtrefno, ibJournalvouchersarray, session, mode);
						if(insertData<=0){
							stmtIJV.close();
							conn.close();
							return false;
						}
						/*Insertion to my_jvtran Ends*/
						
						String sql3="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
						ResultSet resultSet = stmtIJV.executeQuery(sql3);
					    
						 while (resultSet.next()) {
						 total=resultSet.getInt("jvtotal");
						 }

						 if(total == 0){
							conn.commit();
							stmtIJV.close();
							conn.close();
							return true;
						}else{
							System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
							stmtIJV.close();
							return false;
						}
					}
				stmtIJV.close();
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

	public boolean editMaster(int txtibjournalvouchersdocno,String formdetailcode, Date ibJournalVouchersDate, String txtrefno, String txtdescription,
			int txttrno,double txtdrtotal, double txtcrtotal, HttpSession session) throws SQLException {
		
		Connection conn=null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtIJV = conn.createStatement();
			
			int trno = txttrno;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_jvma*/
            String sql=("UPDATE my_jvma set date='"+ibJournalVouchersDate+"',refNo='"+txtrefno+"',description='"+txtdescription+"',drtot='"+txtdrtotal+"',crtot='"+txtcrtotal+"',YearId=0,dtype='"+formdetailcode+"',cmpid='"+company+"',xentbr='"+branch+"',brhId='"+branch+"' where TR_NO="+trno+" and doc_no="+txtibjournalvouchersdocno);
			int data = stmtIJV.executeUpdate(sql);
			if(data<=0){
				stmtIJV.close();
				conn.close();
				return false;
			}
			/*Updating my_jvma Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibjournalvouchersdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtIJV.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtIJV.close();
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

	public boolean delete(int txtibjournalvouchersdocno, String formdetailcode, int txttrno,HttpSession session) throws SQLException {
		Connection conn=null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtIJV = conn.createStatement();
			int trno = txttrno,applydelete=0;
			
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			ClsApplyDelete applyDAO = new ClsApplyDelete();
			applydelete=applyDAO.getFinanceApplyDelete(conn, trno);
			if(applydelete<0){
				System.out.println("*** ERROR IN APPLY DELETE ***");
			    stmtIJV.close();
			    conn.close();
			    return false;
			}
			
			/*Updating my_jvma*/
            String sql=("update my_jvma set status=7 where TR_NO="+trno+" and doc_no="+txtibjournalvouchersdocno);
			int data = stmtIJV.executeUpdate(sql);
			if(data<=0){
				stmtIJV.close();
				conn.close();
				return false;
			}
			/*Updating my_jvma Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtibjournalvouchersdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
			int datas = stmtIJV.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			/*Journal Voucher Grid Updating*/
			String sql1="update my_jvtran set status=7,out_amount=0 where TR_NO="+trno+" and doc_no="+txtibjournalvouchersdocno;
			int data1 = stmtIJV.executeUpdate(sql1);
			if(data1<=0){
				stmtIJV.close();
				conn.close();
				return false;
			}
		   /*Journal Voucher Grid Updating Ends*/
			
			conn.commit();
			stmtIJV.close();
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
	
	public JSONArray ibJournalVoucherExcelImportGridLoading(HttpSession session,String docNo,String date) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	String newelement=Enumeration.nextElement();
        	if(newelement.equalsIgnoreCase("COMPANYID")){
        		a=a+1;
        	}
        	if(newelement.equalsIgnoreCase("BRANCHID")){
        		a=a+1;
        	}
        }
        if(a<2){
    		return RESULTDATA;
        	}
        String branch = session.getAttribute("BRANCHID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtIJV = conn.createStatement();
			
				java.sql.Date sqlDate=null;
		        	   
	            date.trim();
	            if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	            {
	        	   sqlDate = commonDAO.changeStringtoSqlDate(date);
	            }
	            
				ResultSet resultSet = stmtIJV.executeQuery ("select m.branchname branch,m.type,m.accounts,m.accountname1,CONVERT(if(m.costtype='NA','',m.costtype),CHAR(50)) costgroup,"
					+ "CONVERT(if(m.costcode=0,'',m.costcode),CHAR(50)) costcode,round(m.debit,2) debit,round(m.credit,2) credit,if(m.debit>0,"
					+ "round(m.debit*cb.rate,2),round(m.credit*cb.rate,2)) baseamount,m.description,h.doc_no docno,br.doc_no brhid,"
					+ "h.gr_type grtype,CONVERT(if(co.costtype is null,'',co.costtype),CHAR(50)) costtype,c.doc_no currencyid,c.type currencytype,round(cb.rate,2) rate,CASE WHEN m.type in ('GL','HR','AP','AR') THEN '0' "
					+ "ELSE '1' END as 'typevalid',CASE WHEN h.doc_no!='' THEN '0' ELSE '1' END as 'accvalid',CASE WHEN  h.gr_type='4' THEN '0' WHEN h.gr_type='5' THEN "
					+ "'0'  WHEN h.gr_type='0' THEN '0' WHEN  h.gr_type in (4,5) AND m.costtype='' THEN '1' WHEN co.costtype is null THEN '0' ELSE '1' END as 'grtypevalid',CASE WHEN m.costtype='NA' THEN "
					+ "'0' WHEN m.costtype is null THEN '0' WHEN co.costtype in (1,6) THEN '0' ELSE '1' END as 'costvalid',CASE WHEN  m.branchname in (select branchname from my_brch where status=3) THEN '0' "
					+ "WHEN m.branchname='' THEN '1' WHEN m.branchname is null THEN '0' ELSE '1' END as 'branchvalid' from my_ijv_excel m left join my_head h on m.accounts=h.account left join my_costunit co "
					+ "on m.costtype=co.costgroup left join my_brch br on br.branchname=m.branchname left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid left join "
					+ "(select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on "
					+ "(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where m.id="+docNo+" ");
                
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtIJV.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray ibJournalVoucherGridReloading(HttpSession session,String docNo,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
          	return RESULTDATA;
          }
        
        Connection conn = null;
       
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	String newelement=Enumeration.nextElement();
        	if(newelement.equalsIgnoreCase("COMPANYID")){
        		a=a+1;
        	}
        	if(newelement.equalsIgnoreCase("BRANCHID")){
        		a=a+1;
        	}
        }
        if(a<2){
    		return RESULTDATA;
        	}
        String company = session.getAttribute("COMPANYID").toString();
        String branch = session.getAttribute("BRANCHID").toString();
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtIJV = conn.createStatement();
			    
				String sql="SELECT m.cmpid,j.brhid,b.branchname branch,j.acno docno,j.description,j.curId currencyid,j.rate,if(j.dramount>0,j.dramount*j.id,0)debit,"
					+ "if(j.dramount<0,j.dramount*j.id,0) credit,round(j.ldramount*j.id,2) baseamount,j.ref_row sr_no,j.id,j.costtype,j.costcode,c.costgroup,t.atype type,"
					+ "t.account accounts,t.description accountname1,t.gr_type grtype,cr.type currencytype FROM my_jvma m  left join my_jvtran j on m.tr_no=j.tr_no left join "
					+ "my_costunit c on j.costtype=c.costtype left join my_head t on t.doc_no=j.acno left join my_curr cr on cr.doc_no=j.curId left join my_brch b on b.doc_no=j.brhid "
					+ "WHERE j.dtype='IJV' and m.cmpid='"+company+"' and m.doc_no='"+docNo+"' and j.acno not in (select doc_no from my_intr where br1='"+branch+"' or br2='"+branch+"')";
				
				ResultSet resultSet = stmtIJV.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtIJV.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	
	public JSONArray ibJournalVoucherGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
	        
			JSONArray RESULTDATA=new JSONArray();
	        
			if(!(check.equalsIgnoreCase("1"))){
	          	return RESULTDATA;
	          }
			
	        Connection conn = null; 
	       
		     try {
			       conn = connDAO.getMyConnection();
			       Statement stmtIJV = conn.createStatement();
		
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
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+type+"' and t.m_s=0"+sqltest;
			        
			       ResultSet resultSet = stmtIJV.executeQuery(sql);
			       RESULTDATA=commonDAO.convertToJSON(resultSet);
		           
			        stmtIJV.close();
				    conn.close();
		     }catch(Exception e){
			      e.printStackTrace();
			      conn.close();
		     }finally{
				 conn.close();
			 }
		       return RESULTDATA;
		  }
	
	public JSONArray branchlist(HttpSession session) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtIJV = conn.createStatement();
       
				String company = session.getAttribute("COMPANYID").toString();
				 
				String sql="select branchname,doc_no from my_brch where cmpid="+company;
				ResultSet resultSet = stmtIJV.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtIJV.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray ijvMainSearch(HttpSession session,String docNo,String dates,String descriptions,String refNo,String amounts,String check) throws SQLException {
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
	    
	    	java.sql.Date sqlStartDate=null;
	    	
			try {
					conn = connDAO.getMyConnection();
					Statement stmtIJV = conn.createStatement();
                    
					dates.trim();
			    	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			    	{
			    	sqlStartDate = commonDAO.changeStringtoSqlDate(dates);
			    	}
			    	
			    	String sqltest="";
			    	
			    	if(!(docNo.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and doc_no like '%"+docNo+"%'";
			    	}
			    	 if(!(sqlStartDate==null)){
				    		sqltest=sqltest+" and date='"+sqlStartDate+"'";
				    } 
			    	if(!(descriptions.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and description like '%"+descriptions+"%'";
			    	}
			    	if(!(refNo.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and refNo like '%"+refNo+"%'";
			    	}
			    	if(!(amounts.equalsIgnoreCase(""))){
			    		sqltest=sqltest+" and drtot like '%"+amounts+"%'";
			    	}
			    	
					String sql5=("SELECT doc_no,date,description,refno,drtot,tr_no FROM my_jvma where dtype='IJV' and brhid="+branch+" and status<>7" +sqltest);
					ResultSet resultSet = stmtIJV.executeQuery(sql5);

					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtIJV.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				 conn.close();
			 }
			return RESULTDATA;
	    }
	
	public ClsIbJournalVouchersBean getViewDetails(String branch,int docNo) throws SQLException {
		
		ClsIbJournalVouchersBean ibJournalVouchersBean = new ClsIbJournalVouchersBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtIJV = conn.createStatement();
		
			ResultSet resultSet = stmtIJV.executeQuery ("SELECT m.doc_no,m.date,m.description,m.refno,m.drtot,m.crtot,m.tr_no,if(d.menu_name is null,' ',if(m.refid=15,' ',concat('AUTO POSTED : ',d.menu_name))) menu_name "  
					+ "FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no left join my_jvidentifyingid d on m.refid=d.jvid where m.dtype='IJV' and m.status<>7 and m.brhId="+branch+" and m.doc_no="+docNo+" group by doc_no");
			
		    while (resultSet.next()) {
				ibJournalVouchersBean.setTxtibjournalvouchersdocno(docNo);
				ibJournalVouchersBean.setJqxIbJournalVouchersDate(resultSet.getDate("date").toString());
				ibJournalVouchersBean.setTxtrefno(resultSet.getString("refno"));
				ibJournalVouchersBean.setTxtdescription(resultSet.getString("description"));
				ibJournalVouchersBean.setTxttrno(resultSet.getInt("tr_no"));
				ibJournalVouchersBean.setTxtdrtotal(resultSet.getDouble("drtot"));
				ibJournalVouchersBean.setTxtcrtotal(resultSet.getDouble("crtot"));
				ibJournalVouchersBean.setMaindate(resultSet.getDate("date").toString());
				ibJournalVouchersBean.setLblformposted(resultSet.getString("menu_name"));
		    }
		  stmtIJV.close();
		  conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
			return ibJournalVouchersBean;
		}

	
	public ClsIbJournalVouchersBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsIbJournalVouchersBean bean = new ClsIbJournalVouchersBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtIJV = conn.createStatement();
			
			String headersql="select if(m.dtype='IJV','IB-Journal Voucher','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from my_jvma m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='IJV' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSetHead = stmtIJV.executeQuery(headersql);
				
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
				
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.description,m.refNo,round(m.drtot,2) netAmount,u.user_name from my_jvma m left join "
						+ "my_user u on m.userid=u.doc_no where m.dtype='IJV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtIJV.executeQuery(sqls);
			
			ClsAmountToWords c = new ClsAmountToWords();
			
			while(resultSets.next()){
				
				bean.setLbldate(resultSets.getString("date"));
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLblrefno(resultSets.getString("refNo"));
				bean.setLblnetamount(resultSets.getString("netAmount"));
				bean.setLbldescription(resultSets.getString("description"));
				
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("netAmount")));
				
				bean.setLbldebittotal(resultSets.getString("netAmount"));
				bean.setLblcredittotal(resultSets.getString("netAmount"));
				
				bean.setLblpreparedby(resultSets.getString("user_name"));
			}
			
			bean.setTxtheader(header);

			String sql1 = "";
		
			sql1="SELECT t.account,t.description accountname,c.code currency,j.description,if(j.dramount>0,round((j.dramount*1),2),'  ') debit,if(j.dramount<0,round((j.dramount*-1),2),'  ') credit,"
			  + "b.branchname FROM my_jvma m left join my_jvtran j on m.tr_no=j.tr_no left join my_head t on j.acno=t.doc_no left join my_brch b on j.brhid=b.doc_no left join my_curr c "
			  + "on c.doc_no=j.curId WHERE m.dtype='IJV' and m.doc_no="+docNo+" and j.acno not in (select doc_no from my_intr where br1='"+branch+"' or br2='"+branch+"') order by j.dramount desc";
			
			ResultSet resultSet1 = stmtIJV.executeQuery(sql1);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1); 
				String temp="";
				temp=resultSet1.getString("branchname")+"::"+resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql2 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_jvma m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='IJV' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet2 = stmtIJV.executeQuery(sql2);
			
			while(resultSet2.next()){
				bean.setLblpreparedon(resultSet2.getString("preparedon"));
				bean.setLblpreparedat(resultSet2.getString("preparedat"));
			}
		
			stmtIJV.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return bean;
	}
	
	public int insertion(Connection conn,int docno,int trno,String formdetailcode, Date ibJournalVouchersDate, String txtrefno, ArrayList<String> ibJournalvouchersarray,
			 HttpSession session,String mode) throws SQLException{

		try{
				CallableStatement stmtIJV = null;
				
				/*Journal Voucher Grid Saving*/
				for(int i=0;i< ibJournalvouchersarray.size();i++){
				String[] ibjournalvoucher=ibJournalvouchersarray.get(i).split("::");
				
				 if(!ibjournalvoucher[0].trim().equalsIgnoreCase("undefined") && !ibjournalvoucher[0].trim().equalsIgnoreCase("NaN")){
					
					stmtIJV = conn.prepareCall("{CALL ibJvmaDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtIJV.setInt(16,docno);
					stmtIJV.setInt(17,trno);
					stmtIJV.setDate(1,ibJournalVouchersDate); //Date
					stmtIJV.setString(2,txtrefno);
					stmtIJV.setString(3,(ibjournalvoucher[1].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[1].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[1].trim().isEmpty()?0:ibjournalvoucher[1].trim()).toString());  //description
					stmtIJV.setInt(4,(i+1)); //Row No
					stmtIJV.setString(5,(ibjournalvoucher[0].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[0].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[0].trim().isEmpty()?0:ibjournalvoucher[0].trim()).toString());  //doc_no of my_head
					stmtIJV.setString(6,(ibjournalvoucher[2].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[2].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[2].trim().isEmpty()?0:ibjournalvoucher[2].trim()).toString()); //curId
					stmtIJV.setString(7,(ibjournalvoucher[3].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[3].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[3].trim().equals(0) || ibjournalvoucher[3].trim().isEmpty()?1:ibjournalvoucher[3].trim()).toString()); //rate
					stmtIJV.setString(8,(ibjournalvoucher[4].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[4].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[4].trim().isEmpty()?0:ibjournalvoucher[4].trim()).toString()); //amount
					stmtIJV.setString(9,(ibjournalvoucher[5].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[5].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[5].trim().isEmpty()?0:ibjournalvoucher[5].trim()).toString()); //baseamount
					stmtIJV.setString(10,(ibjournalvoucher[6].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[6].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[6].trim().isEmpty()?0:ibjournalvoucher[6].trim()).toString()); //credit -1 & debit 1
					stmtIJV.setString(11,(ibjournalvoucher[7].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[7].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[7].trim().equalsIgnoreCase("") || ibjournalvoucher[7].trim().equalsIgnoreCase("0") || ibjournalvoucher[7].trim().isEmpty()?0:ibjournalvoucher[7].trim()).toString());  //Cost Type
					stmtIJV.setString(12,(ibjournalvoucher[8].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[8].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[8].trim().equalsIgnoreCase("") || ibjournalvoucher[8].trim().equalsIgnoreCase("0") || ibjournalvoucher[8].trim().isEmpty()?0:ibjournalvoucher[8].trim()).toString()); //Cost Code
					stmtIJV.setString(13,formdetailcode);
					stmtIJV.setString(14,(ibjournalvoucher[9].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[9].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[9].trim().isEmpty()?0:ibjournalvoucher[9].trim()).toString());  //branch
					stmtIJV.setString(15,(ibjournalvoucher[10].trim().equalsIgnoreCase("undefined") || ibjournalvoucher[10].trim().equalsIgnoreCase("NaN") || ibjournalvoucher[10].trim().isEmpty()?0:ibjournalvoucher[10].trim()).toString()); //Main Branch
					stmtIJV.setString(18,mode);
					stmtIJV.execute();
						if(stmtIJV.getInt("docNo")<=0){
							stmtIJV.close();
							conn.close();
							return 0;
						}
						/*my_jvtran Grid Saving Ends*/
					 }
					
				}	
				stmtIJV.close();
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}


}
