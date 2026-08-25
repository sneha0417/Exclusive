package com.dashboard.realestate.ownerdirectpaymentupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsOwnerDirectPaymentUpdateDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public   JSONArray getContractData(String todate,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1"))
	    {
	    	return data;
	    }
        java.sql.Date sqltodate = null;
     	String sqltest="";
        if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		sqltest+=" and pyt.date<='"+sqltodate+"'";
     	}
     	Connection conn = null;
        
		try{
			conn = objconn.getMyConnection();   
			Statement stm = conn.createStatement ();     
			String sql="select pyt.doc_no detaildocno,owner.primary_owner owner,pyt.notes,pyt.desc1 paymentdesc,pyt.date chequedate,pyt.pamount amount,pyt.chqno chequeno,m.recieptstatus, m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.accname pname,if(m.ttype=1,'Residence','Commercial') protype, if(m.Period=1,'Years','Months') Period, m.Period_no, m.Period_from, m.Period_to, m.not_Period,m.nettotal totalamount from rl_tncm m left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno left join rl_tncpayment pyt on (m.doc_no=pyt.rdocno and pyt.paidto='Owner') left join rl_propertryowner owner on (pm.owid=owner.doc_no) "
					+ " where m.status=3 and pyt.refno!=0 and clstatus=0 and pyt.ownerpytsettletrno=0 and pyt.doc_no is not null and dpupdate=0 "+sqltest+"";
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
}
