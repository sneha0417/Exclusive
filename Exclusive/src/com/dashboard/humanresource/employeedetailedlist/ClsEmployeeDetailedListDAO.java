package com.dashboard.humanresource.employeedetailedlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEmployeeDetailedListDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray employeeListGridLoading(String department, String category, String empId, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		 if(!(check.equalsIgnoreCase("1"))){
			 return RESULTDATA;
		 }
		 
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			
			     String sqlAllowanceName = "",sqlAllowanceJoins = "",sqlDocumentsName = "",sqlDocumentsJoins = "", sqls="";
			     
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
			     
			     analysiscolumnarray.add("Sr No.::id::center::center:: ::5%:: :: :: :: ");
			     analysiscolumnarray.add("Emp ID::empid::left::left:: ::8%:: :: :: :: ");
			     analysiscolumnarray.add("Name::name::left::left:: ::18%:: :: :: :: ");
			     analysiscolumnarray.add("Designation::designation::left::left:: ::9%:: :: :: :: ");
			     analysiscolumnarray.add("Department::department::left::left:: ::9%:: :: :: :: ");
			     analysiscolumnarray.add("Category::category::left::left:: ::9%:: :: :: :: ");
			     analysiscolumnarray.add("Date of Join::dtjoin::left::left:: ::7%::dd.MM.yyyy:: :: :: ");
			     analysiscolumnarray.add("Address::address::left::left:: ::20%:: :: :: :: ");
			     analysiscolumnarray.add("Mobile::mobile::left::left:: ::10%:: :: :: :: ");
			     analysiscolumnarray.add("Email Id::email::left::left:: ::15%:: :: :: :: ");
			     analysiscolumnarray.add("DOB::dob::left::left:: ::7%::dd.MM.yyyy:: :: :: ");
			     analysiscolumnarray.add("Gender::gender::left::left:: ::7%:: :: :: :: ");
			     analysiscolumnarray.add("Bank Account::bankaccount::left::left:: ::15%:: :: :: :: ");
			     analysiscolumnarray.add("IFSC Code::ifsccode::left::left:: ::7%:: :: :: :: ");
			     analysiscolumnarray.add("Est. Code::estcode::left::left:: ::7%:: :: :: :: ");
			     analysiscolumnarray.add("Company::compname::left::left:: ::12%:: :: :: :: ");
			     
			     analysiscolumnarray.add("Status::status::left::left:: ::9%:: :: :: :: ");
			     analysiscolumnarray.add("Basic Salary::basicsalary::right::right:: ::12%::d2:: :: :: ");
			     
			     String sql = "select desc1 from hr_setallowance where status=3 and doc_no>0";
				 ResultSet resultSet = stmtEMP.executeQuery(sql);
				 int i=1,totalallowance=0;
				 while(resultSet.next()) {
				 		sqlAllowanceName+=",coalesce(s"+i+".allowance"+i+",0) allowance"+i+"";
				 		sqlAllowanceJoins+=" left join (select rdocno,round(coalesce((addition-deduction),0),2) allowance"+i+" from hr_empsal where awlId="+i+" and refdtype='ALC') s"+i+" on m.doc_no=s"+i+".rdocno";
				 		analysiscolumnarray.add(""+resultSet.getString("desc1")+"::allowance"+i+"::right::right:: ::12%::d2:: :: :: ");
				 		totalallowance=totalallowance+1;
						i++;
				  }
					
				 String sql1 = "select desc1 from hr_setdoc where status=3";
				 ResultSet resultSet1 = stmtEMP.executeQuery(sql1);
				 int j=1,totaldocuments=0;
				 while(resultSet1.next()) {
				 		sqlDocumentsName+=",d"+j+".docidnum"+j+",d"+j+".issdt"+j+",d"+j+".expdt"+j+",d"+j+".placeofiss"+j+"";
				 		sqlDocumentsJoins+=" left join (select rdocno,docidnum docidnum"+j+",issdt issdt"+j+",expdt expdt"+j+",placeofiss placeofiss"+j+" from hr_empdoc where docid="+j+") d"+j+" on m.doc_no=d"+j+".rdocno";
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" No::docidnum"+j+"::left::left:: ::15%:: :: :: :: ");
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" Issued Date::issdt"+j+"::left::left:: ::15%::dd.MM.yyyy:: :: :: ");
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" Expiry Date::expdt"+j+"::left::left:: ::15%::dd.MM.yyyy:: :: :: ");
				 		analysiscolumnarray.add(""+resultSet1.getString("desc1")+" Issued Place::placeofiss"+j+"::left::left:: ::25%:: :: :: :: ");
				 		totaldocuments=totaldocuments+1;
				 		j++;
				  }
			     
			        
			     if(!department.equalsIgnoreCase("")){
			    	 sqls+=" and m.dept_id="+department+"";
				 }
			     
			     if(!category.equalsIgnoreCase("")){
			    	 sqls+=" and m.pay_catid="+category+"";
				 }
			     
			     if(!empId.equalsIgnoreCase("")){
			    	 sqls+=" and m.cldocno="+empId+"";
				 }
			     
		    	String sql3 = "select @i:=@i+1 id,a.* from ( select m.codeno empid,m.name,des.desc1 designation,dep.desc1 department,cat.desc1 category,m.dtjoin,m.pmaddr address,"
		    			+ "if(m.active=1,'ACTIVE','TERMINATED') status,m.pmmob mobile,m.pmemail email,m.dob,m.gender,m.bnk_acc_no bankaccount,m.ifsccode,coalesce(m.est_code,'') estcode,"
		    			+ "coalesce(m.co_name,'') compname,s.basicsalary"+sqlAllowanceName+""+sqlDocumentsName+" from hr_empm m left join hr_setdept dep on m.dept_id=dep.doc_no "
		    			+ "left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join (select rdocno,round(coalesce((addition-deduction),0),2) basicsalary "
		    			+ "from hr_empsal where awlId=0 and refdtype=0) s on m.doc_no=s.rdocno "+sqlAllowanceJoins+""+sqlDocumentsJoins+" where 1=1"+sqls+" order by CAST(CODENO  AS UNSIGNED) ) a,(SELECT @i:= 0) as i  ";
     			 
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     
				 ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
	
					while(resultSet3.next()){
						ArrayList<String> temp=new ArrayList<String>();
						
						temp.add(resultSet3.getString("id"));
						temp.add(resultSet3.getString("empid"));
						temp.add(resultSet3.getString("name"));
						temp.add(resultSet3.getString("designation"));
						temp.add(resultSet3.getString("department"));
						temp.add(resultSet3.getString("category"));
						temp.add(resultSet3.getString("dtjoin"));
						temp.add(resultSet3.getString("address"));
						temp.add(resultSet3.getString("mobile"));
						temp.add(resultSet3.getString("email"));
						temp.add(resultSet3.getString("dob"));
						temp.add(resultSet3.getString("gender"));
						temp.add(resultSet3.getString("bankaccount"));
						temp.add(resultSet3.getString("ifsccode"));
						temp.add(resultSet3.getString("estcode"));
						temp.add(resultSet3.getString("compname"));
						temp.add(resultSet3.getString("status"));
						temp.add(resultSet3.getString("basicsalary"));
						
						for(int k=1;k<=totalallowance;k++){
							temp.add(resultSet3.getString("allowance"+k+""));
						}
						
						for(int l=1;l<=totaldocuments;l++){
							temp.add(resultSet3.getString("docidnum"+l+""));
							temp.add(resultSet3.getString("issdt"+l+""));
							temp.add(resultSet3.getString("expdt"+l+""));
							temp.add(resultSet3.getString("placeofiss"+l+""));
						}
						
						analysisrowarray.add(temp);
					}
				 
				 COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
				 
				 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray,totalallowance,totaldocuments);
	
				 JSONArray analysisarray=new JSONArray();
				 
				 analysisarray.addAll(COLUMNDATA);
				 analysisarray.addAll(ROWDATA);
				 RESULTDATA=analysisarray;
			 
			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
       }
	
	public JSONArray employeeListExcelExport(String department, String category, String empId, String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();

		 if(!(check.equalsIgnoreCase("1"))){
			 return RESULTDATA;
		 }
		 
		 Connection conn =  null;
		
		 try {
			 	 conn = ClsConnection.getMyConnection();
			 	 Statement stmtEMP = conn.createStatement();
			     
			     String sqlAllowanceName = "",sqlAllowanceJoins = "",sqlDocumentsName = "",sqlDocumentsJoins = "", sqls="";
			     
			     String sql = "select desc1 from hr_setallowance where status=3 and doc_no>0";
				 ResultSet resultSet = stmtEMP.executeQuery(sql);
				 int i=1;
				 while(resultSet.next()) {
				 		sqlAllowanceName+=",coalesce(s"+i+".allowance"+i+",0) '"+resultSet.getString("desc1")+"'";
				 		sqlAllowanceJoins+=" left join (select rdocno,round(coalesce((addition-deduction),0),2) allowance"+i+" from hr_empsal where awlId="+i+" and refdtype='ALC') s"+i+" on m.doc_no=s"+i+".rdocno";
						i++;
				  }
					
				 String sql1 = "select desc1 from hr_setdoc where status=3";
				 ResultSet resultSet1 = stmtEMP.executeQuery(sql1);
				 int j=1;
				 while(resultSet1.next()) {
				 		sqlDocumentsName+=",d"+j+".docidnum"+j+" '"+resultSet1.getString("desc1")+" No',d"+j+".issdt"+j+" '"+resultSet1.getString("desc1")+" Issued Date',d"+j+".expdt"+j+" '"+resultSet1.getString("desc1")+" Expiry Date',d"+j+".placeofiss"+j+" '"+resultSet1.getString("desc1")+" Issued Place'";
				 		sqlDocumentsJoins+=" left join (select rdocno,docidnum docidnum"+j+",issdt issdt"+j+",expdt expdt"+j+",placeofiss placeofiss"+j+" from hr_empdoc where docid="+j+") d"+j+" on m.doc_no=d"+j+".rdocno";
				 		j++;
				  }
			     
			        
			     if(!department.equalsIgnoreCase("")){
			    	 sqls+=" and m.dept_id="+department+"";
				 }
			     
			     if(!category.equalsIgnoreCase("")){
			    	 sqls+=" and m.pay_catid="+category+"";
				 }
			     
			     if(!empId.equalsIgnoreCase("")){
			    	 sqls+=" and m.cldocno="+empId+"";
				 }
			     
		    	String sql3 = "select @i:=@i+1 id,a.* from ( select m.codeno 'Emp ID',m.name 'Name',des.desc1 'Designation',dep.desc1 'Department',cat.desc1 'Category',m.dtjoin 'Date of Join',m.pmaddr 'Address',"
		    			+ "m.pmmob 'Mobile',m.pmemail 'Email Id',m.dob 'DOB',m.gender 'Gender',m.bnk_acc_no 'Bank Account',m.ifsccode 'IFSC Code',coalesce(m.est_code,'') 'Est. Code',"
		    			+ "coalesce(m.co_name,'') 'Company',if(m.active=1,'ACTIVE','TERMINATED') 'Status',s.basicsalary 'Basic Salary'"+sqlAllowanceName+""+sqlDocumentsName+" from hr_empm m "
		    			+ "left join hr_setdept dep on m.dept_id=dep.doc_no left join hr_setdesig des on m.desc_id=des.doc_no left join hr_setpaycat cat on m.pay_catid=cat.doc_no "
		    			+ "left join (select rdocno,round(coalesce((addition-deduction),0),2) basicsalary from hr_empsal where awlId=0 and refdtype=0) s on m.doc_no=s.rdocno "
		    			+ ""+sqlAllowanceJoins+""+sqlDocumentsJoins+" where 1=1"+sqls+"  order by CAST(CODENO  AS UNSIGNED)) a,(SELECT @i:= 0) as i";
			    
			     ResultSet resultSet3 = stmtEMP.executeQuery(sql3);
			     
			     RESULTDATA=ClsCommon.convertToEXCEL(resultSet3);
			     
			 stmtEMP.close();
			 conn.close();

			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact,String check) throws SQLException {
		 JSONArray RESULTDATA1=new JSONArray();
	
	    if(!(check.equalsIgnoreCase("1"))){
	    	return RESULTDATA1;
	    }
		Connection conn=null;
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtEMP = conn.createStatement();
			
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
	            
				sql = "select doc_no,codeno,UPPER(name) name,pmmob from hr_empm where 1=1"+sql;
				
				ResultSet resultSet1 = stmtEMP.executeQuery(sql);
				
				RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				
				stmtEMP.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
  
	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			if(!(analysisColumnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("columngroup",analysisColumnArray[8]);
			}
			if(!(analysisColumnArray[9].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",analysisColumnArray[9]);
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList,int totalallowance,int totaldocuments) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("empid",analysisRowArray.get(1));
			obj.put("name",analysisRowArray.get(2));
			obj.put("designation",analysisRowArray.get(3));
			obj.put("department",analysisRowArray.get(4));
			obj.put("category",analysisRowArray.get(5));
			obj.put("dtjoin",analysisRowArray.get(6));
			obj.put("address",analysisRowArray.get(7));
			obj.put("mobile",analysisRowArray.get(8));
			obj.put("email",analysisRowArray.get(9));
			obj.put("dob",analysisRowArray.get(10));
			obj.put("gender",analysisRowArray.get(11));
			obj.put("bankaccount",analysisRowArray.get(12));
			obj.put("ifsccode",analysisRowArray.get(13));
			obj.put("estcode",analysisRowArray.get(14));
			obj.put("compname",analysisRowArray.get(15));
			obj.put("status",analysisRowArray.get(16));
			obj.put("basicsalary",analysisRowArray.get(17));
			
			int m=1,o=18;
			for(m=1,o=18;m<=totalallowance;m++,o++){
				obj.put("allowance"+m,analysisRowArray.get(o));
			}
			
			for(int n=1,p=o;n<=totaldocuments;n++,p++){
				obj.put("docidnum"+n,analysisRowArray.get(p));
				obj.put("issdt"+n,analysisRowArray.get(p+1));
				obj.put("expdt"+n,analysisRowArray.get(p+2));
				obj.put("placeofiss"+n,analysisRowArray.get(p+3));
				p=(p+3);
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
}
