package com.dashboard.realestate.maintenancereview;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsMaintenanceReviewDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	public JSONArray getPropertyData(String pdocno,String id,String unitno,String frmld,String from,String to) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();         
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		System.out.println("unitno==="+unitno);
		String sqltest="",sqltest2="";
		if(!unitno.equalsIgnoreCase("")){    
			sqltest=" and p.unitno='"+unitno+"'";     
		} 
		if(frmld.equalsIgnoreCase("pending")){    
			sqltest2=" and r.statusid!=5";     
		} 
		
		Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();
			 java.sql.Date sqltodate = null,sqlfromdate=null;
			 String sqltest1="";
			 if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0")))
		     	{
				 sqlfromdate=ClsCommon.changeStringtoSqlDate(from);
		     		
		     	}
		     	if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(to);
		     		
		     	}
		     	if(sqlfromdate!=null && sqltodate!=null ){
		     		sqltest1="and r.edate between '"+sqlfromdate+"' and '"+sqltodate+"' ";
		     	}

		        
			 String strsql="select  rm.cpuvoc,rm.invvoc,r.jv_vocno,r.blockamt,r.branch brhid,r.confirm,r.voc_no,r.comments,ac.refname tenant,r.edate date,rm.estval amount,rm.margin profit,rm.total,rm.description compremark,st.name status,j.job_desc job,h.description proname,rm.paytype from re_mreq r inner join re_mreqmgmt rm on rm.rdocno=r.doc_no left join my_acbook ac on (ac.cldocno=r.tdoc_no and ac.dtype='crm') left join rl_propertymaster p on (p.doc_no=r.pdoc_no) left join re_pstatus st on st.doc_no=r.statusid left join rl_jobmaster j on j.doc_no=rm.jobdocno left join my_head h on (h.doc_no=rm.vndacno and h.atype='ap') where r.status=3 and p.doc_no='"+pdocno+"' "+sqltest+" "+sqltest2+" "+sqltest1+" order by r.doc_no,r.confirm asc"; 
			 //System.out.println("propsql---->>>"+strsql);             
			ResultSet resultSet = stmt.executeQuery(strsql);        
			RESULTDATA=ClsCommon.convertToJSON(resultSet);   
		}catch(Exception e){   
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
}
