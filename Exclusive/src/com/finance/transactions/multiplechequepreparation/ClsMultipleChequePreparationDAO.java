package com.finance.transactions.multiplechequepreparation;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.bankpayment.ClsBankPaymentDAO;

public class ClsMultipleChequePreparationDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsMultipleChequePreparationBean multiChequePreparationBean = new ClsMultipleChequePreparationBean();
		
		public int insert(Connection conn, Date multipleChequePreparationDate, String formdetailcode, String txtrefno, String txtdescription, int txtfromdocno, String cmbfromcurrency, double txtfromrate, 
			double txtfromamount, double txtfrombaseamount, int txttodocno, String txtchequeno,Date chequeDate, String txtchequeduration, String cmbchequefrequency, String txtnoofcheques, 
			ArrayList<String> chequedetailsarray, ArrayList<String> bankpaymentarray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
			
		try{
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtMCP = conn.prepareCall("{CALL multichqprepmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtMCP.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtMCP.setDate(1,multipleChequePreparationDate);
			stmtMCP.setString(2,txtrefno);
			stmtMCP.setString(3,txtdescription);
			stmtMCP.setInt(4,txtfromdocno);
			stmtMCP.setInt(5,txttodocno);
			stmtMCP.setString(6,txtchequeno);
			stmtMCP.setDate(7,chequeDate);
			stmtMCP.setString(8,"");
			stmtMCP.setString(9,cmbfromcurrency);
			stmtMCP.setDouble(10,txtfromrate);
			stmtMCP.setDouble(11,txtfromamount);
			stmtMCP.setDouble(12,txtfrombaseamount);
			stmtMCP.setString(13,txtchequeduration);
			stmtMCP.setString(14,cmbchequefrequency);
			stmtMCP.setString(15,txtnoofcheques);
			stmtMCP.setString(16,formdetailcode);
			stmtMCP.setString(17,company);
			stmtMCP.setString(18,branch);
			stmtMCP.setString(19,userid);
			stmtMCP.setString(21,mode);
			int datas=stmtMCP.executeUpdate();
			if(datas<=0){
				stmtMCP.close();
				conn.close();
				return 0;
			}
			int docno=stmtMCP.getInt("docNo");
			multiChequePreparationBean.setTxtmultiplechequepreparationdocno(docno);
			if (docno > 0) {
				
				/*Insertion to my_multichqprepd,my_chqbm,my_chqdet,my_chqbd,my_jvtran,my_outd*/
				int insertData=insertion(conn, docno, formdetailcode, multipleChequePreparationDate, txtrefno, chequeDate, txtchequeno, txtdescription, txtfromrate, txttodocno, txtfrombaseamount, chequedetailsarray, bankpaymentarray, session, request, mode);
				if(insertData<=0){
					stmtMCP.close();
					conn.close();
					return 0;
				} else {
					stmtMCP.close();
					return docno;
				}
				/*Insertion to my_multichqprepd,my_chqbm,my_chqdet,my_chqbd,my_jvtran,my_outd Ends*/
			}
		stmtMCP.close();
	 }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 0;
	}
	
	public JSONArray fillChequeDetailsGridLoading(String acno,String description,String chequestartdate,String chequeno,String chequefrequency,String txtamount, String noofcheques,String txtinstamt,String txtdueafter,String check) throws SQLException {
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
				
				double xtotal=0.0;
				double amount=0.0;
				int xsrno=0;
		        String chequesno="0";
		        
		        if(!(chequestartdate.equalsIgnoreCase("undefined"))&&!(chequestartdate.equalsIgnoreCase(""))&&!(chequestartdate.equalsIgnoreCase("0"))){
		        	xdate = commonDAO.changeStringtoSqlDate(chequestartdate);
		        	fdate = commonDAO.changeStringtoSqlDate(chequestartdate);
		        }
		        
		        String xsql="";
		        
				xsql=Integer.parseInt(txtdueafter) + (chequefrequency.equalsIgnoreCase("1")?" Day ":chequefrequency.equalsIgnoreCase("2")?" Month ":" Year ");
				
				do							
				{	
					++xsrno;
					if (Integer.parseInt(noofcheques)>0 && xsrno>Integer.parseInt(noofcheques))
					break;
					
					int sr_no= xsrno;							
					int actualNoOfInst=xsrno;
					
					amount=((xtotal+Double.parseDouble(txtinstamt))>Double.parseDouble(txtamount)?(Double.parseDouble(txtamount)-xtotal):Double.parseDouble(txtinstamt));
					xtotal+=amount;
					
					//setting values to grid
					JSONObject obj = new JSONObject();
					
					String sqls="select t.doc_no docno,t.atype,t.account accounts,t.description accountname1,t.gr_type grtype,t.curid currencyid,c.code currency,round(cb.rate,2) rate,"
							+ "c.type currencytype,true dr,round("+amount+",2) amount1,round(("+amount+"*cb.rate),2) baseamount1,'"+description+"' description,if("+sr_no+"=1,"+chequeno+",("+chequesno+"+1)) chequeno,"
							+ ""+sr_no+" sr_no from my_head t left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,"
							+ "cr.toDate,cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>='"+xdate+"' and frmDate<='"+xdate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) "
							+ "where t.doc_no='"+acno+"'";
					
					ResultSet resultSet1=stmtPREP.executeQuery(sqls);
					   
					while(resultSet1.next()){
						  
						obj.put("docno",resultSet1.getString("docno"));
						obj.put("type",resultSet1.getString("atype"));
						obj.put("accounts",resultSet1.getString("accounts"));
						obj.put("accountname1",resultSet1.getString("accountname1"));
						obj.put("currency",resultSet1.getString("currency"));
						obj.put("currencyid",resultSet1.getString("currencyid"));
						obj.put("rate",resultSet1.getString("rate"));
						obj.put("chequeno",resultSet1.getString("chequeno"));
						if(!(xdate==null)){
							obj.put("chequedate",xdate.toString());
						}
						obj.put("dr",resultSet1.getString("dr"));
						obj.put("amount1",String.valueOf(amount));
						obj.put("baseamount1",resultSet1.getString("baseamount1"));
						obj.put("description",resultSet1.getString("description"));
						obj.put("grtype",resultSet1.getString("grtype"));
						obj.put("currencytype",resultSet1.getString("currencytype"));
						obj.put("sr_no",String.valueOf(sr_no));
						chequesno=resultSet1.getString("chequeno");
					}
					
					jsonArray.add(obj);
					
					if(xtotal>=Double.parseDouble(txtamount)) break;
					
					ResultSet rs = stmtPREP.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+fdate+"')))) fdate ");
					
					if(rs.next()) xdate=rs.getDate("fdate");
					
					rs.close();
			} while(true);
					   
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
	
	public JSONArray multiChequePreparationGridReloading(HttpSession session,String docNo,String check) throws SQLException {
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
				Statement stmtMCP = conn.createStatement();
			
				ResultSet resultSet = stmtMCP.executeQuery ("select t.doc_no docno,t.atype type,t.account accounts,t.description accountname1,t.gr_type grtype,c.code currency,c.type currencytype,d.curId currencyid,d.rate rate,"
						+ "if(d.dr>0,true,false) dr,(d.AMOUNT*d.dr) amount1,(d.lamount*d.dr) baseamount1,d.chqno chequeno,d.chqdt chequedate,d.description,d.SR_NO sr_no from my_multichqprepm m left join my_multichqprepd d on (m.doc_no=d.rdocno and m.brhid=d.brhid) "
						+ "left join my_head t on d.acno=t.doc_no left join my_curr c on c.doc_no=d.curId where m.dtype='MCP' and m.brhid="+branch+" and m.doc_no="+docNo+"");
              
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtMCP.close();
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
	
	 public ClsMultipleChequePreparationBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
		ClsMultipleChequePreparationBean multiChequePreparationBean = new ClsMultipleChequePreparationBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtMCP = conn.createStatement();
	
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtMCP.executeQuery ("select m.date,m.doc_no,m.refno,m.acno,m.curId,m.rate,m.totalAmount,m.totalBaseAmount,m.desc1,m.opsacno,m.chqno,m.chqdt,m.freq,m.freqType,m.noOfIns,h.account,h.description accountname,"
					+ "h1.atype,h1.account opaccount,h1.description opaccountname,h1.curid opcurid,h1.rate oprate,c.type currencytype,c1.type opcurrencytype from my_multichqprepm m left join my_head h on m.acno=h.doc_no left join "
					+ "my_head h1 on m.opsacno=h1.doc_no left join my_curr c on c.doc_no=m.curId left join my_curr c1 on c1.doc_no=h1.curid where m.brhid="+branch+" and m.dtype='MCP' and m.status <> 7 and m.doc_no="+docNo);
	
			while (resultSet.next()) {
					multiChequePreparationBean.setTxtmultiplechequepreparationdocno(docNo);
					multiChequePreparationBean.setJqxMultipleChequePreparationDate(resultSet.getDate("date").toString());
					multiChequePreparationBean.setTxtrefno(resultSet.getString("refno"));
				
					multiChequePreparationBean.setTxtfromdocno(resultSet.getInt("acno"));
					multiChequePreparationBean.setTxtfromaccid(resultSet.getString("account"));
					multiChequePreparationBean.setTxtfromaccname(resultSet.getString("accountname"));
					multiChequePreparationBean.setHidcmbfromcurrency(resultSet.getString("curId"));
					multiChequePreparationBean.setHidfromcurrencytype(resultSet.getString("currencytype"));
					multiChequePreparationBean.setTxtfromrate(resultSet.getDouble("rate"));
					multiChequePreparationBean.setTxtfromamount(resultSet.getDouble("totalAmount"));
					multiChequePreparationBean.setTxtfrombaseamount(resultSet.getDouble("totalBaseAmount"));
					multiChequePreparationBean.setTxtdescription(resultSet.getString("DESC1"));
					
					multiChequePreparationBean.setTxttodocno(resultSet.getInt("opsacno"));
					multiChequePreparationBean.setHidcmbtotype(resultSet.getString("atype"));
					multiChequePreparationBean.setTxttoaccid(resultSet.getString("opaccount"));
					multiChequePreparationBean.setTxttoaccname(resultSet.getString("opaccountname"));
					multiChequePreparationBean.setHidcmbtocurrency(resultSet.getString("opcurid"));
					multiChequePreparationBean.setHidtocurrencytype(resultSet.getString("opcurrencytype"));
					multiChequePreparationBean.setTxttorate(resultSet.getDouble("oprate"));
					multiChequePreparationBean.setTxttobaseamount(0);
					
					multiChequePreparationBean.setTxtchequeno(resultSet.getString("chqno"));
					multiChequePreparationBean.setJqxChequeDate(resultSet.getDate("chqdt").toString());
					multiChequePreparationBean.setTxtchequeduration(resultSet.getString("freq"));
					multiChequePreparationBean.setHidcmbchequefrequency(resultSet.getString("freqType"));
					multiChequePreparationBean.setTxtnoofcheques(resultSet.getString("noOfIns"));
					
					multiChequePreparationBean.setTxtdrtotal(resultSet.getDouble("totalBaseAmount"));
					multiChequePreparationBean.setTxtcrtotal(resultSet.getDouble("totalBaseAmount"));
					multiChequePreparationBean.setMaindate(resultSet.getDate("date").toString());
	
			    }
			stmtMCP.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return multiChequePreparationBean;
		}
	 
	 public JSONArray mcpMainSearch(HttpSession session,String partyname,String docNo,String date,String amount,String chequeNo,String chequeDt,String check) throws SQLException {

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
	           
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtMCP = conn.createStatement();
		       
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
		         sqltest=sqltest+" and h.description like '%"+partyname+"%'";
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
		         
		       ResultSet resultSet = stmtMCP.executeQuery("select m.date,m.doc_no,m.totalAmount amount,h.description,m.chqno,m.chqdt from my_multichqprepm m left join my_head h "
		    		   + "on m.opsacno=h.doc_no where m.brhid="+branch+" and m.dtype='MCP' and m.status <> 7" +sqltest);
	
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtMCP.close();
		       conn.close();
	     }
	     catch(Exception e){
	    	 	e.printStackTrace();
	    	 	conn.close();
	     }
           return RESULTDATA;
       }
	 
	 public int insertion(Connection conn,int docno,String formdetailcode,Date multipleChequePreparationDate, String txtrefno, Date chequeDate, String txtchequeno, String txtdescription,  
			 double txtfromrate, int txttodocno, double txtdrtotal, ArrayList<String> chequedetailsarray, ArrayList<String> bankpaymentarray, HttpSession session, HttpServletRequest request,
			 String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtMCP;
				Statement stmtMCP1 = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				int bpvdocno=0;
				
				/*Cheque Details Grid and Details Saving*/
				for(int i=0;i< chequedetailsarray.size();i++){
					String[] chequedetails=chequedetailsarray.get(i).split("::");
					if(!chequedetails[0].trim().equalsIgnoreCase("undefined") && !chequedetails[0].trim().equalsIgnoreCase("NaN")){
					
					int cash = 0;
					int id = 0;
					if(chequedetails[3].trim().equalsIgnoreCase("true")){
						cash=0;
						id=1;
					}
					else if(chequedetails[3].trim().equalsIgnoreCase("false")){
						cash=1;
						id=-1;
					}
					
						stmtMCP = conn.prepareCall("{CALL multichqprepdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						java.sql.Date chequesdate=(chequedetails[11].trim().equalsIgnoreCase("undefined") || chequedetails[11].trim().equalsIgnoreCase("NaN") || chequedetails[11].trim().equalsIgnoreCase("") ||  chequedetails[11].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(chequedetails[11].trim()));
						
						/*Insertion to my_multichqprepd*/
						stmtMCP.setInt(16,docno);
						stmtMCP.registerOutParameter(17, java.sql.Types.INTEGER);
						stmtMCP.setInt(1,(i+1)); //SR_NO
						stmtMCP.setString(2,(chequedetails[0].trim().equalsIgnoreCase("undefined") || chequedetails[0].trim().equalsIgnoreCase("NaN") || chequedetails[0].trim().isEmpty()?0:chequedetails[0].trim()).toString());  //doc_no of my_head
						stmtMCP.setString(3,(chequedetails[1].trim().equalsIgnoreCase("undefined") || chequedetails[1].trim().equalsIgnoreCase("NaN") || chequedetails[1].trim().isEmpty()?0:chequedetails[1].trim()).toString()); //curId
						stmtMCP.setString(4,(chequedetails[2].trim().equalsIgnoreCase("undefined") || chequedetails[2].trim().equalsIgnoreCase("NaN") || chequedetails[2].trim().equals(0) || chequedetails[2].isEmpty()?1:chequedetails[2].trim()).toString()); //rate  
						stmtMCP.setString(5,(chequedetails[4].trim().equalsIgnoreCase("undefined") || chequedetails[4].trim().equalsIgnoreCase("NaN") || chequedetails[4].trim().isEmpty()?0:chequedetails[4].trim()).toString()); //amount
						stmtMCP.setString(6,(chequedetails[5].trim().equalsIgnoreCase("undefined") || chequedetails[5].trim().equalsIgnoreCase("NaN") || chequedetails[5].trim().isEmpty()?0:chequedetails[5].trim()).toString()); //description
						stmtMCP.setString(7,(chequedetails[6].trim().equalsIgnoreCase("undefined") || chequedetails[6].trim().equalsIgnoreCase("NaN") || chequedetails[6].trim().isEmpty()?0:chequedetails[6].trim()).toString()); //baseamount
						stmtMCP.setInt(8,cash); //For cash = 0/ party = 1
						stmtMCP.setString(9,(chequedetails[8].trim().equalsIgnoreCase("undefined") || chequedetails[8].trim().equalsIgnoreCase("NaN") || chequedetails[8].trim().equalsIgnoreCase("") || chequedetails[8].trim().equalsIgnoreCase("0") || chequedetails[8].trim().isEmpty()?"0":chequedetails[8].trim()).toString()); //Cost type
						stmtMCP.setString(10,(chequedetails[9].trim().equalsIgnoreCase("undefined") || chequedetails[9].trim().equalsIgnoreCase("NaN") || chequedetails[9].trim().equalsIgnoreCase("") || chequedetails[9].trim().equalsIgnoreCase("0") || chequedetails[9].trim().isEmpty()?"0":chequedetails[9].trim()).toString()); //Cost Code
						stmtMCP.setString(11,(chequedetails[10].trim().equalsIgnoreCase("undefined") || chequedetails[10].trim().equalsIgnoreCase("NaN") || chequedetails[10].trim().isEmpty()?0:chequedetails[10].trim()).toString()); //cheque no
						stmtMCP.setDate(12,chequesdate); //cheque date
						stmtMCP.setInt(13,id);  //id
						stmtMCP.setString(14,branch);
						stmtMCP.setString(15,userid);
						stmtMCP.setString(18,mode);
						stmtMCP.execute();
						if(stmtMCP.getInt("irowsNo")<=0){
							stmtMCP.close();
							conn.close();
							return 0;
						}
						/*my_multichqprepd Ends*/
					}
				    }
				    /*Cheque Details Grid and Details Saving Ends*/
				
				
				/*Bank Payment Grid and Details Saving*/
				ArrayList<String> bankpaymentsarray= new ArrayList<String>();
				ArrayList<String> applyinvoicearray= new ArrayList<String>();
				for(int j=0;j< bankpaymentarray.size();j++){
					String[] chequedetails=bankpaymentarray.get(j).split("::");
					if(!chequedetails[0].trim().equalsIgnoreCase("undefined") && !chequedetails[0].trim().equalsIgnoreCase("NaN")){
						if(chequedetails[12].trim().equalsIgnoreCase("0")){
							bankpaymentsarray.clear();
							bankpaymentsarray.add(chequedetails[0]+"::"+chequedetails[1]+"::"+chequedetails[2]+"::"+chequedetails[3]+"::"+chequedetails[4]+"::"+chequedetails[5]+"::"+chequedetails[6]+"::"+chequedetails[7]+"::"+chequedetails[8]+"::"+chequedetails[9]+"::"+chequedetails[10]+"::"+chequedetails[11]);
						} else if(chequedetails[12].trim().equalsIgnoreCase("1")){
							bankpaymentsarray.add(chequedetails[0]+"::"+chequedetails[1]+"::"+chequedetails[2]+"::"+chequedetails[3]+"::"+chequedetails[4]+"::"+chequedetails[5]+"::"+chequedetails[6]+"::"+chequedetails[7]+"::"+chequedetails[8]+"::"+chequedetails[9]+"::"+chequedetails[10]+"::"+chequedetails[11]);
							
							java.sql.Date chequeDates=(chequedetails[14].trim().equalsIgnoreCase("undefined") || chequedetails[14].trim().equalsIgnoreCase("NaN") || chequedetails[14].trim().equalsIgnoreCase("") ||  chequedetails[14].trim().isEmpty()?null:commonDAO.changeStringtoSqlDate(chequedetails[14].trim()));
							
							ClsBankPaymentDAO bpvDAO = new ClsBankPaymentDAO();
							bpvdocno=bpvDAO.insert(conn, multipleChequePreparationDate, "BPV", txtrefno, txtfromrate, chequeDates, chequedetails[13], "", Integer.parseInt(chequedetails[10]), txtdescription, Double.parseDouble(chequedetails[6]), txttodocno, Double.parseDouble("0"), bankpaymentsarray, applyinvoicearray, session, request, mode);
							if(bpvdocno<=0){
								System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= BANK PAYMENT FAILED TO GENERATE *=*=*=*=*=*=*=*=*=*=*=*=");
								conn.close();
								return 0;
							}
						}
						
					}
				}
				/*Bank Payment Grid and Details Saving Ends*/
					
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	 
}
