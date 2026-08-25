package com.finance.posting.manualapplying;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsManualApplyingDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsManualApplyingBean manualApplyingBean = new ClsManualApplyingBean();
	
	public int insert(String formdetailcode, int txtgriddocno, String txtdoctype, String txttrno, String txttranid, Double txtoutamount, Double txtapplyinvoiceapply, ArrayList<String> manualapplyarray, HttpSession session,HttpServletRequest request) throws SQLException {
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtMAPP = conn.createStatement();

			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			System.out.println("======="+manualapplyarray.size());
			/*Apply-Invoicing Grid Saving*/
			for(int i=0;i< manualapplyarray.size();i++){
			String[] apply=manualapplyarray.get(i).split("::");
			System.out.println("======="+manualapplyarray.get(i).split("::"));
			if(!apply[0].equalsIgnoreCase("undefined") && !apply[0].equalsIgnoreCase("NaN")){
				int id = 0,ids = 0, tranid = 0;
				double doutamount = 0,dramount = 0,dramount1 = 0;
			    
			    String sql="select ID,(dramount*id) dramount from my_jvtran where tranid="+txttranid;
			    ResultSet resultSet = stmtMAPP.executeQuery(sql);
			    
				 while (resultSet.next()) {
				 id=resultSet.getInt("ID");
				 dramount=resultSet.getDouble("dramount");
				 }
			    
				 System.out.println("===="+dramount+"===="+(Math.round((txtapplyinvoiceapply+txtoutamount) * 100.0) / 100.0));
				if(dramount>=(Math.round((txtapplyinvoiceapply+txtoutamount) * 100.0) / 100.0)){
				     String sql1="update my_jvtran set out_amount="+(Math.round((txtapplyinvoiceapply+txtoutamount) * 100.0) / 100.0)*id+" where TRANID="+txttranid;
				     int data=stmtMAPP.executeUpdate(sql1);
				}else{
					 conn.close();
					 return 0; 
				 } 
			    String sql2="select * from my_outd where tranid="+txttranid+" and ap_trid="+(apply[3].equalsIgnoreCase("undefined") || apply[3].equalsIgnoreCase("NaN") || apply[3].isEmpty()?0:apply[3]).toString();
			    ResultSet resultSet2 = stmtMAPP.executeQuery(sql2);
			    
				 while (resultSet2.next()) {
					 tranid++;
				 }
				 
				 if(tranid>0){
					 String sql3="update my_outd set AMOUNT=amount+"+(apply[0].equalsIgnoreCase("undefined") || apply[0].equalsIgnoreCase("NaN") || apply[0].isEmpty()?0:apply[0]).toString()+",curId="+(apply[2].equalsIgnoreCase("undefined") || apply[2].equalsIgnoreCase("NaN") || apply[2].isEmpty()?0:apply[2]).toString()+" where tranid="+txttranid+" and ap_trid="+(apply[3].equalsIgnoreCase("undefined") || apply[3].equalsIgnoreCase("NaN") || apply[3].isEmpty()?0:apply[3]).toString();
					 int applypaymentcheck=stmtMAPP.executeUpdate(sql3);
						if(applypaymentcheck==0){
							stmtMAPP.close();
							conn.close();
							return 0;
						}
				 }
				 else{
				    String sql3="insert into my_outd(TRANID,AMOUNT,AP_TRID,curId) values("+txttranid+","+(apply[0].equalsIgnoreCase("undefined") || apply[0].equalsIgnoreCase("NaN") || apply[0].isEmpty()?0:apply[0]).toString()+","+(apply[3].equalsIgnoreCase("undefined") || apply[3].equalsIgnoreCase("NaN") || apply[3].isEmpty()?0:apply[3]).toString()+","+(apply[2].equalsIgnoreCase("undefined") || apply[2].equalsIgnoreCase("NaN") || apply[2].isEmpty()?0:apply[2]).toString()+")";
				    int applypaymentcheck=stmtMAPP.executeUpdate(sql3);
					if(applypaymentcheck==0){
						stmtMAPP.close();
						conn.close();
						return 0;
					}
	            }
				 
				 String sql4 = "select sum(coalesce(amount)) doutamount from my_outd where ap_trid="+(apply[3].equalsIgnoreCase("undefined") || apply[3].equalsIgnoreCase("NaN") || apply[3].isEmpty()?0:apply[3]).toString();
				 ResultSet resultSet4 = stmtMAPP.executeQuery(sql4);
			    
				 while (resultSet4.next()) {
					 doutamount=resultSet4.getDouble("doutamount");
				 }
				 
				 String sql5 = "select id,(dramount*id) dramount from my_jvtran where tranid="+(apply[3].equalsIgnoreCase("undefined") || apply[3].equalsIgnoreCase("NaN") || apply[3].isEmpty()?0:apply[3]).toString();
				 ResultSet resultSet5 = stmtMAPP.executeQuery(sql5);
			    
				 while (resultSet5.next()) {
					 ids=resultSet5.getInt("id");
					 dramount1=resultSet5.getDouble("dramount");
				 }
				 
				 if(dramount1>=doutamount){
					String sql6="update my_jvtran set out_amount="+(doutamount)*ids+" where TRANID="+(apply[3].equalsIgnoreCase("undefined") || apply[3].equalsIgnoreCase("NaN") || apply[3].isEmpty()?0:apply[3]).toString();
					int data3=stmtMAPP.executeUpdate(sql6);
				}else{
					 conn.close();
					 return 0; 
				 }
		    /*Apply-Invoicing Grid Saving Ends*/
			    }
			}

				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtgriddocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','A')");
				int datas = stmtMAPP.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
				
				
				
				/**
				 * After applying checking all entry corresponding to that tranid
				 * Add by nitin 31-07-2018 
				 * starts
				 */
				int val=0;
				
				String sqlcon1 = "SELECT DRAMOUNT*ID dr,OUT_AMOUNT*ID out1 FROM MY_jvtran WHERE TRANID="+txttranid+" AND DRAMOUNT*ID<OUT_AMOUNT*ID";
				 ResultSet resultSetcon1 = stmtMAPP.executeQuery(sqlcon1);
			    System.out.println("****error checking 1 *******"+sqlcon1);
				 while (resultSetcon1.next()) {
					 System.out.println("==== "+resultSetcon1.getDouble("dr")+"===="+resultSetcon1.getDouble("out1"));
					 val=1;
					 conn.close();
					 return 0;
				 }
				
				 String sqlcon2 = "SELECT J.ID,J.OUT_AMOUNT,SUM(coalesce(AMOUNT,0)) FROM MY_JVTRAN J INNER JOIN MY_OUTD O ON J.TRANID=O.TRANID WHERE J.TRANID IN ("+txttranid+") "
				 		+ "GROUP BY O.TRANID HAVING SUM(coalesce(AMOUNT,0))!=(J.OUT_AMOUNT*J.ID)";
				 System.out.println("****error checking 2 *******"+sqlcon2);
				 ResultSet resultSetcon2 = stmtMAPP.executeQuery(sqlcon2);
			    
				 while (resultSetcon2.next()) {
					 val=1;
					 conn.close();
					 return 0;
				 }
				 ArrayList<String> aptridarray= new ArrayList<>();
				 String sqlcon3 = "SELECT O.AP_TRID FROM MY_JVTRAN J INNER JOIN MY_OUTD O ON J.TRANID=O.TRANID WHERE J.TRANID IN ("+txttranid+")";
				 System.out.println("****error checking 3 *******"+sqlcon3);
					 ResultSet resultSetcon3 = stmtMAPP.executeQuery(sqlcon3);
				    
					 while (resultSetcon3.next()) {
						 aptridarray.add(resultSetcon3.getString("AP_TRID"));
					 }
					 
					 for (String temp : aptridarray) {
						 String sqlcon4= "SELECT J.ID,J.OUT_AMOUNT,SUM(AMOUNT) FROM MY_JVTRAN J INNER JOIN MY_OUTD O ON J.TRANID=O.AP_TRID WHERE J.TRANID IN ("+temp+") "
						 		+ " GROUP BY O.AP_TRID HAVING SUM(AMOUNT)!=(J.OUT_AMOUNT*J.ID)";
						 System.out.println("****error checking 4 *******"+sqlcon4);
							 ResultSet resultSetcon4 = stmtMAPP.executeQuery(sqlcon4);
						    
							 while (resultSetcon4.next()) {
								 val=1;
								 conn.close();
								 return 0;
							 } 
					 }
				// SELECT * FROM MY_jvtran WHERE TRANID=199623 AND DRAMOUNT*ID<=OUT_AMOUNT*ID;
				// SELECT J.ID,J.OUT_AMOUNT,SUM(AMOUNT) FROM MY_JVTRAN J INNER JOIN MY_OUTD O ON J.TRANID=O.TRANID WHERE J.TRANID IN (199623) GROUP BY O.TRANID HAVING SUM(AMOUNT)!=(J.OUT_AMOUNT*J.ID);
				// SELECT O.AP_TRID FROM MY_JVTRAN J INNER JOIN MY_OUTD O ON J.TRANID=O.TRANID WHERE J.TRANID IN (199623);
				// SELECT J.ID,J.OUT_AMOUNT,SUM(AMOUNT) FROM MY_JVTRAN J INNER JOIN MY_OUTD O ON J.TRANID=O.AP_TRID WHERE J.TRANID IN (209848)
				// GROUP BY O.AP_TRID HAVING SUM(AMOUNT)!=(J.OUT_AMOUNT*J.ID);
				
				/**
				 * Applying checking ends 	 
				 */
				
				if(val==0){
					conn.commit();
					stmtMAPP.close();
					conn.close();
					return 1;	
				}
				return 0;
			}catch(Exception e){	
				e.printStackTrace();
				conn.close();
				return 0;
	      }finally{
		    conn.close();
	    }
	}

	
	public JSONArray accountsDetails(HttpSession session,String dtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtMAPP = conn.createStatement ();
		
				String branch = session.getAttribute("BRANCHID").toString();
			    String company = session.getAttribute("COMPANYID").toString();
			    
				String code= "";
				if(dtype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(dtype.equalsIgnoreCase("AR")){
					code="CRM";
				}
				
				ResultSet resultSet = stmtMAPP.executeQuery ("select (@i:=@i+1) recno,t.doc_no,t.account,t.description,c.code curr from my_head t,my_acbook a1, "
						+ "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
						+ "and t.cldocno=a1.cldocno and a1.dtype='"+code+"' and t.atype='"+dtype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
						+ "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')");

				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtMAPP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray appliedInvoiceGridLoading(HttpSession session,String accountno,String atype,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a=0;
        while(Enumeration.hasMoreElements()){
        	if(Enumeration.nextElement().equalsIgnoreCase("CURRENCYID")){
        		a=1;
        	}
        }
        if(a==0){
    		return RESULTDATA;
        	}
        String currency=session.getAttribute("CURRENCYID").toString();
        
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtMAPP = conn.createStatement();
				
				String xsql = "", condition = "";
				String joins="",casestatement="";
				
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
				
				if(!(atype==null || atype.equalsIgnoreCase(""))){
					if(atype.equalsIgnoreCase("AP")){
						condition=" and t1.dramount > 0";
					}
					else if(atype.equalsIgnoreCase("AR")){
						condition=" and t1.dramount < 0";
					}
				}
		        
		       xsql = "Select a.*,"+casestatement+"'0' dummy from (Select t1.doc_no transno,t1.acno,t1.tr_no,t1.tranid,t1.date,"
		        		+ "if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) out_amount,t1.dtype transType,t1.curid currency,t1.rate,t1.description,"
		        		+ "if(t1.dramount<0,(t1.dramount*-1),t1.dramount) tramt,if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount) applied,"
		        		+ "((if(t1.dramount<0,(t1.dramount*-1),t1.dramount)- if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount))) balance,t1.brhid from "
		        		+ "my_jvtran t1 inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no where t1.status=3 and t1.acno="+accountno+""
		        		+""+condition+" and (t1.dramount - out_amount) != 0 group by t1.tranid order by date) a"+joins+"";
//		        System.out.println("===== "+xsql);
				ResultSet resultSet = stmtMAPP.executeQuery(xsql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtMAPP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray applyInvoiceGridLoading(String accountno,String atype,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtMAPP = conn.createStatement();
            	String condition="";
				String joins="",casestatement="";
				
				joins=commonDAO.getFinanceVocTablesJoins(conn);
        		casestatement=commonDAO.getFinanceVocTablesCase(conn);
            	
				if(atype.equalsIgnoreCase("AR")){
					condition="and t1.dramount > 0";
				}
				else if(atype.equalsIgnoreCase("AP")){
					condition="and t1.dramount < 0";
				}
            	
				String sql = "Select a.*,"+casestatement+"'0' dummy from (Select t1.doc_no transno,t1.acno,t1.tranid,t1.date,t1.out_amount,t1.dtype transtype,t1.curid currency,"
						+ "t1.description,(if(t1.dramount<0,(t1.dramount*-1),t1.dramount) - if(t1.out_amount<0,(t1.out_amount*-1),t1.out_amount)) tramt,t1.brhid from my_jvtran t1 "
						+ "inner join my_brch b on t1.brhId=b.doc_no inner join my_head h on t1.acno=h.doc_no left join gl_invm m on m.dtype=t1.dtype and "
						+ "t1.doc_no=m.doc_no where t1.status=3 and t1.acno="+accountno+" "+condition+" and (t1.dramount - out_amount) != 0 group by t1.tranid "
						+ "order by date) a"+joins+"";
            	
				ResultSet resultSet = stmtMAPP.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtMAPP.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
}
