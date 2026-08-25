package com.dashboard.realestate.ownerpytsettlementws;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsOwnerpytsettlementDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public   JSONArray getContractData(String branch,String fromdate,String todate,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1"))
	    {
	    	return data;
	    }
	    java.sql.Date sqlfromdate = null;
	    String sqltest="";
	    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		sqltest+=" and pyt.date>='"+sqlfromdate+"'";
     	}
        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		sqltest+=" and pyt.date<='"+sqltodate+"'";
     	}
        
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
     	Connection conn = null;
        
		try{
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement ();     
			String sql="select pyt.doc_no detaildocno,ownerhead.description owner,pyt.notes,pyt.desc1 paymentdesc,pyt.date chequedate,pyt.pamount amount,pyt.chqno chequeno,m.recieptstatus,"+
			" m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.accname pname,if(m.ttype=1,'Residence','Commercial') protype, "+
			" if(m.Period=1,'Years','Months') Period, m.Period_no, m.Period_from, m.Period_to, m.not_Period,m.nettotal totalamount"+
			" from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno "+
			" left join rl_tncpayment pyt on (m.doc_no=pyt.rdocno and pyt.desc1='Rental Value' and pyt.paidto='Self') left join my_head "+
			" ownerhead on (pm.acno=ownerhead.doc_no) left join my_chqdet chq on chq.tr_no=pyt.refno where m.status=3 and m.recieptstatus=1 and clstatus=0 and pyt.ownerpytsettletrno=0 and "+
			" pyt.doc_no is not null and ((chq.status='p' and payment!='cash') or payment='cash') "+sqltest;
			System.out.println("-----------"+sql);
            ResultSet resultSet = stm.executeQuery(sql);
            data=objcommon.convertToJSON(resultSet);
            stm.close();
     		conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }
	
	public JSONArray getPaymentData(String docno,String id,String detaildocno) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try {
			conn =objconn.getMyConnection();
			Statement stmt = conn.createStatement ();    
			String salsql="select  doc_no, rdocno, slno, desc1 description, date, pamount amount, notes , chqno chqno, paidto, payment paymentmethod, bank  bankaccount from rl_tncpayment where refno>0 and paidto='Self' and rdocno='"+docno+"' and doc_no="+detaildocno;
			System.out.println("-------salsql------"+salsql);
			ResultSet resultSet = stmt.executeQuery(salsql);
			data=objcommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close(); 
		}
		return data;
	}
	
	public JSONArray getJvData(String docno,String id,String detaildocno,String jvdesc,String jvdate) throws SQLException {
	    
	    JSONArray RESULTDATA=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){
	    	return RESULTDATA;
	    }
	    Connection conn =null;
	    try {
				conn=objconn.getMyConnection();
				Statement stmt=conn.createStatement();
				String strgetowneracno="select prop.acno owneracno,head.curid ownercurid,head.rate ownercurrate from rl_tncm m left join rl_propertymaster prop "+
				" on (m.prtype=prop.doc_no) left join my_head head on (prop.acno=head.doc_no) where m.doc_no="+docno;
				System.out.println("Owner Details Query:"+strgetowneracno);
				ResultSet rsgetowneracno=stmt.executeQuery(strgetowneracno);
				int owneracno=0;
				int ownercurid=0;
				double ownercurrate=0.0;
				while(rsgetowneracno.next()){
					owneracno=rsgetowneracno.getInt("owneracno");
					ownercurid=rsgetowneracno.getInt("ownercurid");
					ownercurrate=rsgetowneracno.getDouble("ownercurrate");
				}
				String strgetacno="select m.pamount amount,ct.acno,m.refno,ac.refname,head.curid paymentcurid,head.rate paymentcurrate from rl_tncm m1 left join rl_tncpayment m on (m1.doc_no=m.rdocno) left join rl_terms_contract ct on (m.desc1=ct.description) left "+
				" join my_acbook ac on (m1.cldocno=ac.cldocno and ac.dtype='CRM') left join my_head head on (ct.acno=head.doc_no) where m.rdocno="+docno+" and m.doc_no="+detaildocno;
				System.out.println("Payment Details Query:"+strgetacno);
				int paymentacno=0;
				int paymentrefno=0;
				int paymentcurid=0;
				double paymentcurrate=0.0;
				String tenantname="";
				double amount=0.0;
				ResultSet rsgetacno=stmt.executeQuery(strgetacno);
				while(rsgetacno.next()){
					paymentacno=rsgetacno.getInt("acno");
					paymentrefno=rsgetacno.getInt("refno");
					tenantname=rsgetacno.getString("refname");
					paymentcurid=rsgetacno.getInt("paymentcurid");
					paymentcurrate=rsgetacno.getDouble("paymentcurrate");
					amount=rsgetacno.getDouble("amount");
				}
				
				/*String strSql="select if(j.dramount>0,round(j.dramount*j.id,2),0)debit ,if(j.dramount<0,round(j.dramount*j.id,2),0) credit,"+
	        	" round(j.ldramount*j.id,2) baseamt,j.description desc1,h.account acno,	h.description acname,h.atype type from my_jvtran j left join"+
	        	" my_head h on j.acno=h.doc_no left join my_curr cr on cr.doc_no=j.curId inner join rl_tncpayment pyt on"+
	        	" j.tr_no=pyt.ownerpytsettletrno where pyt.rdocno="+docno;*/
				
				int paymentid=1;
				int ownerid=-1;
				double paymentamount=amount;
				double owneramount=amount*-1;
//				String voucherdesc=jvdesc+" - "+docno+" - "+paymentrefno+" - "+tenantname;
				String voucherdesc=jvdesc;
				String strsql="select if("+paymentamount+">0,round("+paymentamount+"*"+paymentid+",2),0)debit ,if("+paymentamount+"<0,round("+paymentamount+"*"+paymentid+",2),0) credit,"+
				" round("+paymentamount+"*"+paymentid+",2) baseamt,'"+voucherdesc+"' desc1,h.account acno,	h.description acname,h.atype type from my_head h  left join my_curr cr on"+
				" cr.doc_no=h.curId where h.doc_no="+paymentacno+" union all"+
				" select if("+owneramount+">0,round("+owneramount+"*"+ownerid+",2),0)debit ,if("+owneramount+"<0,round("+owneramount+"*"+ownerid+",2),0) credit,"+
				" round("+owneramount+"*"+ownerid+",2) baseamt,'"+voucherdesc+"' desc1,h.account acno,	h.description acname,h.atype type from my_head h  left join my_curr cr on"+
				" cr.doc_no=h.curId where h.doc_no="+owneracno;
//	        	System.out.println(strSql);
				ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmt.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	    return RESULTDATA;
	}
}
