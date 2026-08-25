package com.finance.transactions.unclearedchequereceipt;

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
import com.common.ClsChequeAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsUnclearedChequeReceiptDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsUnclearedChequeReceiptBean unclearedChequeReceiptBean = new ClsUnclearedChequeReceiptBean();
	
	  public int insert(Date unclearedChequeReceiptDate, String formdetailcode,String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, String txtchequename, int chckpdc, 
			  String txtdescription, double txtdrtotal, int txttodocno, ArrayList<String> unclearedchequereceiptarray, HttpSession session, HttpServletRequest request, String mode) 
			  throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);

			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtUCR = conn.prepareCall("{CALL unclrchqreceiptmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtUCR.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtUCR.setDate(1,unclearedChequeReceiptDate);
			stmtUCR.setString(2,txtrefno);
			stmtUCR.setString(3,txtdescription);
			stmtUCR.setString(4,txtchequeno);
			stmtUCR.setDate(5,chequeDate);
			stmtUCR.setString(6,txtchequename);
			stmtUCR.setDouble(7,txtdrtotal);
			stmtUCR.setInt(8,chckpdc);
			stmtUCR.setDouble(9,txtfromrate);
			stmtUCR.setString(10,formdetailcode);
			stmtUCR.setString(11,company);
			stmtUCR.setString(12,branch);
			stmtUCR.setString(13,userid);
			stmtUCR.setString(15,mode);
			int datas=stmtUCR.executeUpdate();
			if(datas<=0){
				stmtUCR.close();
				conn.close();
				return 0;
			}
			int docno=stmtUCR.getInt("docNo");
			unclearedChequeReceiptBean.setTxtunclearedchequereceiptdocno(docno);
			if (docno > 0) {
				
				/*Insertion to my_unclrchqreceiptd*/
				int insertData=insertion(conn, docno, formdetailcode, unclearedChequeReceiptDate, txtrefno, txtfromrate, chequeDate, txtchequeno, chckpdc, txtdescription, txtdrtotal, unclearedchequereceiptarray, session, mode);
				if(insertData<=0){
					stmtUCR.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_unclrchqreceiptd Ends*/
				
					conn.commit();
					stmtUCR.close();
					conn.close();
					return docno;
				 
			}
		stmtUCR.close();
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
			
	
	  public boolean edit(int txtunclearedchequereceiptdocno, String formdetailcode, Date unclearedChequeReceiptDate, String txtrefno, String txtdescription, double txtfromrate,  double txtdrtotal, 
			  int txttodocno, Date chequeDate, String txtchequeno, String txtchequename, int chckpdc, ArrayList<String> unclearedchequereceiptarray, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtUCR = conn.createStatement();
				
				if(mode.equalsIgnoreCase("EDIT")){
					mode="E";
				}
				
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating my_unclrchqreceiptm*/
                String sql=("update my_unclrchqreceiptm set date='"+unclearedChequeReceiptDate+"',DESC1='"+txtdescription+"',RefNo='"+txtrefno+"',mrate="+txtfromrate+",chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',chqname='"+txtchequename+"',totalAmount="+txtdrtotal+",pdc='"+chckpdc+"',DTYPE='"+formdetailcode+"',cmpId="+company+",brhId="+branch+" where brhId="+branch+" and doc_no="+txtunclearedchequereceiptdocno+"");
				int data = stmtUCR.executeUpdate(sql);
				if(data<=0){
					stmtUCR.close();
					conn.close();
					return false;
				}
				/*Updating my_unclrchqreceiptm Ends*/
				
				/*Inserting into datalog*/
				String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtunclearedchequereceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int datas = stmtUCR.executeUpdate(sqls);
				/*Inserting into datalog Ends*/
			    
			    String sql3=("DELETE FROM my_unclrchqreceiptd WHERE rdocno="+txtunclearedchequereceiptdocno+"");
			    int data1 = stmtUCR.executeUpdate(sql3);
			    
			    int docno=txtunclearedchequereceiptdocno;
				unclearedChequeReceiptBean.setTxtunclearedchequereceiptdocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_unclrchqbd*/
					int insertData=insertion(conn, docno, formdetailcode, unclearedChequeReceiptDate, txtrefno, txtfromrate, chequeDate, txtchequeno, chckpdc, txtdescription, txtdrtotal, unclearedchequereceiptarray, session, mode);
					if(insertData<=0){
						stmtUCR.close();
						conn.close();
						return false;
					}
					/*Insertion to my_unclrchqbd Ends*/
					
						conn.commit();
						stmtUCR.close();
						conn.close();
						return true;
				}
			stmtUCR.close();
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
	
	public boolean editMaster(int txtunclearedchequereceiptdocno, String formdetailcode, Date unclearedChequeReceiptDate,String txtrefno, String txtdescription, double txtfromrate,
			double txtdrtotal, int txttodocno, Date chequeDate, String txtchequeno, int chckpdc, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtUCR = conn.createStatement();
			
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			/*Updating my_chqbm*/
			String sql=("update my_unclrchqreceiptm set date='"+unclearedChequeReceiptDate+"',DESC1='"+txtdescription+"',RefNo='"+txtrefno+"',mrate="+txtfromrate+",chqno='"+txtchequeno+"',chqdt='"+chequeDate+"',totalAmount="+txtdrtotal+",pdc='"+chckpdc+"',DTYPE='"+formdetailcode+"',cmpId="+company+",brhId="+branch+" where brhId="+branch+" and doc_no="+txtunclearedchequereceiptdocno+"");
            int data = stmtUCR.executeUpdate(sql);
			if(data<=0){
				stmtUCR.close();
				conn.close();
				return false;
			}
			/*Updating my_chqbm Ends*/
			
			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtunclearedchequereceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
			int datas = stmtUCR.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtUCR.close();
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


	public boolean delete(int txtunclearedchequereceiptdocno,  String formdetailcode, int txttodocno, HttpSession session) throws SQLException {
		
		Connection conn = null;
		
		try{
			    conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtUCR = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				 
				/*Status change in my_unclrchqreceiptm*/
				 String sql=("update my_unclrchqreceiptm set STATUS=7 where brhid="+branch+" and doc_no="+txtunclearedchequereceiptdocno+"");
				 int data = stmtUCR.executeUpdate(sql);
				 if(data<=0){
				    stmtUCR.close();
					conn.close();
					return false;
				 }
				/*Status change in my_unclrchqreceiptm Ends*/
				
				int docno=txtunclearedchequereceiptdocno;
				unclearedChequeReceiptBean.setTxtunclearedchequereceiptdocno(docno);
				if (docno > 0) {
					
					/*Inserting into datalog*/
					 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtunclearedchequereceiptdocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
					 int datas = stmtUCR.executeUpdate(sqls);
					/*Inserting into datalog Ends*/
					 
					conn.commit();
					stmtUCR.close();
					conn.close();
					return true;
				}	
				stmtUCR.close();
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
	
	public JSONArray unclearedChequeReceipttGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
				Statement stmtUCR = conn.createStatement();
			
				ResultSet resultSet = stmtUCR.executeQuery ("select m.date,m.RefNo,t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,"
					+ "c.code currency,c.type currencytype,d.curId currencyid,d.rate rate,if(d.dr<0,true,false) dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,"
					+ "m.DESC1 description,d.SR_NO sr_no,d.costtype,d.costcode,f.costgroup FROM my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) left join my_costunit f "
					+ "on d.costtype=f.costtype left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.brhId='"+branch+"' and m.doc_no="+docNo+" and d.SR_NO>1");
              
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtUCR.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return RESULTDATA;
  }
	
	public JSONArray unclearedChequeReceiptGridSearch(String type,String accountno,String accountname,String currency,String date,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
		 if(!(check.equalsIgnoreCase("1"))){
	    	  return RESULTDATA;
	      }
		 
        Connection conn = null; 
       
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtUCR = conn.createStatement();
	
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
		        
		       ResultSet resultSet = stmtUCR.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
	           
		       stmtUCR.close();
			   conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
		 }
	       return RESULTDATA;
	  }
	
	 public ClsUnclearedChequeReceiptBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsUnclearedChequeReceiptBean unclearedChequeReceiptBean = new ClsUnclearedChequeReceiptBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtUCR = conn.createStatement();
	
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtUCR.executeQuery ("SELECT m.date,m.RefNo,round(m.totalAmount,2) totalAmount,m.chqname,m.chqno,m.chqdt,t.atype,t.account,t.description,t.doc_no accno,d.curId,d.rate,d.dr,round((d.AMOUNT*d.dr),2) AMOUNT,"
				+ "round((d.lamount*d.dr),2) lamount,m.DESC1,d.SR_NO,c.type FROM my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) "
				+ "left join my_head t on d.acno=t.doc_no left join my_curr c on d.curId=c.doc_no WHERE m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+" group by account");
	
			while (resultSet.next()) {
					unclearedChequeReceiptBean.setTxtunclearedchequereceiptdocno(docNo);
					unclearedChequeReceiptBean.setJqxUnclearedChequeReceiptDate(resultSet.getDate("date").toString());
					unclearedChequeReceiptBean.setTxtrefno(resultSet.getString("RefNo"));
				
				if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("0")){
					unclearedChequeReceiptBean.setTxtfromdocno(resultSet.getInt("accno"));
					unclearedChequeReceiptBean.setTxtfromaccid(resultSet.getString("account"));
					unclearedChequeReceiptBean.setTxtfromaccname(resultSet.getString("description"));
					unclearedChequeReceiptBean.setHidcmbfromcurrency(resultSet.getString("curId"));
					unclearedChequeReceiptBean.setHidfromcurrencytype(resultSet.getString("type"));
					
					unclearedChequeReceiptBean.setTxtchequeno(resultSet.getString("chqno"));
					unclearedChequeReceiptBean.setJqxChequeDate(resultSet.getDate("chqdt").toString());
					unclearedChequeReceiptBean.setTxtchequename(resultSet.getString("chqname"));
					
					unclearedChequeReceiptBean.setTxtfromrate(resultSet.getDouble("rate"));
					unclearedChequeReceiptBean.setTxtfromamount(resultSet.getDouble("AMOUNT"));
					unclearedChequeReceiptBean.setTxtfrombaseamount(resultSet.getDouble("lamount"));
					unclearedChequeReceiptBean.setTxtdescription(resultSet.getString("DESC1"));
				}
				
				else if(resultSet.getString("SR_NO").trim().equalsIgnoreCase("1")){
					unclearedChequeReceiptBean.setTxttodocno(resultSet.getInt("accno"));
					unclearedChequeReceiptBean.setHidcmbtotype(resultSet.getString("atype"));
					unclearedChequeReceiptBean.setTxttoaccid(resultSet.getString("account"));
					unclearedChequeReceiptBean.setTxttoaccname(resultSet.getString("description"));
					unclearedChequeReceiptBean.setHidcmbtocurrency(resultSet.getString("curId"));
					unclearedChequeReceiptBean.setHidtocurrencytype(resultSet.getString("type"));
					unclearedChequeReceiptBean.setTxttorate(resultSet.getDouble("rate"));
					unclearedChequeReceiptBean.setTxttoamount(resultSet.getDouble("AMOUNT"));
					unclearedChequeReceiptBean.setTxttobaseamount(resultSet.getDouble("lamount"));
				 }
					unclearedChequeReceiptBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
					unclearedChequeReceiptBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
					unclearedChequeReceiptBean.setMaindate(resultSet.getDate("date").toString());
			    }
			stmtUCR.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return unclearedChequeReceiptBean;
		}
	 
	public ClsUnclearedChequeReceiptBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsUnclearedChequeReceiptBean bean = new ClsUnclearedChequeReceiptBean();
		 Connection conn = null;
		 
		try {
			
				conn = connDAO.getMyConnection();
				Statement stmtUCR = conn.createStatement();
				
				int srno=0;
				
				String headersql="select if(m.dtype='UCR','Uncleared Cheque Receipt','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
						+ "b.cstno from my_unclrchqreceiptm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
						+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='UCR' "
						+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSetHead = stmtUCR.executeQuery(headersql);
					
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
				
				String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.desc1,concat(m.chqno,' ',if(m.pdc=1,'(PDC)','')) chqno,DATE_FORMAT(m.chqdt ,'%d-%m-%Y') chqdt,"
				+ "round(m.totalAmount,2) netAmount,u.user_name from my_unclrchqreceiptm m left join my_user u on m.userid=u.doc_no where m.dtype='UCR' and m.brhid="+branch+" and m.doc_no="+docNo+"";
						
					ResultSet resultSets = stmtUCR.executeQuery(sqls);
					
					while(resultSets.next()){

						bean.setLblvoucherno(resultSets.getString("doc_no"));
						bean.setLbldescription(resultSets.getString("desc1"));
						bean.setLbldate(resultSets.getString("date"));
						bean.setLbldebittotal(resultSets.getString("netAmount"));
						bean.setLblcredittotal(resultSets.getString("netAmount"));
						
						bean.setLblchqno(resultSets.getString("chqno"));
						bean.setLblchqdate(resultSets.getString("chqdt"));
						bean.setLblpreparedby(resultSets.getString("user_name"));
					}
					
						bean.setTxtheader(header);
				
				String sql="select round(m.totalAmount,2) netAmount,h.description,d.acno from my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) left join my_head h on "
				   + "d.acno=h.doc_no  where m.dtype='UCR' and d.sr_no=1 and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
				ResultSet resultSet = stmtUCR.executeQuery(sql);
				
				ClsAmountToWords c = new ClsAmountToWords();
				
				while(resultSet.next()){
					srno=1;
					
					bean.setLblname(resultSet.getString("description"));
					bean.setLblnetamount(resultSet.getString("netAmount"));
					bean.setLblnetamountwords(c.convertAmountToWords(resultSet.getString("netAmount")));
					
				}
				
				if(srno==0){
					String sqld="select round(m.totalAmount,2) netAmount,h.description,d.acno from my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) left join my_head h on "
							   + "d.acno=h.doc_no  where m.dtype='UCR' and d.sr_no=2 and m.brhid="+branch+" and m.doc_no="+docNo+"";
						
							ResultSet resultSet1 = stmtUCR.executeQuery(sqld);
							
							while(resultSet1.next()){
								bean.setLblname(resultSet1.getString("description"));
								bean.setLblnetamount(resultSet1.getString("netAmount"));
								bean.setLblnetamountwords(c.convertAmountToWords(resultSet1.getString("netAmount")));
							}
				}
			
				String sql1 = "";
	
				sql1="SELECT t.account,t.description accountname,c.code currency,d.description,if(d.amount>0,round((d.amount*1),2),'  ') debit,if(d.amount<0,round((d.amount*-1),2),' ') credit FROM "
					+ "my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId WHERE m.dtype='UCR' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+" order by d.amount desc";
					
				ResultSet resultSet1 = stmtUCR.executeQuery(sql1);
				
				ArrayList<String> printarray= new ArrayList<String>();
				
				while(resultSet1.next()){
					bean.setFirstarray(1); 
					String temp="";
					temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("description")+"::"+resultSet1.getString("currency")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				    printarray.add(temp);
				}
				request.setAttribute("printingarray", printarray);
				
				String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_unclrchqreceiptm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='UCR' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
				ResultSet resultSet3 = stmtUCR.executeQuery(sql3);
				
				while(resultSet3.next()){
					bean.setLblpreparedon(resultSet3.getString("preparedon"));
					bean.setLblpreparedat(resultSet3.getString("preparedat"));
				}
				
				stmtUCR.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	}
	 
	public ClsUnclearedChequeReceiptBean getChequePrint(int docno,int branch) throws SQLException {
		 ClsUnclearedChequeReceiptBean bean = new ClsUnclearedChequeReceiptBean();
		 Connection conn = null;
			
		try {
			conn = connDAO.getMyConnection();
			Statement stmtUCR = conn.createStatement();
			String amountwordslength="";
			int accountno=0;
			
			String sqls="select d.acno from my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) where d.sr_no=0 and m.dtype='UCR' and m.brhid="+branch+" "
					+ "and m.doc_no="+docno+"";
			
			ResultSet resultSets = stmtUCR.executeQuery(sqls);
			
			while(resultSets.next()){
				accountno=resultSets.getInt("acno");
			}
			
			/* 1 pixel = 0.02645833333333 centimeter ## 1 centimeter = 37.79527559055 pixel */
			
			String sql="select printpath,round((chqheight*0.3937007874016),2) chqheightin,round((chqwidth*0.3937007874016),2) chqwidthin,round((chqheight*37.79527559055),2) chqheight,"
				+ "round((chqwidth*37.79527559055),2) chqwidth,round((paytover*37.79527559055),2) paytover,round(((3+paytohor)*37.79527559055),2) paytohor,"
				+ "round((paytolen*37.79527559055),2) paytolen,round(((chqdate_x-3)*37.79527559055),2) chqdate_x,round((accountpay_x*37.79527559055),2) accountpay_x,"
				+ "round((accountpay_y*37.79527559055),2) accountpay_y,round((chqdate_y*37.79527559055),2) chqdate_y,round((amtver*37.79527559055),2) amtver,"
				+ "round(((3+amthor)*37.79527559055),2) amthor,round((amtlen*37.79527559055),2) amtlen,round((amt1ver*37.79527559055),2) amt1ver,"
				+ "round(((3+amt1hor)*37.79527559055),2) amt1hor,round((amt1len*37.79527559055),2) amt1len,round(((amount_x-3)*37.79527559055),2) amount_x,"
				+ "round((amount_y*37.79527559055),2) amount_y  from my_chqsetup where status=3 and bankdocno="+accountno+"";
			
			ResultSet resultSet = stmtUCR.executeQuery(sql);
			
			while(resultSet.next()){

				bean.setPrinturl(resultSet.getString("printpath"));
			    bean.setLblpagesheight(resultSet.getString("chqheightin"));
				bean.setLblpageswidth(resultSet.getString("chqwidthin"));
				bean.setLblpageheight(resultSet.getString("chqheight"));
				bean.setLblpagewidth(resultSet.getString("chqwidth"));
				bean.setLblpaytovertical(resultSet.getString("paytover"));
				bean.setLblpaytohorizontal(resultSet.getString("paytohor"));
				bean.setLblpaytolength(resultSet.getString("paytolen"));
				bean.setLbldatex(resultSet.getString("chqdate_x"));
				bean.setLbldatey(resultSet.getString("chqdate_y"));
				
				bean.setLblaccountpayingx(resultSet.getString("accountpay_x"));
				bean.setLblaccountpayingy(resultSet.getString("accountpay_y"));
				bean.setLblamtwordsvertical(resultSet.getString("amtver"));
				bean.setLblamtwordshorizontal(resultSet.getString("amthor"));
				bean.setLblamtwordslength(resultSet.getString("amtlen"));
				bean.setLblamountx(resultSet.getString("amount_x"));
				bean.setLblamounty(resultSet.getString("amount_y"));
				bean.setLblamtwords1vertical(resultSet.getString("amt1ver"));
				bean.setLblamtwords1horizontal(resultSet.getString("amt1hor"));
				bean.setLblamtwords1length(resultSet.getString("amt1len"));
				
				amountwordslength=resultSet.getString("amtlen");
			}
	
			String sql1="select m.chqno,DATE_FORMAT(m.chqdt,'%d-%m-%Y') chqdt,CASE WHEN m.chqname is null THEN t.description WHEN m.chqname='' THEN t.description "
		    		+ "Else m.chqname END as 'description',format(round(if(d.amount<0,d.amount*-1,d.amount),2),2) amount,round(if(d.amount<0,d.amount*-1,d.amount),2) amountinwords "
					+ "from my_unclrchqreceiptm m left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid) left join my_head t on d.acno=t.doc_no "
		    		+ "and d.sr_no=1 where m.dtype='UCR' and m.status=3 and m.brhid="+branch+" and m.doc_no="+docno+" group by m.doc_no";
				
				ResultSet resultSet1 = stmtUCR.executeQuery(sql1);
				
				while(resultSet1.next()){
					/* 1 character = 0.2116666666667 centimeter ## 1 centimeter = 4.724409448819 character
					   1 character = 8 pixel ## 1 pixel = 0.125 character */
					
					bean.setLblchequedate(resultSet1.getString("chqdt"));
					bean.setLblpaidto(resultSet1.getString("description"));
					bean.setLblamount(resultSet1.getString("amount"));
					
					ClsChequeAmountToWords c = new ClsChequeAmountToWords();
					double chequelength = Double.parseDouble(amountwordslength)*0.125;
					String amountwords = c.convertChequeAmountToWords(resultSet1.getString("amountinwords"));
					if(amountwords.length()>chequelength){
						
						String breakedstring = commonDAO.addLinebreaks(amountwords, chequelength);
						
						if(breakedstring.contains("::")){
							String[] breakedstringarray = breakedstring.split("::");
							
							String amountinwords1 = breakedstringarray[0]; 
							String amountinwords2 = breakedstringarray[1];
						
							bean.setLblamountwords(amountinwords1);
							bean.setLblamountwords1(amountinwords2);
						}else{
							bean.setLblamountwords(breakedstring);
						}
					}else{
						bean.setLblamountwords(amountwords);
					}
				}
				
				stmtUCR.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	 
	 public JSONArray ucrMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String chequeNo,String chequeDt,String check) throws SQLException {

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
	       
	        java.sql.Date sqlBankDate=null;
	        java.sql.Date sqlChequeDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlBankDate = commonDAO.changeStringtoSqlDate(date);
	        }
	        
	        chequeDt.trim();
	        if(!(chequeDt.equalsIgnoreCase("undefined"))&&!(chequeDt.equalsIgnoreCase(""))&&!(chequeDt.equalsIgnoreCase("0")))
	        {
	        sqlChequeDate = commonDAO.changeStringtoSqlDate(chequeDt);
	        }
	        
	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and if(h.description is null,h1.description,h.description) like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.totalAmount like '%"+amount+"%'";
	        }
	        if(!(chequeNo.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.chqno like '%"+chequeNo+"%'";
	        }
	        if(!(sqlBankDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlBankDate+"'";
		        } 
	         if(!(sqlChequeDate==null)){
	         sqltest=sqltest+" and m.chqdt='"+sqlChequeDate+"'";
	        } 
	           
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtUCR = conn.createStatement();
		       
		       ResultSet resultSet = stmtUCR.executeQuery("select m.date,m.doc_no,m.totalAmount amount,if(h.description is null,h1.description,h.description) description,m.chqno,m.chqdt from  my_unclrchqreceiptm m "
		       		+ "left join my_unclrchqreceiptd d on (m.doc_no=d.rdocno and m.brhId=d.brhid and d.sr_no=1) left join my_unclrchqreceiptd d1 on (m.doc_no=d1.rdocno and m.brhId=d1.brhid and d1.sr_no=2) left join my_head h on d.acno=h.doc_no left join my_head h1 "
		    		+ "on d1.acno=h1.doc_no left join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.status <> 7" +sqltest);
	
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtUCR.close();
		       conn.close();
	     } catch(Exception e){
	    	 	e.printStackTrace();
	    	 	conn.close();
	     }
           return RESULTDATA;
       }
	 
	 public int insertion(Connection conn,int docno,String formdetailcode,Date unclearedChequeReceiptDate, String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, 
			 int chckpdc, String txtdescription, double txtdrtotal, ArrayList<String> unclearedchequereceiptarray, HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtUCR;
				Statement stmtUCR1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Uncleared Cheque Receipt Grid and Details Saving*/
				for(int i=0;i< unclearedchequereceiptarray.size();i++){
					String[] unclrchqreceipt=unclearedchequereceiptarray.get(i).split("::");
					if(!unclrchqreceipt[0].trim().equalsIgnoreCase("undefined") && !unclrchqreceipt[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					int id = 0;
					if(unclrchqreceipt[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=-1;
					}
					else if(unclrchqreceipt[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=1;
					}
					
					stmtUCR = conn.prepareCall("{CALL unclrchqreceiptdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_unclrchqreceiptd*/
					stmtUCR.setInt(16,docno);
					stmtUCR.registerOutParameter(17, java.sql.Types.INTEGER);
					stmtUCR.setInt(1,i); //SR_NO
					stmtUCR.setString(2,(unclrchqreceipt[0].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[0].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[0].trim().isEmpty()?0:unclrchqreceipt[0].trim()).toString());  //doc_no of my_head
					stmtUCR.setString(3,(unclrchqreceipt[1].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[1].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[1].trim().isEmpty()?0:unclrchqreceipt[1].trim()).toString()); //curId
					stmtUCR.setString(4,(unclrchqreceipt[2].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[2].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[2].trim().equals(0) || unclrchqreceipt[2].isEmpty()?1:unclrchqreceipt[2].trim()).toString()); //rate 
					stmtUCR.setInt(5,id); //#credit -1 / debit 1 
					stmtUCR.setString(6,(unclrchqreceipt[4].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[4].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[4].trim().isEmpty()?0:unclrchqreceipt[4].trim()).toString()); //amount
					stmtUCR.setString(7,(unclrchqreceipt[5].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[5].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[5].trim().isEmpty()?0:unclrchqreceipt[5].trim()).toString()); //description
					stmtUCR.setString(8,(unclrchqreceipt[6].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[6].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[6].trim().isEmpty()?0:unclrchqreceipt[6].trim()).toString()); //baseamount
					stmtUCR.setInt(9,cash); //For cash = 0/ party = 1
					stmtUCR.setString(10,(unclrchqreceipt[7].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[7].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[7].trim().equalsIgnoreCase("") || unclrchqreceipt[7].trim().equalsIgnoreCase("0") || unclrchqreceipt[7].trim().isEmpty()?"0":unclrchqreceipt[7].trim()).toString()); //Cost type
					stmtUCR.setString(11,(unclrchqreceipt[8].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[8].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[8].trim().equalsIgnoreCase("") || unclrchqreceipt[8].trim().equalsIgnoreCase("0") || unclrchqreceipt[8].trim().isEmpty()?"0":unclrchqreceipt[8].trim()).toString()); //Cost Code
					/*my_unclrchqreceiptd Ends*/
					
					stmtUCR.setString(12,(unclrchqreceipt[9].trim().equalsIgnoreCase("undefined") || unclrchqreceipt[9].trim().equalsIgnoreCase("NaN") || unclrchqreceipt[9].trim().isEmpty()?0:unclrchqreceipt[9].trim()).toString()); //pdc
					
					stmtUCR.setString(13,formdetailcode);
					stmtUCR.setString(14,branch);
					stmtUCR.setString(15,userid);
					stmtUCR.setString(18,mode);
					stmtUCR.execute();
					if(stmtUCR.getInt("irowsNo")<=0){
						stmtUCR.close();
						conn.close();
						return 0;
					}
					}
				    }
				    /*Uncleared Cheque Receipt Grid and Details Saving Ends*/
			     
			    String sql4=("DELETE FROM my_unclrchqreceiptd where rdocno="+docno+" and acno=0");
			    int data1 = stmtUCR1.executeUpdate(sql4);
			     /*Deleting account of value zero ends*/
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	 
}
