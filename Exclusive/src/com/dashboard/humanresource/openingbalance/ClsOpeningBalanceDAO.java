package com.dashboard.humanresource.openingbalance;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsOpeningBalanceDAO  {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
	
	public int insert(String mainbranch,String txtselectedemployees, String[] empidarray,ArrayList<String> openingbalancearray, HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		 Connection conn  = null;
		  
			try{
				
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBOPN = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
		        
				Set<String> set = new HashSet<String>(Arrays.asList(empidarray));
				empidarray = set.toArray(new String[set.size()]);
				
		        int docno = 0, docNo=0, trno = 0;
		       /*Updatinghr_emptran*/
				for (int i = 0; i < empidarray.length; i++) {
					String empid=empidarray[i];	
					
					if(!(empid.equalsIgnoreCase(""))){
						 String sql1="delete from hr_emptran where dtype='OPN' and empid='"+empid+"'";
						 stmtBOPN.executeUpdate(sql1);
						 
						 String sql2="select coalesce(max(trno)+1,1) trno from my_trno";
					     ResultSet resultSet2 = stmtBOPN.executeQuery(sql2);
					  
					     while (resultSet2.next()) {
					        trno=resultSet2.getInt("trno");
					     }
					     
					     String sql3="select coalesce(max(doc_no)+1,1) doc_no from hr_emptran where dtype='OPN'";
					     ResultSet resultSet3 = stmtBOPN.executeQuery(sql3);
					  
					     while (resultSet3.next()) {
					    	 docno=resultSet3.getInt("doc_no");
					     }
						 
						 CallableStatement stmtBOPN1=null;
						 String[] openingbalance=openingbalancearray.get(i).split("::");
							if(!openingbalance[0].equalsIgnoreCase("undefined") && !openingbalance[0].equalsIgnoreCase("NaN")){
							    
								stmtBOPN1 = conn.prepareCall("INSERT INTO hr_emptran(date, doc_no, tr_no, empid, terminalbenefits_acno, leavesalary_acno, travels_acno, opn_terminalbenefits, opn_leavesalary, opn_travels,TERMINALBENEFITS_TOBEPOSTED , LEAVESALARY_TOBEPOSTED,TRAVELS_TOBEPOSTED , dtype, brhid) VALUES(now(),?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
								
								stmtBOPN1.setInt(1,docno);
								stmtBOPN1.setInt(2,trno);
								stmtBOPN1.setString(3,(openingbalance[0].trim().equalsIgnoreCase("undefined") || openingbalance[0].trim().equalsIgnoreCase("NaN") || openingbalance[0].trim().equalsIgnoreCase("") ||openingbalance[0].trim().isEmpty()?"0":openingbalance[0].trim()).toString());
								stmtBOPN1.setString(4,(openingbalance[1].trim().equalsIgnoreCase("undefined") || openingbalance[1].trim().equalsIgnoreCase("NaN") || openingbalance[1].trim().equalsIgnoreCase("") ||openingbalance[1].trim().isEmpty()?"0":openingbalance[1].trim()).toString());
								stmtBOPN1.setString(5,(openingbalance[1].trim().equalsIgnoreCase("undefined") || openingbalance[1].trim().equalsIgnoreCase("NaN") || openingbalance[1].trim().equalsIgnoreCase("") ||openingbalance[1].trim().isEmpty()?"0":openingbalance[1].trim()).toString());
								stmtBOPN1.setString(6,(openingbalance[1].trim().equalsIgnoreCase("undefined") || openingbalance[1].trim().equalsIgnoreCase("NaN") || openingbalance[1].trim().equalsIgnoreCase("") ||openingbalance[1].trim().isEmpty()?"0":openingbalance[1].trim()).toString());
								stmtBOPN1.setString(7,(openingbalance[2].trim().equalsIgnoreCase("undefined") || openingbalance[2].trim().equalsIgnoreCase("NaN") || openingbalance[2].trim().isEmpty()?"0":openingbalance[2].trim()).toString()); 
								stmtBOPN1.setString(8,(openingbalance[3].trim().equalsIgnoreCase("undefined") || openingbalance[3].trim().equalsIgnoreCase("NaN") || openingbalance[3].trim().isEmpty()?"0":openingbalance[3].trim()).toString());
								stmtBOPN1.setString(9,(openingbalance[4].trim().equalsIgnoreCase("undefined") || openingbalance[4].trim().equalsIgnoreCase("NaN") || openingbalance[4].trim().isEmpty()?"0":openingbalance[4].trim()).toString());
								stmtBOPN1.setString(10,(openingbalance[2].trim().equalsIgnoreCase("undefined") || openingbalance[2].trim().equalsIgnoreCase("NaN") || openingbalance[2].trim().isEmpty()?"0":openingbalance[2].trim()).toString()); 
								stmtBOPN1.setString(11,(openingbalance[3].trim().equalsIgnoreCase("undefined") || openingbalance[3].trim().equalsIgnoreCase("NaN") || openingbalance[3].trim().isEmpty()?"0":openingbalance[3].trim()).toString());
								stmtBOPN1.setString(12,(openingbalance[4].trim().equalsIgnoreCase("undefined") || openingbalance[4].trim().equalsIgnoreCase("NaN") || openingbalance[4].trim().isEmpty()?"0":openingbalance[4].trim()).toString());
								stmtBOPN1.setString(13,"OPN");
								stmtBOPN1.setString(14,branch);
								int data1 = stmtBOPN1.executeUpdate();
							    if(data1<=0){
									 stmtBOPN1.close();
									 conn.close();
									 return 0;
								 }
							 }
					    }
				     }
				/*Updating hr_emptran Ends*/
				
			    String sql="select coalesce(max(doc_no)+1,1) doc_no from hr_bopn";
		        ResultSet resultSet = stmtBOPN.executeQuery(sql);
		  
		        while (resultSet.next()) {
				   docNo=resultSet.getInt("doc_no");
		        }
		        
		        /*Inserting hr_bopn*/
			     String sql2="insert into hr_bopn(doc_no, date, tr_no, employeeIds, brhid, userid) values("+docNo+",now(),"+trno+",'"+txtselectedemployees+"',"+branch+","+userid+")";
			     int data1= stmtBOPN.executeUpdate(sql2);
				 if(data1<=0){
					 	stmtBOPN.close();
						conn.close();
						return 0;
					}
				 /*Inserting hr_bopn Ends*/
				 
				if(docno>0){
					
					 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+branch+"','BOPN',now(),'"+userid+"','A')";
					 int datas= stmtBOPN.executeUpdate(sqls);
					 if(datas<=0){
						 	stmtBOPN.close();
						    conn.close();
							return 0;
						}
					conn.commit();
					stmtBOPN.close();
					conn.close();
					return docno;
				}
			stmtBOPN.close();
			conn.close();	
		 } catch(Exception e){	
			 	conn.close();
			 	e.printStackTrace();	
			 	return 0;
		 } finally{
			 conn.close();
		 }
		return 0;
	}

	public JSONArray openingBalanceGridLoading(String category, String department, String employee, String check) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtBOPN = conn.createStatement();
		        
		        if(check.equalsIgnoreCase("1")) {
		       
	    	    String sql = "",sql1="";
				
	    	    if(!(category.equalsIgnoreCase("")) && !(category.equalsIgnoreCase("0")) && !(category.equalsIgnoreCase("null"))){
	                sql=sql+" and m.pay_catid='"+category+"'";
	            }
	            if(!(department.equalsIgnoreCase("")) && !(department.equalsIgnoreCase("0")) && !(department.equalsIgnoreCase("null"))){
	             sql=sql+" and m.dept_id='"+department+"'";
	            }
	            if(!(employee.equalsIgnoreCase("")) && !(employee.equalsIgnoreCase("0"))){
	                sql1=sql1+" and t.empid='"+employee+"'";
	                sql=sql+" and m.doc_no='"+employee+"'";
	            }
	            
				sql = "select * from (select t.empid empdocno,m.acno empacno,m.codeno empid,m.name empname,m.pay_catid categoryid,cat.desc1 category,dp.desc1 department,"
					+ "round(sum(opn_terminalbenefits),2) terminationbenefits,round(sum(opn_leavesalary),2) leavesalary,round(sum(opn_travels),2) travels "
					+ "from hr_emptran t left join hr_empm m on (t.empid=m.doc_no and m.dtype='EMP') left join hr_setpaycat cat on m.pay_catid=cat.doc_no "
					+ "left join hr_setdept dp on m.dept_id=dp.doc_no where t.dtype='OPN' and m.active=1 and m.status=3"+sql+""+sql1+" group by t.empid UNION ALL "
					+ "select m.doc_no empdocno,m.acno empacno,m.codeno empid,m.name empname,m.pay_catid categoryid,cat.desc1 category,dp.desc1 department,round(0,2) terminationbenefits,"
					+ "round(0,2) leavesalary,round(0,2) travels from hr_empm m left join hr_setpaycat cat on m.pay_catid=cat.doc_no left join hr_setdept dp on "
					+ "m.dept_id=dp.doc_no where m.active=1 and m.status=3"+sql+") a group by a.empdocno";
				
				ResultSet resultSet1 = stmtBOPN.executeQuery(sql);
				
				RESULTDATA1=commonDAO.convertToJSON(resultSet1);
		        
		        }
		        
		        stmtBOPN.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = connDAO.getMyConnection();
		        Statement stmtBOPN = conn.createStatement();
			
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
				
				ResultSet resultSet1 = stmtBOPN.executeQuery(sql);
				
				RESULTDATA1=commonDAO.convertToJSON(resultSet1);
				
				stmtBOPN.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
