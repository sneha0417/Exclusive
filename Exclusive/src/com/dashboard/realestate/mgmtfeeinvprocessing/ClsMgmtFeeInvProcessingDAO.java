package com.dashboard.realestate.mgmtfeeinvprocessing;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsMgmtFeeInvProcessingDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public   JSONArray getContractData(String branch,String fromdate,String todate,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1"))
	    {
	    	return data;
	    }
	    java.sql.Date sqlfromdate = null;
	    String sqltest="",resval="",sqljoin="";
	    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
     		//sqltest+=" and pyt.date>='"+sqlfromdate+"'";
     	}
        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=objcommon.changeStringtoSqlDate(todate);
     		//sqltest+=" and m.date<='"+sqltodate+"'";
     	}
        
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
     	Connection conn = null;
        
		try{
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement ();  
			
			String sqltst = "select method from gl_config where field_nme like'tenancycontracttype'";
				
			    ResultSet rs = stm.executeQuery(sqltst);
				
				while(rs.next()) {
					resval=rs.getString("method");
				} 
			if(resval.equalsIgnoreCase("1")) {
				sqljoin=" union all "
						+ "select coalesce(date_format(m.invdate,'%d.%m.%Y'),date_format(Period_from,'%d.%m.%Y'))fromchk, coalesce(date_format(m.invtodate,'%d.%m.%Y'),date_format(last_day(m.Period_from),'%d.%m.%Y'))tochk,coalesce(m.invdate,Period_from) chqdt,m.doc_no detaildocno,'Rental Value' pytdesc,0.0 mgmtamt,round(coalesce((sum(ms.amount)/day(last_day(coalesce(m.invtodate,Period_from))))*(datediff(coalesce(m.invtodate,last_day(m.Period_from)),coalesce(m.invdate,Period_from))),0.0),2) rentalamt,ownerhead.description owner,m.recieptstatus,m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.name pname,case when m.ttype=1 then 'Residence' when m.ttype=2 then 'Commercial' when m.ttype=3 then 'Sub Lease' end protype,if(m.Period=1,'Years','Months') Period, m.Period_no, coalesce(m.invdate,Period_from)Period_from, convert(coalesce(m.invtodate,last_day(m.Period_from)),char(50))Period_to,m.not_Period,m.nettotal totalamount from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno left join my_head ownerhead on (pm.acno=ownerhead.doc_no) left join rl_tncterms ms on m.doc_no=ms.rdocno where m.status=3 and m.ttype=3  and clstatus=0 and ms.amount>0.0 and coalesce(m.invtodate,last_day(m.Period_from))<='"+sqltodate+"' "+sqltest+" group by m.doc_no\r\n" + 
						"union all \r\n" + 
						"select  coalesce(date_format(m.invdate,'%d.%m.%Y'),date_format(Period_from,'%d.%m.%Y'))fromchk ,date_format(cs.closedate,'%d.%m.%Y') tochk,coalesce(m.invdate,Period_from) chqdt,m.doc_no detaildocno,'Rental Value' pytdesc,0.0 mgmtamt,round(coalesce((sum(ms.amount)/day(last_day(coalesce(m.invtodate,Period_from))))*datediff(cs.closedate,coalesce(m.invdate,Period_from)),0.0),2) rentalamt,ownerhead.description owner,m.recieptstatus,m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.name pname,case when m.ttype=1 then 'Residence' when m.ttype=2 then 'Commercial' when m.ttype=3 then 'Sub Lease' end protype,if(m.Period=1,'Years','Months') Period, m.Period_no, coalesce(m.invdate,Period_from)Period_from ,convert(date_format(cs.closedate,'%Y-%m-%d'),char(50)) Period_to,m.not_Period,m.nettotal totalamount from rl_tncclose cs left join rl_tncm  m on cs.contractno=m.doc_no left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno left join my_head ownerhead on (pm.acno=ownerhead.doc_no) left join rl_tncterms ms on m.doc_no=ms.rdocno where m.status=3 and  m.ttype=3  and clstatus=1 and ms.amount>0.0 and cs.closedate<='"+sqltodate+"' "+sqltest+" and cs.prinv=0   group by cs.contractno";
			}
				
				
			String sql="select date_format(m.Period_from,'%d.%m.%Y') fromchk, date_format(m.Period_to,'%d.%m.%Y') tochk,pyt.date chqdt,pyt.doc_no detaildocno,coalesce(pyt.desc1,'') pytdesc,0.0 mgmtamt,round(coalesce(pyt.pamount,0.0),2) rentalamt,ownerhead.description"+
			" owner,m.recieptstatus,m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.name pname,if(m.ttype=1,'Residence','Commercial')"+
			" protype,if(m.Period=1,'Years','Months') Period, m.Period_no, m.Period_from, convert(m.Period_to,char(50))Period_to, m.not_Period,m.nettotal totalamount"+
			" from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno left join my_head"+
			" ownerhead on (pm.acno=ownerhead.doc_no) left join rl_tncpayment pyt on (pyt.privdocno=0 and m.doc_no=pyt.rdocno)"+
			" where m.status=3 and m.recieptstatus=1 and m.pstatus>0 and clstatus=0 and pyt.pamount>0.0 and pyt.date<='"+sqltodate+"' "+sqltest+" union all"+
			" select date_format(m.Period_from,'%d.%m.%Y') fromchk, date_format(m.Period_to,'%d.%m.%Y') tochk,mgmt.date chqdt,mgmt.id detaildocno,'Mgmt Fee' pytdesc,round(coalesce(mgmt.amount,0.0),2) mgmtamt,0.0 rentalamt,ownerhead.description"+
			" owner,m.recieptstatus,m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.name pname,if(m.ttype=1,'Residence','Commercial')"+
			" protype,if(m.Period=1,'Years','Months') Period, m.Period_no, m.Period_from, convert(m.Period_to,char(50))Period_to, m.not_Period,m.nettotal totalamount"+
			" from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno left join my_head"+
			" ownerhead on (pm.acno=ownerhead.doc_no) left join rl_tncmanagefee mgmt on (mgmt.privdocno=0 and mgmt.tdoc_no=m.doc_no)"+
			" where m.status=3 and m.recieptstatus=1 and m.pstatus>0 and clstatus=0 and mgmt.amount>0.0 and mgmt.date<='"+sqltodate+"' "+sqltest+" "+sqljoin+" ";
			System.out.println("-----fghfghhgdgdg------"+sql);
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
