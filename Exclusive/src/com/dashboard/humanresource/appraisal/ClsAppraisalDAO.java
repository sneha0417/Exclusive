package com.dashboard.humanresource.appraisal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAppraisalDAO  {
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();

	public JSONArray appraisalDetailsGridLoading(String year, String month, String department, String category, String employee, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtHSAP = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
		        	String sql = "",totallowances="0";
		        	
		        	String sqltot="select count(*) totallowances from hr_setallowance where status=3 and doc_no>0";
		            ResultSet resultSettot = stmtHSAP.executeQuery(sqltot);
		            
		            while(resultSettot.next()){
		            	totallowances=resultSettot.getString("totallowances");
		            }
		            
		    	    if(!(category.equalsIgnoreCase(""))){
		                sql=sql+" and if(m.revised=0,m.catid,m.revcatId)='"+category+"'";
		            }
		            if(!(department.equalsIgnoreCase(""))){
		            	sql=sql+" and if(m.revised=0,m.deptid,m.revdeptId)='"+department+"'";
		            }
		            if(!(employee.equalsIgnoreCase("")) && !(employee.equalsIgnoreCase("0"))){
		                sql=sql+" and m.empid='"+employee+"'";
		            }
		            if(!(month.equalsIgnoreCase(""))){
		                sql=sql+" and m.month='"+month+"'";
		            }
		            
					sql = "select a.date, a.doc_no, a.dtype, a.upto,a.employeeid,a.employeename,a.designation,a.department,a.category,CONVERT(if(sum(a.basic)=0,' ',sum(a.basic)),CHAR(100)) basic,"  
						+ "CONVERT(if(sum(a.allowance1)=0,' ',sum(a.allowance1)),CHAR(100)) allowance1,CONVERT(if(sum(a.allowance2)=0,' ',sum(a.allowance2)),CHAR(100)) allowance2,"
						+ "CONVERT(if(sum(a.allowance3)=0,' ',sum(a.allowance3)),CHAR(100)) allowance3,CONVERT(if(sum(a.allowance4)=0,' ',sum(a.allowance4)),CHAR(100)) allowance4,"  
						+ "CONVERT(if(sum(a.allowance5)=0,' ',sum(a.allowance5)),CHAR(100)) allowance5,CONVERT(if(sum(a.allowance6)=0,' ',sum(a.allowance6)),CHAR(100)) allowance6,"  
						+ "CONVERT(if(sum(a.allowance7)=0,' ',sum(a.allowance7)),CHAR(100)) allowance7,CONVERT(if(sum(a.allowance8)=0,' ',sum(a.allowance8)),CHAR(100)) allowance8,"  
						+ "CONVERT(if(sum(a.allowance9)=0,' ',sum(a.allowance9)),CHAR(100)) allowance9,CONVERT(if(sum(a.allowance10)=0,' ',sum(a.allowance10)),CHAR(100)) allowance10," 
						+ "CONVERT(if((sum(a.basic)+sum(a.allowance1)+sum(a.allowance2)+sum(a.allowance3)+sum(a.allowance4)+sum(a.allowance5)+sum(a.allowance6)+sum(a.allowance7)+sum(a.allowance8)+"
						+ "sum(a.allowance9)+sum(a.allowance10))=0,' ',(sum(a.basic)+sum(a.allowance1)+sum(a.allowance2)+sum(a.allowance3)+sum(a.allowance4)+sum(a.allowance5)+sum(a.allowance6)+"
						+ "sum(a.allowance7)+sum(a.allowance8)+sum(a.allowance9)+sum(a.allowance10))),CHAR(100)) totalsalary from ( " 
						+ "select m.doc_no, m.date, m.dtype, m.empId, d.awlId, d.refdtype, m.upto,d.addition, d.deduction, d.statutorydeduction,if(d.awlId=0 and d.refdtype=0,round((d.revadd-d.revded),2),0) basic," 
						+ "if(d.awlId=1 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance1,if(d.awlId=2 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance2,"  
						+ "if(d.awlId=3 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance3,if(d.awlId=4 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance4,"  
						+ "if(d.awlId=5 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance5,if(d.awlId=6 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance6,"  
						+ "if(d.awlId=7 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance7,if(d.awlId=8 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance8," 
						+ "if(d.awlId=9 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance9,if(d.awlId=10 and d.refdtype='ALC',round((d.revadd-d.revded),2),0) allowance10," 
						+ "d.revadd,d.revded, d.revstatded, e.codeno employeeid,e.name employeename,ds.desc1 designation,dp.desc1 department,c.desc1 category from hr_incrm m left join hr_incrd d "
						+ "on m.doc_no=d.rdocno left join hr_empm e on m.empid=e.doc_no left join hr_setdesig ds on ds.doc_no=if(m.revised=0,m.desigid,m.revdesigId) left join hr_setdept dp on "
						+ "dp.doc_no=if(m.revised=0,m.deptid,m.revdeptId) left join hr_setpaycat c on c.doc_no=if(m.revised=0,m.catid,m.revcatId) where m.status=3 and e.status=3 and e.active=1 "
						+ "and m.year<="+year+""+sql+" ) a group by a.empid,doc_no order by empid";
				
						ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
						ResultSet resultSet1 = stmtHSAP.executeQuery(sql);
						
						while(resultSet1.next()){
							ArrayList<String> temp=new ArrayList<String>();
								
							temp.add(resultSet1.getString("employeeid"));
							temp.add(resultSet1.getString("employeename"));
							temp.add(resultSet1.getString("designation"));
							temp.add(resultSet1.getString("department"));
							temp.add(resultSet1.getString("category"));
							temp.add(resultSet1.getString("basic"));
							temp.add(resultSet1.getString("allowance1"));
							temp.add(resultSet1.getString("allowance2"));
							temp.add(resultSet1.getString("allowance3"));
							temp.add(resultSet1.getString("allowance4"));
							temp.add(resultSet1.getString("allowance5"));
							temp.add(resultSet1.getString("allowance6"));
							temp.add(resultSet1.getString("allowance7"));
							temp.add(resultSet1.getString("allowance8"));
							temp.add(resultSet1.getString("allowance9"));
							temp.add(resultSet1.getString("allowance10"));
							temp.add(resultSet1.getString("totalsalary"));
							temp.add(resultSet1.getString("dtype"));
							temp.add(totallowances);
							
							analysisrowarray.add(temp);
								
						}
						
						RESULTDATA1=convertRowArrayToJSON(analysisrowarray);
		        }
		        
		        stmtHSAP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact,String check) throws SQLException {
		 JSONArray RESULTDATA1=new JSONArray();
	
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
		Connection conn=null;
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtHSAP = conn.createStatement();
			
	    	    String sql = "";
				
	    	    if(!(empid.equalsIgnoreCase(""))){
	                sql=sql+" and codeno like '%"+empid+"%'";
	            }
	            if(!(employeename.equalsIgnoreCase(""))){
	             sql=sql+" and name like '%"+employeename+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and pmmob like '%"+contact+"%'";
	            }
	            
				sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where active=1 and status=3"+sql;
				
				ResultSet resultSet1 = stmtHSAP.executeQuery(sql);
				
				RESULTDATA1=commonDAO.convertToJSON(resultSet1);
				
				stmtHSAP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}


public  JSONArray convertRowArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		  JSONArray jsonArray = new JSONArray();
		  
		  for (int i = 0; i < rowsAnalysisList.size(); i++) {
		   
		   JSONObject obj = new JSONObject();
		   ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
		   
		   obj.put("employeeid",analysisRowArray.get(0));
		   obj.put("employeename",analysisRowArray.get(1));
		   obj.put("designation",analysisRowArray.get(2));
		   obj.put("department",analysisRowArray.get(3));
		   obj.put("category",analysisRowArray.get(4));
		   obj.put("basic",analysisRowArray.get(5));
		   obj.put("allowance1",analysisRowArray.get(6));
		   obj.put("allowance2",analysisRowArray.get(7));
		   obj.put("allowance3",analysisRowArray.get(8));
		   obj.put("allowance4",analysisRowArray.get(9));
		   obj.put("allowance5",analysisRowArray.get(10));
		   obj.put("allowance6",analysisRowArray.get(11));
		   obj.put("allowance7",analysisRowArray.get(12));
		   obj.put("allowance8",analysisRowArray.get(13));
		   obj.put("allowance9",analysisRowArray.get(14));
		   obj.put("allowance10",analysisRowArray.get(15));
		   obj.put("totalsalary",analysisRowArray.get(16));
		   obj.put("dtype",analysisRowArray.get(17));
		   obj.put("totallowancesavailable",analysisRowArray.get(18));
		   
		   jsonArray.add(obj);
		  }
		  return jsonArray;
		  }
	
}
