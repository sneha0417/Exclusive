package com.dashboard.operations.staffallocateddamage;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLRecoverableException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsStaffAllocatedDamageDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray staffAllocatedGridLoading(String branch,String fromDate, String toDate, String type, String employee) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
        
		  try {
//			  System.out.println("Checkking: "+branch+"///"+fromDate+"////"+toDate+"/////"+type+"////"+employee);
			    conn = ClsConnection.getMyConnection();
			    Statement stmtdamage = conn.createStatement();
			    String sqltest="";
			    java.sql.Date sqlfromdate=null,sqltodate=null;
			    if((!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("undefined") && !branch.equalsIgnoreCase("0") && !branch.equalsIgnoreCase("a"))){
			    	sqltest=sqltest+" and insp.brhid="+branch+"";
			    }
			    if((!fromDate.equalsIgnoreCase("") && !fromDate.equalsIgnoreCase("0") && !fromDate.equalsIgnoreCase("undefined"))){
			    	sqlfromdate=ClsCommon.changeStringtoSqlDate(fromDate);
			    }
			    if((!toDate.equalsIgnoreCase("") && !toDate.equalsIgnoreCase("0") && !toDate.equalsIgnoreCase("undefined"))){
			    	sqltodate=ClsCommon.changeStringtoSqlDate(toDate);
			    }
			    if(sqlfromdate!=null && sqltodate!=null){
			    	sqltest=sqltest+" and insp.date>='"+sqlfromdate+"' and insp.date<='"+sqltodate+"'";
			    }
			    if(type.equalsIgnoreCase("STF")){
			    	sqltest=sqltest+" and nrm.movtype='ST'";
			    }
			    if(type.equalsIgnoreCase("DRV")){
			    	sqltest=sqltest+" and nrm.movtype<>'ST'";
			    }
			    if((!employee.equalsIgnoreCase("") && !employee.equalsIgnoreCase("0") && !employee.equalsIgnoreCase("undefined"))){
			    	if(type.equalsIgnoreCase("STF")){
			    		sqltest=sqltest+" and nrm.staffid="+employee+"";
			    	}
			    	else if(type.equalsIgnoreCase("DRV")){
			    		sqltest=sqltest+" and nrm.drid="+employee+"";
			    	}
			    }
			
			    String strsql="select insp.brhid,INSP.DATE,(select acno from gl_invmode where idno=10) damageacc,SAL.ACC_NO expacc,veh.reg_no regno,insp.doc_no inspno,insp.refdocno refno,insp.type,insp.amount,insp.rfleet fleetno,if(nrm.drid=0,nrm.staffid,nrm.drid) empno,"+
			    		" if(nrm.movtype='ST','STAFF','DRIVER') emp_type,sal.sal_name,convert(concat(' Fleet : ',veh.fleet_no,' ',veh.flname,' ',veh.reg_no,' * ',"+
			    		" 'Inspection No: ',insp.doc_no,' * ','Emp Type: ',if(nrm.movtype='ST','STAFF','DRIVER'),' * ','Emp Name: ',sal.sal_name),char(1000)) details"+
			    		" from gl_vinspm insp left join gl_nrm nrm on (insp.refdocno=nrm.doc_no and insp.reftype='NRM') left join my_salesman sal on "+
			    		" (if(nrm.movtype='ST',nrm.staffid=sal.doc_no and sal.sal_type='STF',nrm.drid=sal.doc_no and sal.sal_type='DRV')) left join gl_vehmaster"+
			    		" veh on insp.rfleet=veh.fleet_no where insp.invno=0 and insp.amount>0 and insp.reftype='NRM'"+sqltest;
				
				//System.out.println("SQL = "+strsql);
				
				ResultSet resultSet = stmtdamage.executeQuery(strsql);
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtdamage.close();
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
