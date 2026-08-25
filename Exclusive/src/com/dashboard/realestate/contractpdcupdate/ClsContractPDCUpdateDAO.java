package com.dashboard.realestate.contractpdcupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsContractPDCUpdateDAO {

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
			String sql="select brv.doc_no brvdocno,pyt.refno paymenttrno,a.acno tenantacno,pyt.doc_no detaildocno,ownerhead.description owner,pyt.notes,pyt.desc1 paymentdesc,pyt.date chequedate,pyt.pamount amount,pyt.chqno chequeno,m.recieptstatus,"+
			" m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.accname pname,if(m.ttype=1,'Residence','Commercial') protype, "+
			" if(m.Period=1,'Years','Months') Period, m.Period_no, m.Period_from, m.Period_to, m.not_Period,m.nettotal totalamount"+
			" from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno "+
			" left join rl_tncpayment pyt on (m.doc_no=pyt.rdocno and pyt.desc1='Rental Value' and pyt.paidto='Self') left my_chqbm brv on pyt.refno=brv.tr_no left join my_head "+
			" ownerhead on (pm.acno=ownerhead.doc_no) left join my_chqdet chq on chq.tr_no=pyt.refno where m.status=3 and m.recieptstatus=1 and clstatus=0 and pyt.ownerpytsettletrno=0 and "+
			" pyt.doc_no is not null and chq.status in ('D','R') "+sqltest;
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
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }
	
	public JSONArray brvSearchData(String type,String id,HttpSession session,String paymenttrno,String tenantacno) throws SQLException {
        JSONArray data=new JSONArray();
        if(!(id.equalsIgnoreCase("1"))) {
        	return data;
        }
        Connection conn = null;
        try {
	       conn = objconn.getMyConnection();
	       Statement stmtBRV = conn.createStatement();
	       String sql="";
	       String branch=session.getAttribute("BRANCHID")==null?"1":session.getAttribute("BRANCHID").toString();
	       if(type.equalsIgnoreCase("0")){
	    	   sql="select m.tr_no,m.date,m.doc_no,m.totalAmount amount,h.description,m.chqno,"+
	    	   " m.chqdt from  my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no and d.sr_no=1 left join my_chqdet c on c.tr_no=d.tr_no"+
	    	   " left join my_head h on d.acno=h.doc_no left join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.dtype='BRV' and m.status <> 7  and"+
	    	   " c.status in ('D','R') and d.acno="+tenantacno+" and m.tr_no="+paymenttrno;
	       }
	       else if(type.equalsIgnoreCase("1")){
	    	   sql="select m.tr_no,m.date,m.doc_no,m.totalAmount amount,h.description,m.chqno,"+
	    	   " m.chqdt from  my_chqbm m left join my_chqbd d on m.tr_no=d.tr_no and d.sr_no=1 left join my_chqdet c on c.tr_no=d.tr_no"+
	    	   " left join my_head h on d.acno=h.doc_no left join my_brch b on m.brhid=b.doc_no where m.brhid="+branch+" and m.dtype='BRV' and "+
	    	   " m.status <> 7  and c.status in ('E','P') and c.pdc=1 and d.acno="+tenantacno;
	       }
	       
	       System.out.println(sql);
	       ResultSet resultSet = stmtBRV.executeQuery(sql);
	       data=objcommon.convertToJSON(resultSet);

	       stmtBRV.close();
	       conn.close();
     }
     catch(Exception e){
    	   e.printStackTrace();
    	   conn.close();
     }finally{
			conn.close();
		}
        return data;
   }
}
