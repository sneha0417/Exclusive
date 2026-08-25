package com.finance.transactions.budget;

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

public class ClsBudgetDAO {
	
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsBudgetBean budgetBean = new ClsBudgetBean();
	
	public int insert(Date budgetsDate, String formdetailcode, Date assessmentDate, String txtdescription, double txttotalincome, double txttotalexpenditure, String incomegridcolumn, String expendituregridcolumn,
			ArrayList<String> incomearray, ArrayList<String> expenditurearray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);

			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtBGT = conn.prepareCall("{CALL budgetmDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtBGT.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtBGT.setDate(1,budgetsDate);
			stmtBGT.setDate(2,assessmentDate);
			stmtBGT.setString(3,txtdescription);
			stmtBGT.setDouble(4,txttotalincome);
			stmtBGT.setDouble(5,txttotalexpenditure);
			stmtBGT.setString(6,formdetailcode);
			stmtBGT.setString(7,company);
			stmtBGT.setString(8,branch);
			stmtBGT.setString(9,userid);
			stmtBGT.setString(11,mode);
			int datas=stmtBGT.executeUpdate();
			if(datas<=0){
				stmtBGT.close();
				conn.close();
				return 0;
			}
			int docno=stmtBGT.getInt("docNo");
			budgetBean.setTxtbudgetdocno(docno);
			if (docno > 0) {
				
				/*Insertion to my_budgetd,my_budgetdet*/
				int insertData=insertion(conn, docno, incomegridcolumn, expendituregridcolumn, incomearray, expenditurearray, session, mode);
				if(insertData<=0){
					stmtBGT.close();
					conn.close();
					return 0;
				}
				/*Insertion to my_budgetd,my_budgetdet Ends*/
				
				conn.commit();
				stmtBGT.close();
				conn.close();
				return docno;
				 
			}
		stmtBGT.close();
		conn.close();
	 } catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 } finally{
			conn.close();
		}
		return 0;
	}

	public boolean edit(int txtbudgetdocno, Date budgetsDate, String formdetailcode, Date assessmentDate, String txtdescription, double txttotalincome, double txttotalexpenditure, String incomegridcolumn,
				String expendituregridcolumn, ArrayList<String> incomearray, ArrayList<String> expenditurearray, HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
				conn=connDAO.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtBGT1 = conn.createStatement();
				
			    String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				int docno=txtbudgetdocno;
				
				CallableStatement stmtBGT = conn.prepareCall("{CALL budgetmDML(?,?,?,?,?,?,?,?,?,?,?)}");
				stmtBGT.setInt(10,docno);
				stmtBGT.setDate(1,budgetsDate);
				stmtBGT.setDate(2,assessmentDate);
				stmtBGT.setString(3,txtdescription);
				stmtBGT.setDouble(4,txttotalincome);
				stmtBGT.setDouble(5,txttotalexpenditure);
				stmtBGT.setString(6,formdetailcode);
				stmtBGT.setString(7,company);
				stmtBGT.setString(8,branch);
				stmtBGT.setString(9,userid);
				stmtBGT.setString(11,mode);
				int datas=stmtBGT.executeUpdate();
				if(datas<=0){
					stmtBGT.close();
					conn.close();
					return false;
				}
			    
			    String sql=("DELETE FROM my_budgetd WHERE rdocno="+docno+"");
			    int data = stmtBGT1.executeUpdate(sql);
			    
			    String sql1=("DELETE FROM my_budgetdet WHERE rdocno="+docno+"");
			    int data1 = stmtBGT1.executeUpdate(sql1);
			    
			    budgetBean.setTxtbudgetdocno(docno);
				if (docno > 0) {
				
					/*Insertion to my_budgetd,my_budgetdet*/
					int insertData=insertion(conn, docno, incomegridcolumn, expendituregridcolumn, incomearray, expenditurearray, session, mode);
					if(insertData<=0){
						stmtBGT.close();
						conn.close();
						return false;
					}
					/*Insertion to my_budgetd,my_budgetdet Ends*/
					
					conn.commit();
					stmtBGT.close();
					conn.close();
					return true;
				}
			stmtBGT.close();
			conn.close();
		 } catch(Exception e){	
			 	e.printStackTrace();
			    conn.close();
			 	return false;
		 } finally{
				conn.close();
			}
		return false;
	}

	
	public boolean delete(int txtbudgetdocno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtBGT = conn.createStatement();
			
			int docno = txtbudgetdocno;
		    String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			/*Updating my_budgetm*/
            String sql=("update my_budgetm set status=7 where brhid='"+branch+"' and doc_no='"+docno+"'");
            int data = stmtBGT.executeUpdate(sql);
			/*Updating my_budgetm Ends*/

			/*Inserting into datalog*/
			String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
			int datas = stmtBGT.executeUpdate(sqls);
			/*Inserting into datalog Ends*/
			
			conn.commit();
			stmtBGT.close();
			conn.close();
			return true;
      } catch(Exception e){
	 	  e.printStackTrace();	
	 	  conn.close();
	 	  return false;
      } finally{
			conn.close();
		}
	}
	public  JSONArray convertRowArrayToJSON11(ArrayList<ArrayList<String>> rowsList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> rowArray=rowsList.get(i);
			
			obj.put("accountname",rowArray.get(0));

			for (int k=1; k < 13; k++) {
					obj.put("monthamt"+k,"");
			}
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
	 }
	 
	  public  JSONArray convertColumnArrayToJSON11(ArrayList<String> columnsList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsList.size(); i++) {
			
			JSONObject obj = new JSONObject();    
			
			String[] columnArray=columnsList.get(i).split("::");
			
			obj.put("text",columnArray[0]);
			obj.put("datafield",columnArray[1]);
			obj.put("cellsAlign",columnArray[2]);
			obj.put("align",columnArray[3]);
			if(!(columnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",columnArray[4]);
		    }
			if(!(columnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",columnArray[5]);
		    }
			if(!(columnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",columnArray[6]);
			}
			if(!(columnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",columnArray[7]);
			}
			if(!(columnArray[8].trim().equalsIgnoreCase(""))){
			    obj.put("aggregates",columnArray[8]);
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	public JSONArray incomeGridLoading11(String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = connDAO.getMyConnection();
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){   
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     
			     columnarray.add("::accountname::left::left:: ::28%:: ::headClass:: ");  
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
		     
			     String sql1 = "select names from gl_rowval";
		         ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();
					temp.add(resultSet1.getString("names"));     
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON11(columnarray);
				 ROWDATA=convertRowArrayToJSON11(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
			 
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
     }        
	
	public JSONArray incomeGridReloading11(HttpSession session,String docNo,String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
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
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("2") || check.equalsIgnoreCase("3")){
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     columnarray.add("::accountname::left::left:: ::28%:: ::headClass:: ");
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
			     String sql1 = "select r.names,CONVERT(if(d.monthamt1=0,'',d.monthamt1),CHAR(100)) monthamt1,"
			    + " CONVERT(if(d.monthamt2=0,'',d.monthamt2),CHAR(100)) monthamt2,CONVERT(if(d.monthamt3=0,'',d.monthamt3),CHAR(100)) monthamt3,"
			    + " CONVERT(if(d.monthamt4=0,'',d.monthamt4),CHAR(100)) monthamt4,CONVERT(if(d.monthamt5=0,'',d.monthamt5),CHAR(100)) monthamt5,"
			    + " CONVERT(if(d.monthamt6=0,'',d.monthamt6),CHAR(100)) monthamt6,CONVERT(if(d.monthamt7=0,'',d.monthamt7),CHAR(100)) monthamt7,"
			    + " CONVERT(if(d.monthamt8=0,'',d.monthamt8),CHAR(100)) monthamt8,CONVERT(if(d.monthamt9=0,'',d.monthamt9),CHAR(100)) monthamt9,"
			    + " CONVERT(if(d.monthamt10=0,'',d.monthamt10),CHAR(100)) monthamt10,CONVERT(if(d.monthamt11=0,'',d.monthamt11),CHAR(100)) monthamt11,"
			    + " CONVERT(if(d.monthamt12=0,'',d.monthamt12),CHAR(100)) monthamt12"
			    + " from my_budgetm m left join (select grtype,brhid,rdocno,acno,sum(monthamt1) monthamt1,sum(monthamt2) monthamt2,sum(monthamt3) monthamt3,sum(monthamt4) monthamt4,sum(monthamt5) monthamt5,"
			    + " sum(monthamt6) monthamt6,sum(monthamt7) monthamt7,sum(monthamt8) monthamt8,sum(monthamt9) monthamt9,sum(monthamt10) monthamt10,sum(monthamt11) monthamt11,sum(monthamt12) monthamt12"
			    + " from my_budgetdet where grtype=5 group by rdocno) d on m.doc_no=d.rdocno and m.brhid=d.brhid left join gl_rowval r on r.grtype=d.grtype where m.status=3  and d.brhid=1 and d.rdocno="+docNo+""
			    + " union all select r.names,CONVERT(if(d.monthamt1=0,'',d.monthamt1),CHAR(100)) monthamt1,"
				+ " CONVERT(if(d.monthamt2=0,'',d.monthamt2),CHAR(100)) monthamt2,CONVERT(if(d.monthamt3=0,'',d.monthamt3),CHAR(100)) monthamt3,"
			    + " CONVERT(if(d.monthamt4=0,'',d.monthamt4),CHAR(100)) monthamt4,CONVERT(if(d.monthamt5=0,'',d.monthamt5),CHAR(100)) monthamt5,"
			    + " CONVERT(if(d.monthamt6=0,'',d.monthamt6),CHAR(100)) monthamt6,CONVERT(if(d.monthamt7=0,'',d.monthamt7),CHAR(100)) monthamt7,"
				+ " CONVERT(if(d.monthamt8=0,'',d.monthamt8),CHAR(100)) monthamt8,CONVERT(if(d.monthamt9=0,'',d.monthamt9),CHAR(100)) monthamt9,"
				+ " CONVERT(if(d.monthamt10=0,'',d.monthamt10),CHAR(100)) monthamt10,CONVERT(if(d.monthamt11=0,'',d.monthamt11),CHAR(100)) monthamt11,"
				+ " CONVERT(if(d.monthamt12=0,'',d.monthamt12),CHAR(100)) monthamt12"
				+ " from my_budgetm m left join (select grtype,brhid,rdocno,acno,sum(monthamt1) monthamt1,sum(monthamt2) monthamt2,sum(monthamt3) monthamt3,sum(monthamt4) monthamt4,sum(monthamt5) monthamt5,"
				+ " sum(monthamt6) monthamt6,sum(monthamt7) monthamt7,sum(monthamt8) monthamt8,sum(monthamt9) monthamt9,sum(monthamt10) monthamt10,sum(monthamt11) monthamt11,sum(monthamt12) monthamt12"
				+ " from my_budgetdet where grtype=4 group by rdocno) d on m.doc_no=d.rdocno and m.brhid=d.brhid left join gl_rowval r on r.grtype=d.grtype where m.status=3  and d.brhid=1 and d.rdocno="+docNo+""
			    + " union all select 'Total' accountname,CONVERT(if((d.monthamt1-dd.monthamt1)=0,'',d.monthamt1-dd.monthamt1),CHAR(100)) monthamt1,"
			    + " CONVERT(if((d.monthamt2-dd.monthamt2)=0,'',d.monthamt2-dd.monthamt2),CHAR(100)) monthamt2,CONVERT(if((d.monthamt3-dd.monthamt3)=0,'',d.monthamt3-dd.monthamt3),CHAR(100)) monthamt3,"
			    + " CONVERT(if((d.monthamt4-dd.monthamt4)=0,'',d.monthamt4-dd.monthamt4),CHAR(100)) monthamt4,CONVERT(if((d.monthamt5-dd.monthamt5)=0,'',d.monthamt5-dd.monthamt5),CHAR(100)) monthamt5,"
			    + " CONVERT(if((d.monthamt6-dd.monthamt6)=0,'',d.monthamt6-dd.monthamt6),CHAR(100)) monthamt6,CONVERT(if((d.monthamt7-dd.monthamt7)=0,'',d.monthamt7-dd.monthamt7),CHAR(100)) monthamt7,"
			    + " CONVERT(if((d.monthamt8-dd.monthamt8)=0,'',d.monthamt8-dd.monthamt8),CHAR(100)) monthamt8,CONVERT(if((d.monthamt9-dd.monthamt9)=0,'',d.monthamt9-dd.monthamt9),CHAR(100)) monthamt9,"
			    + " CONVERT(if((d.monthamt10-dd.monthamt10)=0,'',d.monthamt10-dd.monthamt10),CHAR(100)) monthamt10,CONVERT(if((d.monthamt11-dd.monthamt11)=0,'',d.monthamt11-dd.monthamt11),CHAR(100)) monthamt11,"
			    + " CONVERT(if((d.monthamt12-dd.monthamt12)=0,'',d.monthamt12-dd.monthamt12),CHAR(100)) monthamt12"
			    + " from my_budgetm m left join (select grtype,brhid,rdocno,acno,sum(monthamt1) monthamt1,sum(monthamt2) monthamt2,sum(monthamt3) monthamt3,sum(monthamt4) monthamt4,sum(monthamt5) monthamt5,"
			    + " sum(monthamt6) monthamt6,sum(monthamt7) monthamt7,sum(monthamt8) monthamt8,sum(monthamt9) monthamt9,sum(monthamt10) monthamt10,sum(monthamt11) monthamt11,sum(monthamt12) monthamt12"
			    + " from my_budgetdet where grtype=5 group by rdocno) d on m.doc_no=d.rdocno and m.brhid=d.brhid"
			    + "  left join (select grtype,brhid,rdocno,acno,sum(monthamt1) monthamt1,sum(monthamt2) monthamt2,sum(monthamt3) monthamt3,sum(monthamt4) monthamt4,sum(monthamt5) monthamt5,"
			    + " sum(monthamt6) monthamt6,sum(monthamt7) monthamt7,sum(monthamt8) monthamt8,sum(monthamt9) monthamt9,sum(monthamt10) monthamt10,sum(monthamt11) monthamt11,sum(monthamt12) monthamt12"
			    + " from my_budgetdet where grtype=4 group by rdocno) dd on m.doc_no=dd.rdocno and m.brhid=dd.brhid where m.status=3 and d.brhid=1 and d.rdocno="+docNo+"";  
   
			        
		         //System.out.println("sq1l================="+sql1);
			     ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet1.getString("names"));
					temp.add(resultSet1.getString("monthamt1"));
					temp.add(resultSet1.getString("monthamt2"));
					temp.add(resultSet1.getString("monthamt3"));
					temp.add(resultSet1.getString("monthamt4"));
					temp.add(resultSet1.getString("monthamt5"));
					temp.add(resultSet1.getString("monthamt6"));
					temp.add(resultSet1.getString("monthamt7"));
					temp.add(resultSet1.getString("monthamt8"));
					temp.add(resultSet1.getString("monthamt9"));
					temp.add(resultSet1.getString("monthamt10"));
					temp.add(resultSet1.getString("monthamt11"));
					temp.add(resultSet1.getString("monthamt12"));
					
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON11(columnarray);
				 ROWDATA=convertRowDetailsArrayToJSON11(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
  }
	public JSONArray incomeGridLoading(String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = connDAO.getMyConnection();
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     
			     columnarray.add("Doc No::acno::center::center::true:: :: :: :: ");
			     columnarray.add("Account::account::left::left:: ::6%:: ::headClass:: ");
			     columnarray.add("Account Name::accountname::left::left:: ::22%:: ::headClass:: ");
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
		     
			     columnarray.add("Group Type::grtype::center::center::true:: :: :: :: ");
			     columnarray.add("Net Income::netincome::center::center::true::10%:: :: ::['sum']");
			     
		         String sql1 = "select doc_no acno,account,description accountname from my_head where gr_type=5 and m_s!=1 order by doc_no";
			     ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet1.getString("acno"));
					temp.add(resultSet1.getString("account"));
					temp.add(resultSet1.getString("accountname"));
					temp.add("5");
					temp.add("0.00");
					
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON(columnarray);
				 ROWDATA=convertRowArrayToJSON(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
			 
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
      }
	
	public JSONArray expenditureGridLoading(String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = connDAO.getMyConnection();
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     
			     columnarray.add("Doc No::acno::center::center::true:: :: :: :: ");
			     columnarray.add("Account::account::left::left:: ::6%:: ::headExpClass:: ");
			     columnarray.add("Account Name::accountname::left::left:: ::22%:: ::headExpClass:: ");
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
		     
			     columnarray.add("Group Type::grtype::center::center::true:: :: :: :: ");
			     columnarray.add("Net Expenditure::netincome::center::center::true::10%:: :: ::['sum']");
			     
		         String sql1 = "select doc_no acno,account,description accountname from my_head where gr_type=4 and m_s!=1 order by doc_no";
			     ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet1.getString("acno"));
					temp.add(resultSet1.getString("account"));
					temp.add(resultSet1.getString("accountname"));
					temp.add("4");
					temp.add("0.00");
					
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON(columnarray);
				 ROWDATA=convertRowArrayToJSON(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
			 
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
     }
	
		public JSONArray incomeGridReloading(HttpSession session,String docNo,String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
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
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("2")){
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     
			     columnarray.add("Doc No::acno::center::center::true:: :: :: :: ");
			     columnarray.add("Account::account::left::left:: ::6%:: ::headClass:: ");
			     columnarray.add("Account Name::accountname::left::left:: ::22%:: ::headClass:: ");
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
		     
			     columnarray.add("Group Type::grtype::center::center::true:: :: :: :: ");
			     columnarray.add("Net Expenditure::netincome::center::center::true::10%:: :: ::['sum']");
			     
		         String sql1 = "select d.acno,CONVERT(if(d.monthamt1=0,'',d.monthamt1),CHAR(100)) monthamt1,CONVERT(if(d.monthamt2=0,'',d.monthamt2),CHAR(100)) monthamt2,CONVERT(if(d.monthamt3=0,'',d.monthamt3),CHAR(100)) monthamt3,CONVERT(if(d.monthamt4=0,'',d.monthamt4),CHAR(100)) monthamt4,"  
		         		     + "CONVERT(if(d.monthamt5=0,'',d.monthamt5),CHAR(100)) monthamt5,CONVERT(if(d.monthamt6=0,'',d.monthamt6),CHAR(100)) monthamt6,CONVERT(if(d.monthamt7=0,'',d.monthamt7),CHAR(100)) monthamt7,CONVERT(if(d.monthamt8=0,'',d.monthamt8),CHAR(100)) monthamt8,"  
		         		     + "CONVERT(if(d.monthamt9=0,'',d.monthamt9),CHAR(100)) monthamt9,CONVERT(if(d.monthamt10=0,'',d.monthamt10),CHAR(100)) monthamt10,CONVERT(if(d.monthamt11=0,'',d.monthamt11),CHAR(100)) monthamt11,CONVERT(if(d.monthamt12=0,'',d.monthamt12),CHAR(100)) monthamt12,"  
		         		     + "d.grtype,d.netincome,h.account,h.description accountname from my_budgetm m left join my_budgetdet d on m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=5 and d.brhid="+branch+" and d.rdocno="+docNo+"";
		         //System.out.println("sqlincome========="+sql1);
			     ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet1.getString("acno"));
					temp.add(resultSet1.getString("account"));
					temp.add(resultSet1.getString("accountname"));
					temp.add(resultSet1.getString("grtype"));
					temp.add(resultSet1.getString("netincome"));
					temp.add(resultSet1.getString("monthamt1"));
					temp.add(resultSet1.getString("monthamt2"));
					temp.add(resultSet1.getString("monthamt3"));
					temp.add(resultSet1.getString("monthamt4"));
					temp.add(resultSet1.getString("monthamt5"));
					temp.add(resultSet1.getString("monthamt6"));
					temp.add(resultSet1.getString("monthamt7"));
					temp.add(resultSet1.getString("monthamt8"));
					temp.add(resultSet1.getString("monthamt9"));
					temp.add(resultSet1.getString("monthamt10"));
					temp.add(resultSet1.getString("monthamt11"));
					temp.add(resultSet1.getString("monthamt12"));
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON(columnarray);
				 ROWDATA=convertRowDetailsArrayToJSON(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
   }
	public JSONArray incomeGridEditReloading(HttpSession session,String docNo,String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
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
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("3")){
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     
			     columnarray.add("Doc No::acno::center::center::true:: :: :: :: ");
			     columnarray.add("Account::account::left::left:: ::6%:: ::headClass:: ");
			     columnarray.add("Account Name::accountname::left::left:: ::22%:: ::headClass:: ");
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
		     
			     columnarray.add("Group Type::grtype::center::center::true:: :: :: :: ");
			     columnarray.add("Net Expenditure::netincome::center::center::true::10%:: :: ::['sum']");
			     
		         String sql1 = "select a.acno,CONVERT(if(a.monthamt1=0,'',a.monthamt1),CHAR(100)) monthamt1,CONVERT(if(a.monthamt2=0,'',a.monthamt2),CHAR(100)) monthamt2,CONVERT(if(a.monthamt3=0,'',a.monthamt3),CHAR(100)) monthamt3,CONVERT(if(a.monthamt4=0,'',a.monthamt4),CHAR(100)) monthamt4,"
		        		 + "CONVERT(if(a.monthamt5=0,'',a.monthamt5),CHAR(100)) monthamt5,CONVERT(if(a.monthamt6=0,'',a.monthamt6),CHAR(100)) monthamt6,CONVERT(if(a.monthamt7=0,'',a.monthamt7),CHAR(100)) monthamt7,CONVERT(if(a.monthamt8=0,'',a.monthamt8),CHAR(100)) monthamt8,"
		        		 + "CONVERT(if(a.monthamt9=0,'',a.monthamt9),CHAR(100)) monthamt9,CONVERT(if(a.monthamt10=0,'',a.monthamt10),CHAR(100)) monthamt10,CONVERT(if(a.monthamt11=0,'',a.monthamt11),CHAR(100)) monthamt11,CONVERT(if(a.monthamt12=0,'',a.monthamt12),CHAR(100)) monthamt12,a.grtype,"
		        		 + "a.netincome,a.account,a.accountname from ( "  
		         		 + "select d.acno,d.monthamt1,d.monthamt2,d.monthamt3,d.monthamt4,d.monthamt5,d.monthamt6,d.monthamt7,d.monthamt8,d.monthamt9,d.monthamt10,d.monthamt11,d.monthamt12,d.grtype,d.netincome,h.account,h.description accountname from my_budgetm m left join my_budgetdet d on "
		        		 + "m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=5 and d.brhid='"+branch+"' and d.rdocno="+docNo+" UNION ALL (select h1.doc_no acno, 0 monthamt1, 0 monthamt2, 0 monthamt3, 0 monthamt4, 0 monthamt5, 0 monthamt6, "
		        		 + "0 monthamt7, 0 monthamt8, 0 monthamt9, 0 monthamt10, 0 monthamt11, 0 monthamt12, h1.gr_type grtype, 0 netincome, h1.account, h1.description accountname from my_head h1 where h1.gr_type=5 and h1.m_s!=1 order by h1.doc_no)) a group by a.acno";
		        // System.out.println("sqlreloadincome========="+sql1);
			     ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet1.getString("acno"));
					temp.add(resultSet1.getString("account"));
					temp.add(resultSet1.getString("accountname"));
					temp.add(resultSet1.getString("grtype"));
					temp.add(resultSet1.getString("netincome"));
					temp.add(resultSet1.getString("monthamt1"));
					temp.add(resultSet1.getString("monthamt2"));
					temp.add(resultSet1.getString("monthamt3"));
					temp.add(resultSet1.getString("monthamt4"));
					temp.add(resultSet1.getString("monthamt5"));
					temp.add(resultSet1.getString("monthamt6"));
					temp.add(resultSet1.getString("monthamt7"));
					temp.add(resultSet1.getString("monthamt8"));
					temp.add(resultSet1.getString("monthamt9"));
					temp.add(resultSet1.getString("monthamt10"));
					temp.add(resultSet1.getString("monthamt11"));
					temp.add(resultSet1.getString("monthamt12"));
					
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON(columnarray);
				 ROWDATA=convertRowDetailsArrayToJSON(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
   }
	
	public JSONArray expenditureGridReloading(HttpSession session,String docNo,String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
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
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("2")){
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     
			     columnarray.add("Doc No::acno::center::center::true:: :: :: :: ");
			     columnarray.add("Account::account::left::left:: ::6%:: ::headExpClass:: ");
			     columnarray.add("Account Name::accountname::left::left:: ::22%:: ::headExpClass:: ");
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
		     
			     columnarray.add("Group Type::grtype::center::center::true:: :: :: :: ");
			     columnarray.add("Net Expenditure::netincome::center::center::true::10%:: :: ::['sum']");
			     
		         String sql1 = "select d.acno,CONVERT(if(d.monthamt1=0,'',d.monthamt1),CHAR(100)) monthamt1,CONVERT(if(d.monthamt2=0,'',d.monthamt2),CHAR(100)) monthamt2,CONVERT(if(d.monthamt3=0,'',d.monthamt3),CHAR(100)) monthamt3,CONVERT(if(d.monthamt4=0,'',d.monthamt4),CHAR(100)) monthamt4,"  
		         		     + "CONVERT(if(d.monthamt5=0,'',d.monthamt5),CHAR(100)) monthamt5,CONVERT(if(d.monthamt6=0,'',d.monthamt6),CHAR(100)) monthamt6,CONVERT(if(d.monthamt7=0,'',d.monthamt7),CHAR(100)) monthamt7,CONVERT(if(d.monthamt8=0,'',d.monthamt8),CHAR(100)) monthamt8,"  
		         		     + "CONVERT(if(d.monthamt9=0,'',d.monthamt9),CHAR(100)) monthamt9,CONVERT(if(d.monthamt10=0,'',d.monthamt10),CHAR(100)) monthamt10,CONVERT(if(d.monthamt11=0,'',d.monthamt11),CHAR(100)) monthamt11,CONVERT(if(d.monthamt12=0,'',d.monthamt12),CHAR(100)) monthamt12,"  
		         		     + "d.grtype,d.netincome,h.account,h.description accountname from my_budgetm m left join my_budgetdet d on m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=4 and d.brhid="+branch+" and d.rdocno="+docNo+"";
		         
			     ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet1.getString("acno"));
					temp.add(resultSet1.getString("account"));
					temp.add(resultSet1.getString("accountname"));
					temp.add(resultSet1.getString("grtype"));
					temp.add(resultSet1.getString("netincome"));
					temp.add(resultSet1.getString("monthamt1"));
					temp.add(resultSet1.getString("monthamt2"));
					temp.add(resultSet1.getString("monthamt3"));
					temp.add(resultSet1.getString("monthamt4"));
					temp.add(resultSet1.getString("monthamt5"));
					temp.add(resultSet1.getString("monthamt6"));
					temp.add(resultSet1.getString("monthamt7"));
					temp.add(resultSet1.getString("monthamt8"));
					temp.add(resultSet1.getString("monthamt9"));
					temp.add(resultSet1.getString("monthamt10"));
					temp.add(resultSet1.getString("monthamt11"));
					temp.add(resultSet1.getString("monthamt12"));
					
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON(columnarray);
				 ROWDATA=convertRowDetailsArrayToJSON(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
   }
	
	public JSONArray expenditureGridEditReloading(HttpSession session,String docNo,String assessmentyear,String check) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		
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
			 Statement stmtBGT = conn.createStatement();
			
			 if(check.equalsIgnoreCase("3")){
				 
				 java.sql.Date sqlAssessmentDate = null;
			     
			     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
			    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
		         }
			     
			     ArrayList<String> columnarray= new ArrayList<String>();
			     
			     columnarray.add("Doc No::acno::center::center::true:: :: :: :: ");
			     columnarray.add("Account::account::left::left:: ::6%:: ::headExpClass:: ");
			     columnarray.add("Account Name::accountname::left::left:: ::22%:: ::headExpClass:: ");
			     		     
			     String sql = "Select 1 monthday,DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') months UNION ALL Select 2 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 3 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') months UNION ALL Select 4 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 5 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') months UNION ALL Select 6 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 7 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') months UNION ALL Select 8 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 9 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') months UNION ALL Select 10 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') months UNION ALL "  
			     		    + "Select 11 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') months UNION ALL Select 12 monthday,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') months";
			     
			     ResultSet resultSet = stmtBGT.executeQuery(sql);
			     
			     while(resultSet.next()){
			    	 columnarray.add(resultSet.getString("months")+"::monthamt"+resultSet.getInt("monthday")+"::right::right:: ::6%::d2:: :: ");
			     }
		     
			     columnarray.add("Group Type::grtype::center::center::true:: :: :: :: ");
			     columnarray.add("Net Expenditure::netincome::center::center::true::10%:: :: ::['sum']");
			     
		         String sql1 = "select a.acno,CONVERT(if(a.monthamt1=0,'',a.monthamt1),CHAR(100)) monthamt1,CONVERT(if(a.monthamt2=0,'',a.monthamt2),CHAR(100)) monthamt2,CONVERT(if(a.monthamt3=0,'',a.monthamt3),CHAR(100)) monthamt3,CONVERT(if(a.monthamt4=0,'',a.monthamt4),CHAR(100)) monthamt4,"
		        		 + "CONVERT(if(a.monthamt5=0,'',a.monthamt5),CHAR(100)) monthamt5,CONVERT(if(a.monthamt6=0,'',a.monthamt6),CHAR(100)) monthamt6,CONVERT(if(a.monthamt7=0,'',a.monthamt7),CHAR(100)) monthamt7,CONVERT(if(a.monthamt8=0,'',a.monthamt8),CHAR(100)) monthamt8,"
		        		 + "CONVERT(if(a.monthamt9=0,'',a.monthamt9),CHAR(100)) monthamt9,CONVERT(if(a.monthamt10=0,'',a.monthamt10),CHAR(100)) monthamt10,CONVERT(if(a.monthamt11=0,'',a.monthamt11),CHAR(100)) monthamt11,CONVERT(if(a.monthamt12=0,'',a.monthamt12),CHAR(100)) monthamt12,a.grtype,"
		        		 + "a.netincome,a.account,a.accountname from ( "  
		         		 + "select d.acno,d.monthamt1,d.monthamt2,d.monthamt3,d.monthamt4,d.monthamt5,d.monthamt6,d.monthamt7,d.monthamt8,d.monthamt9,d.monthamt10,d.monthamt11,d.monthamt12,d.grtype,d.netincome,h.account,h.description accountname from my_budgetm m left join my_budgetdet d on "
		        		 + "m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=4 and d.brhid='"+branch+"' and d.rdocno="+docNo+" UNION ALL (select h1.doc_no acno, 0 monthamt1, 0 monthamt2, 0 monthamt3, 0 monthamt4, 0 monthamt5, 0 monthamt6, "
		        		 + "0 monthamt7, 0 monthamt8, 0 monthamt9, 0 monthamt10, 0 monthamt11, 0 monthamt12, h1.gr_type grtype, 0 netincome, h1.account, h1.description accountname from my_head h1 where h1.gr_type=4 and h1.m_s!=1 order by h1.doc_no)) a group by a.acno";
		         
			     ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
			 
			     ArrayList<ArrayList<String>> rowarray= new ArrayList<ArrayList<String>>();
				 while(resultSet1.next()){
					ArrayList<String> temp=new ArrayList<String>();

					temp.add(resultSet1.getString("acno"));
					temp.add(resultSet1.getString("account"));
					temp.add(resultSet1.getString("accountname"));
					temp.add(resultSet1.getString("grtype"));
					temp.add(resultSet1.getString("netincome"));
					temp.add(resultSet1.getString("monthamt1"));
					temp.add(resultSet1.getString("monthamt2"));
					temp.add(resultSet1.getString("monthamt3"));
					temp.add(resultSet1.getString("monthamt4"));
					temp.add(resultSet1.getString("monthamt5"));
					temp.add(resultSet1.getString("monthamt6"));
					temp.add(resultSet1.getString("monthamt7"));
					temp.add(resultSet1.getString("monthamt8"));
					temp.add(resultSet1.getString("monthamt9"));
					temp.add(resultSet1.getString("monthamt10"));
					temp.add(resultSet1.getString("monthamt11"));
					temp.add(resultSet1.getString("monthamt12"));
					
					rowarray.add(temp);
				 }
				
				 COLUMNDATA=convertColumnArrayToJSON(columnarray);
				 ROWDATA=convertRowDetailsArrayToJSON(rowarray);
			 
				 JSONArray detailsarray=new JSONArray();
			 
				 detailsarray.addAll(COLUMNDATA);
				 detailsarray.addAll(ROWDATA);
				 RESULTDATA=detailsarray;
			 
			 }
			 
			 stmtBGT.close();
			 conn.close();

			} catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA;
  }
	
	public ClsBudgetBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		
	    ClsBudgetBean budgetsBean = new ClsBudgetBean();
		
		Connection conn = null;
		
		try {
		
			conn = connDAO.getMyConnection();
			Statement stmtBGT = conn.createStatement();
	
			String branch = session.getAttribute("BRANCHID").toString();
			
			ResultSet resultSet = stmtBGT.executeQuery ("select doc_no,date,year,description,tot_income,tot_expenditure from my_budgetm where status<>7 and brhid="+branch+" and doc_no="+docNo+"");
	
			while (resultSet.next()) {
				budgetsBean.setTxtbudgetdocno(docNo);
				budgetsBean.setBudgetDate(resultSet.getDate("date").toString());
				budgetsBean.setAssessmentYearDate(resultSet.getDate("year").toString());
				budgetsBean.setTxtdescription(resultSet.getString("description"));

				budgetsBean.setTxttotalincome(resultSet.getDouble("tot_income"));
				budgetsBean.setTxttotalexpenditure(resultSet.getDouble("tot_expenditure"));
				budgetsBean.setMaindate(resultSet.getDate("date").toString());
			    }
			stmtBGT.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		   return budgetsBean;
		}

		public ClsBudgetBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
			 ClsBudgetBean bean = new ClsBudgetBean();
			 Connection conn = null;
			 
				try {
					conn = connDAO.getMyConnection();
					Statement stmtBGT = conn.createStatement();
					
					String headersql="select if(m.dtype='BGT','Budget','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
							+ "b.cstno from my_budgetm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
							+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='BGT' "
							+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSetHead = stmtBGT.executeQuery(headersql);
					
					while(resultSetHead.next()){
						
						bean.setLblcompname(resultSetHead.getString("company"));
						bean.setLblcompaddress(resultSetHead.getString("address"));
						bean.setLblprintname(resultSetHead.getString("vouchername"));
						bean.setLblcomptel(resultSetHead.getString("tel"));
						bean.setLblcompfax(resultSetHead.getString("fax"));
						bean.setLblbranch(resultSetHead.getString("branchname"));
						bean.setLbllocation(resultSetHead.getString("location"));
						bean.setLblcstno(resultSetHead.getString("cstno"));
						bean.setLblpan(resultSetHead.getString("pbno"));
						bean.setLblservicetax(resultSetHead.getString("stcno"));
						bean.setLblpobox(resultSetHead.getString("pbno"));
					}
					
					String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.year,CONCAT(DATE_FORMAT(m.year ,'%M %Y'),' To ',DATE_FORMAT(DATE_ADD(LAST_DAY(m.year),INTERVAL 11 MONTH),'%M %Y')) assessmentyear,m.description,round(m.tot_income,2) totalincome,"
						 + "round(m.tot_expenditure,2) totalexpenditure,u.user_name from my_budgetm m left join my_user u on m.userid=u.doc_no where m.dtype='BGT' and m.brhid="+branch+" and m.doc_no="+docNo+"";
						
					ResultSet resultSets = stmtBGT.executeQuery(sqls);
					
					java.sql.Date sqlAssessmentDate=null;
					
					while(resultSets.next()){
						
						sqlAssessmentDate=resultSets.getDate("year");
						bean.setLblassessmentyear(resultSets.getString("assessmentyear"));
						bean.setLblvoucherno(resultSets.getString("doc_no"));
						bean.setLbldescription(resultSets.getString("description"));
						bean.setLbldate(resultSets.getString("date"));
						bean.setLbltotincome(resultSets.getString("totalincome"));
						bean.setLbltotexpenditure(resultSets.getString("totalexpenditure"));
						bean.setLblincometotal(resultSets.getString("totalincome"));
						bean.setLblexpendituretotal(resultSets.getString("totalexpenditure"));
						bean.setLblpreparedby(resultSets.getString("user_name"));
					}
					
					bean.setTxtheader(header);
					
					String sql="select DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %y') month1,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %y') month2,"
							+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %y') month3,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %y') month4,"
							+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %y') month5,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %y') month6,"
							+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %y') month7,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %y') month8,"
							+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %y') month9,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %y') month10,"
							+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %y') month11,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %y') month12";
					
					ResultSet resultSet = stmtBGT.executeQuery(sql);
					
					while(resultSet.next()){
						
						bean.setLblincomemonth1(resultSet.getString("month1"));bean.setLblexpendituremonth1(resultSet.getString("month1"));
						bean.setLblincomemonth2(resultSet.getString("month2"));bean.setLblexpendituremonth2(resultSet.getString("month2"));
						bean.setLblincomemonth3(resultSet.getString("month3"));bean.setLblexpendituremonth3(resultSet.getString("month3"));
						bean.setLblincomemonth4(resultSet.getString("month4"));bean.setLblexpendituremonth4(resultSet.getString("month4"));
						bean.setLblincomemonth5(resultSet.getString("month5"));bean.setLblexpendituremonth5(resultSet.getString("month5"));
						bean.setLblincomemonth6(resultSet.getString("month6"));bean.setLblexpendituremonth6(resultSet.getString("month6"));
						bean.setLblincomemonth7(resultSet.getString("month7"));bean.setLblexpendituremonth7(resultSet.getString("month7"));
						bean.setLblincomemonth8(resultSet.getString("month8"));bean.setLblexpendituremonth8(resultSet.getString("month8"));
						bean.setLblincomemonth9(resultSet.getString("month9"));bean.setLblexpendituremonth9(resultSet.getString("month9"));
						bean.setLblincomemonth10(resultSet.getString("month10"));bean.setLblexpendituremonth10(resultSet.getString("month10"));
						bean.setLblincomemonth11(resultSet.getString("month11"));bean.setLblexpendituremonth11(resultSet.getString("month11"));
						bean.setLblincomemonth12(resultSet.getString("month11"));bean.setLblexpendituremonth12(resultSet.getString("month12"));
						
					}
					
					String sql1 = "select CONVERT(if(d.monthamt1=0,'  ',round(d.monthamt1,2)),CHAR(100)) monthamt1,CONVERT(if(d.monthamt2=0,'  ',round(d.monthamt2,2)),CHAR(100)) monthamt2,CONVERT(if(d.monthamt3=0,'  ',round(d.monthamt3,2)),CHAR(100)) monthamt3,CONVERT(if(d.monthamt4=0,'  ',round(d.monthamt4,2)),CHAR(100)) monthamt4,"  
		         		     + "CONVERT(if(d.monthamt5=0,'  ',round(d.monthamt5,2)),CHAR(100)) monthamt5,CONVERT(if(d.monthamt6=0,'  ',round(d.monthamt6,2)),CHAR(100)) monthamt6,CONVERT(if(d.monthamt7=0,'  ',round(d.monthamt7,2)),CHAR(100)) monthamt7,CONVERT(if(d.monthamt8=0,'  ',round(d.monthamt8,2)),CHAR(100)) monthamt8,"  
		         		     + "CONVERT(if(d.monthamt9=0,'  ',round(d.monthamt9,2)),CHAR(100)) monthamt9,CONVERT(if(d.monthamt10=0,'  ',round(d.monthamt10,2)),CHAR(100)) monthamt10,CONVERT(if(d.monthamt11=0,'  ',round(d.monthamt11,2)),CHAR(100)) monthamt11,CONVERT(if(d.monthamt12=0,'  ',round(d.monthamt12,2)),CHAR(100)) monthamt12,"  
		         		     + "h.account,h.description accountname from my_budgetm m left join my_budgetdet d on m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=5 and d.brhid="+branch+" and d.rdocno="+docNo+"";
						
					ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
					
					ArrayList<String> printincomearray= new ArrayList<String>();
					
					while(resultSet1.next()){
						bean.setFirstarray(1);
						String temp="";
						temp=resultSet1.getString("account")+"::"+resultSet1.getString("accountname")+"::"+resultSet1.getString("monthamt1")+"::"+resultSet1.getString("monthamt2")+"::"+resultSet1.getString("monthamt3")+"::"+resultSet1.getString("monthamt4")+"::"+resultSet1.getString("monthamt5")+"::"+resultSet1.getString("monthamt6")+"::"+resultSet1.getString("monthamt7")+"::"+resultSet1.getString("monthamt8")+"::"+resultSet1.getString("monthamt9")+"::"+resultSet1.getString("monthamt10")+"::"+resultSet1.getString("monthamt11")+"::"+resultSet1.getString("monthamt12");
						printincomearray.add(temp);
					}
					
					request.setAttribute("printincomes", printincomearray);
					
					String sql2 = "select CONVERT(if(d.monthamt1=0,'  ',round(d.monthamt1,2)),CHAR(100)) monthamt1,CONVERT(if(d.monthamt2=0,'  ',round(d.monthamt2,2)),CHAR(100)) monthamt2,CONVERT(if(d.monthamt3=0,'  ',round(d.monthamt3,2)),CHAR(100)) monthamt3,CONVERT(if(d.monthamt4=0,'  ',round(d.monthamt4,2)),CHAR(100)) monthamt4,"  
		         		     + "CONVERT(if(d.monthamt5=0,'  ',round(d.monthamt5,2)),CHAR(100)) monthamt5,CONVERT(if(d.monthamt6=0,'  ',round(d.monthamt6,2)),CHAR(100)) monthamt6,CONVERT(if(d.monthamt7=0,'  ',round(d.monthamt7,2)),CHAR(100)) monthamt7,CONVERT(if(d.monthamt8=0,'  ',round(d.monthamt8,2)),CHAR(100)) monthamt8,"  
		         		     + "CONVERT(if(d.monthamt9=0,'  ',round(d.monthamt9,2)),CHAR(100)) monthamt9,CONVERT(if(d.monthamt10=0,'  ',round(d.monthamt10,2)),CHAR(100)) monthamt10,CONVERT(if(d.monthamt11=0,'  ',round(d.monthamt11,2)),CHAR(100)) monthamt11,CONVERT(if(d.monthamt12=0,'  ',round(d.monthamt12,2)),CHAR(100)) monthamt12,"  
		         		     + "h.account,h.description accountname from my_budgetm m left join my_budgetdet d on m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=4 and d.brhid="+branch+" and d.rdocno="+docNo+"";
					
					ResultSet resultSet2 = stmtBGT.executeQuery(sql2);
					
					ArrayList<String> printexpenditurearray= new ArrayList<String>();
					
					while(resultSet2.next()){
						bean.setSecarray(2); 
						String temp="";
						temp=resultSet2.getString("account")+"::"+resultSet2.getString("accountname")+"::"+resultSet2.getString("monthamt1")+"::"+resultSet2.getString("monthamt2")+"::"+resultSet2.getString("monthamt3")+"::"+resultSet2.getString("monthamt4")+"::"+resultSet2.getString("monthamt5")+"::"+resultSet2.getString("monthamt6")+"::"+resultSet2.getString("monthamt7")+"::"+resultSet2.getString("monthamt8")+"::"+resultSet2.getString("monthamt9")+"::"+resultSet2.getString("monthamt10")+"::"+resultSet2.getString("monthamt11")+"::"+resultSet2.getString("monthamt12");
						printexpenditurearray.add(temp);
					}

					request.setAttribute("printexpenditures", printexpenditurearray);
					
					String sql3 = "select min(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,min(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from my_budgetm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='BGT' and m.brhid="+branch+" and m.doc_no="+docNo+"";
					
					ResultSet resultSet3 = stmtBGT.executeQuery(sql3);
					
					while(resultSet3.next()){
						bean.setLblpreparedon(resultSet3.getString("preparedon"));
						bean.setLblpreparedat(resultSet3.getString("preparedat"));
					}
				
					stmtBGT.close();
					conn.close();
				} catch(Exception e){
					e.printStackTrace();
					conn.close();
				} finally{
					conn.close();
				}
				return bean;
			}
		
		public JSONArray incomeGridExcelExportLoading(HttpSession session,String docNo,String assessmentyear,String check) throws SQLException {
		      JSONArray RESULTDATA=new JSONArray();
		      
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
						Statement stmtBGT = conn.createStatement();
						
						if(check.equalsIgnoreCase("2")){
							
						java.sql.Date sqlAssessmentDate = null;
					     
					     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
					    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
				         }
					     
						String sql="select DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') month1,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') month2,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') month3,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') month4,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') month5,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') month6,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') month7,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') month8,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') month9,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') month10,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') month11,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') month12";
						
						ResultSet resultSet = stmtBGT.executeQuery(sql);
					
						String incomemonth1="",incomemonth2="",incomemonth3="",incomemonth4="",incomemonth5="",incomemonth6="",incomemonth7="",incomemonth8="",incomemonth9="",incomemonth10="",incomemonth11="",incomemonth12="";
						while(resultSet.next()){
							
							incomemonth1=resultSet.getString("month1");incomemonth2=resultSet.getString("month2");incomemonth3=resultSet.getString("month3");incomemonth4=resultSet.getString("month4");incomemonth5=resultSet.getString("month5");incomemonth6=resultSet.getString("month6");
							incomemonth7=resultSet.getString("month7");incomemonth8=resultSet.getString("month8");incomemonth9=resultSet.getString("month9");incomemonth10=resultSet.getString("month10");incomemonth11=resultSet.getString("month11");incomemonth12=resultSet.getString("month12");
							
						}
					
						String sql1 = "select h.account 'Account',h.description 'Account Name',CONVERT(if(d.monthamt1=0,'',d.monthamt1),CHAR(100)) '"+incomemonth1+"',CONVERT(if(d.monthamt2=0,'',d.monthamt2),CHAR(100)) '"+incomemonth2+"',CONVERT(if(d.monthamt3=0,'',d.monthamt3),CHAR(100)) '"+incomemonth3+"',"
								 + "CONVERT(if(d.monthamt4=0,'',d.monthamt4),CHAR(100)) '"+incomemonth4+"',CONVERT(if(d.monthamt5=0,'',d.monthamt5),CHAR(100)) '"+incomemonth5+"',CONVERT(if(d.monthamt6=0,'',d.monthamt6),CHAR(100)) '"+incomemonth6+"',CONVERT(if(d.monthamt7=0,'',d.monthamt7),CHAR(100)) '"+incomemonth7+"',"
								 + "CONVERT(if(d.monthamt8=0,'',d.monthamt8),CHAR(100)) '"+incomemonth8+"',CONVERT(if(d.monthamt9=0,'',d.monthamt9),CHAR(100)) '"+incomemonth9+"',CONVERT(if(d.monthamt10=0,'',d.monthamt10),CHAR(100)) '"+incomemonth10+"',CONVERT(if(d.monthamt11=0,'',d.monthamt11),CHAR(100)) '"+incomemonth11+"',"
								 + "CONVERT(if(d.monthamt12=0,'',d.monthamt12),CHAR(100)) '"+incomemonth12+"' from my_budgetm m left join my_budgetdet d on m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=5 and d.brhid="+branch+" and d.rdocno="+docNo+"";
			         
						ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
		              
						RESULTDATA=commonDAO.convertToEXCEL(resultSet1);
						}
						
						stmtBGT.close();
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
		
		public JSONArray expenditureGridExcelExportLoading(HttpSession session,String docNo,String assessmentyear,String check) throws SQLException {
		      JSONArray RESULTDATA=new JSONArray();
		      
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
						Statement stmtBGT = conn.createStatement();
						
						if(check.equalsIgnoreCase("2")){
							
						java.sql.Date sqlAssessmentDate = null;
					     
					     if(!(assessmentyear.equalsIgnoreCase("undefined")) && !(assessmentyear.equalsIgnoreCase("")) && !(assessmentyear.equalsIgnoreCase("0"))){
					    	 sqlAssessmentDate = commonDAO.changeStringtoSqlDate(assessmentyear);
				         }
					     
						String sql="select DATE_FORMAT(LAST_DAY(date('"+sqlAssessmentDate+"')),'%b %Y') month1,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 1 MONTH),'%b %Y') month2,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 2 MONTH),'%b %Y') month3,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 3 MONTH),'%b %Y') month4,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 4 MONTH),'%b %Y') month5,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 5 MONTH),'%b %Y') month6,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 6 MONTH),'%b %Y') month7,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 7 MONTH),'%b %Y') month8,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 8 MONTH),'%b %Y') month9,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 9 MONTH),'%b %Y') month10,"
								+ "DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 10 MONTH),'%b %Y') month11,DATE_FORMAT(DATE_ADD(LAST_DAY(date('"+sqlAssessmentDate+"')),INTERVAL 11 MONTH),'%b %Y') month12";
						
						ResultSet resultSet = stmtBGT.executeQuery(sql);
					
						String expendituremonth1="",expendituremonth2="",expendituremonth3="",expendituremonth4="",expendituremonth5="",expendituremonth6="",expendituremonth7="",expendituremonth8="",expendituremonth9="",expendituremonth10="",expendituremonth11="",expendituremonth12="";
						while(resultSet.next()){
							
							expendituremonth1=resultSet.getString("month1");expendituremonth2=resultSet.getString("month2");expendituremonth3=resultSet.getString("month3");expendituremonth4=resultSet.getString("month4");expendituremonth5=resultSet.getString("month5");expendituremonth6=resultSet.getString("month6");
							expendituremonth7=resultSet.getString("month7");expendituremonth8=resultSet.getString("month8");expendituremonth9=resultSet.getString("month9");expendituremonth10=resultSet.getString("month10");expendituremonth11=resultSet.getString("month11");expendituremonth12=resultSet.getString("month12");
							
						}
					
						String sql1 = "select h.account 'Account',h.description 'Account Name',CONVERT(if(d.monthamt1=0,'',d.monthamt1),CHAR(100)) '"+expendituremonth1+"',CONVERT(if(d.monthamt2=0,'',d.monthamt2),CHAR(100)) '"+expendituremonth2+"',CONVERT(if(d.monthamt3=0,'',d.monthamt3),CHAR(100)) '"+expendituremonth3+"',"
								 + "CONVERT(if(d.monthamt4=0,'',d.monthamt4),CHAR(100)) '"+expendituremonth4+"',CONVERT(if(d.monthamt5=0,'',d.monthamt5),CHAR(100)) '"+expendituremonth5+"',CONVERT(if(d.monthamt6=0,'',d.monthamt6),CHAR(100)) '"+expendituremonth6+"',CONVERT(if(d.monthamt7=0,'',d.monthamt7),CHAR(100)) '"+expendituremonth7+"',"
								 + "CONVERT(if(d.monthamt8=0,'',d.monthamt8),CHAR(100)) '"+expendituremonth8+"',CONVERT(if(d.monthamt9=0,'',d.monthamt9),CHAR(100)) '"+expendituremonth9+"',CONVERT(if(d.monthamt10=0,'',d.monthamt10),CHAR(100)) '"+expendituremonth10+"',CONVERT(if(d.monthamt11=0,'',d.monthamt11),CHAR(100)) '"+expendituremonth11+"',"
								 + "CONVERT(if(d.monthamt12=0,'',d.monthamt12),CHAR(100)) '"+expendituremonth12+"' from my_budgetm m left join my_budgetdet d on m.doc_no=d.rdocno and m.brhid=d.brhid left join my_head h on d.acno=h.doc_no where m.status=3 and grtype=4 and d.brhid="+branch+" and d.rdocno="+docNo+"";
			         
						ResultSet resultSet1 = stmtBGT.executeQuery(sql1);
		              
						RESULTDATA=commonDAO.convertToEXCEL(resultSet1);
						}
						
						stmtBGT.close();
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
	
	 public JSONArray bgtMainSearch(HttpSession session,String docNo,String date,String assessmentsDate,String description) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
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
	       
	        java.sql.Date sqlBudgetDate=null;
	        java.sql.Date sqlAssessmentsDate=null;
	        
	        date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlBudgetDate = commonDAO.changeStringtoSqlDate(date);
	        }
	        
	        assessmentsDate.trim();
	        if(!(assessmentsDate.equalsIgnoreCase("undefined"))&&!(assessmentsDate.equalsIgnoreCase(""))&&!(assessmentsDate.equalsIgnoreCase("0")))
	        {
	        sqlAssessmentsDate = commonDAO.changeStringtoSqlDate("01."+assessmentsDate);
	        }
	        
	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and doc_no like '%"+docNo+"%'";
	        }
	        if(!(description.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and description like '%"+description+"%'";
	        }
	        if(!(sqlBudgetDate==null)){
		         sqltest=sqltest+" and date='"+sqlBudgetDate+"'";
		    } 
	        if(!(sqlAssessmentsDate==null)){
	         sqltest=sqltest+" and year='"+sqlAssessmentsDate+"'";
	        } 
	           
	     try {
		       conn = connDAO.getMyConnection();
		       Statement stmtBGT = conn.createStatement();
		       
		       String sql =  "select doc_no,date,year,if(description is null,' ',description) description from my_budgetm where status<>7 and brhid='"+branch+"'"+sqltest;

		       ResultSet resultSet = stmtBGT.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtBGT.close();
		       conn.close();
	     } catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     } finally{
				conn.close();
		 }
           return RESULTDATA;
       }
	 
	 private int insertion(Connection conn, int docno, String incomegridcolumn, String expendituregridcolumn, ArrayList<String> incomearray, ArrayList<String> expenditurearray, HttpSession session, String mode) throws SQLException{
		 
		 try{
				conn.setAutoCommit(false);
				CallableStatement stmtBGT;
				Statement stmtBGT1 = conn.createStatement();
				ArrayList<String> incomeseparatearray= new ArrayList<String>();
				ArrayList<String> expenditureseparatearray= new ArrayList<String>();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String[] incomegridcolumns=null;String[] expendituregridcolumns=null;
				
				if(incomegridcolumn.trim().contains("::")){ incomegridcolumns = incomegridcolumn.split("::"); }
				if(expendituregridcolumn.trim().contains("::")){ expendituregridcolumns = expendituregridcolumn.split("::"); }
				
				String sql="select Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[1].trim()+"'),'%d %M %Y')) month1,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[2].trim()+"'),'%d %M %Y')) month2,"
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[3].trim()+"'),'%d %M %Y')) month3,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[4].trim()+"'),'%d %M %Y')) month4,"
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[5].trim()+"'),'%d %M %Y')) month5,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[6].trim()+"'),'%d %M %Y')) month6,"
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[7].trim()+"'),'%d %M %Y')) month7,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[8].trim()+"'),'%d %M %Y')) month8,"  
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[9].trim()+"'),'%d %M %Y')) month9,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[10].trim()+"'),'%d %M %Y')) month10,"  
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[11].trim()+"'),'%d %M %Y')) month11,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+incomegridcolumns[12].trim()+"'),'%d %M %Y')) month12";

				ResultSet resultSet = stmtBGT1.executeQuery(sql);
				
				String incomemonth1="",incomemonth2="",incomemonth3="",incomemonth4="",incomemonth5="",incomemonth6="",incomemonth7="",incomemonth8="",incomemonth9="",incomemonth10="",incomemonth11="",incomemonth12="";
				while(resultSet.next()){
					incomemonth1 = resultSet.getString("month1");incomemonth2 = resultSet.getString("month2");incomemonth3 = resultSet.getString("month3");incomemonth4 = resultSet.getString("month4");
					incomemonth5 = resultSet.getString("month5");incomemonth6 = resultSet.getString("month6");incomemonth7 = resultSet.getString("month7");incomemonth8 = resultSet.getString("month8");
					incomemonth9 = resultSet.getString("month9");incomemonth10 = resultSet.getString("month10");incomemonth11 = resultSet.getString("month11");incomemonth12 = resultSet.getString("month12");
				}
				
				String sql1="select Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[1].trim()+"'),'%d %M %Y')) month1,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[2].trim()+"'),'%d %M %Y')) month2,"
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[3].trim()+"'),'%d %M %Y')) month3,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[4].trim()+"'),'%d %M %Y')) month4,"
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[5].trim()+"'),'%d %M %Y')) month5,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[6].trim()+"'),'%d %M %Y')) month6,"
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[7].trim()+"'),'%d %M %Y')) month7,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[8].trim()+"'),'%d %M %Y')) month8,"  
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[9].trim()+"'),'%d %M %Y')) month9,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[10].trim()+"'),'%d %M %Y')) month10,"  
						+ "Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[11].trim()+"'),'%d %M %Y')) month11,Last_DAY(STR_TO_DATE(CONCAT('01 ','"+expendituregridcolumns[12].trim()+"'),'%d %M %Y')) month12";

				ResultSet resultSet1 = stmtBGT1.executeQuery(sql1);
				
				String expendituremonth1="",expendituremonth2="",expendituremonth3="",expendituremonth4="",expendituremonth5="",expendituremonth6="",expendituremonth7="",expendituremonth8="",expendituremonth9="",expendituremonth10="",expendituremonth11="",expendituremonth12="";
				while(resultSet1.next()){
					expendituremonth1 = resultSet1.getString("month1");expendituremonth2 = resultSet1.getString("month2");expendituremonth3 = resultSet1.getString("month3");expendituremonth4 = resultSet1.getString("month4");
					expendituremonth5 = resultSet1.getString("month5");expendituremonth6 = resultSet1.getString("month6");expendituremonth7 = resultSet1.getString("month7");expendituremonth8 = resultSet1.getString("month8");
					expendituremonth9 = resultSet1.getString("month9");expendituremonth10 = resultSet1.getString("month10");expendituremonth11 = resultSet1.getString("month11");expendituremonth12 = resultSet1.getString("month12");
				}
				
				/*Income Grid and Details Separating*/
				for(int i=0;i< incomearray.size();i++){
					String[] income=incomearray.get(i).split("::");
					if(!income[0].trim().equalsIgnoreCase("undefined") && !income[0].trim().equalsIgnoreCase("NaN") && !income[0].trim().equalsIgnoreCase("") && !income[0].trim().equalsIgnoreCase("0")){
					
						incomeseparatearray.add(incomemonth1+":: "+income[0]+":: "+income[1]);incomeseparatearray.add(incomemonth2+":: "+income[0]+":: "+income[2]);incomeseparatearray.add(incomemonth3+":: "+income[0]+":: "+income[3]);incomeseparatearray.add(incomemonth4+":: "+income[0]+":: "+income[4]);
						incomeseparatearray.add(incomemonth5+":: "+income[0]+":: "+income[5]);incomeseparatearray.add(incomemonth6+":: "+income[0]+":: "+income[6]);incomeseparatearray.add(incomemonth7+":: "+income[0]+":: "+income[7]);incomeseparatearray.add(incomemonth8+":: "+income[0]+":: "+income[8]);
						incomeseparatearray.add(incomemonth9+":: "+income[0]+":: "+income[9]);incomeseparatearray.add(incomemonth10+":: "+income[0]+":: "+income[10]);incomeseparatearray.add(incomemonth11+":: "+income[0]+":: "+income[11]);incomeseparatearray.add(incomemonth12+":: "+income[0]+":: "+income[12]);
						
					}
				 }
				/*Income Grid and Details Separating Ends*/
			     
				/*Expenditure Grid and Details Separating*/
				for(int j=0;j< expenditurearray.size();j++){
					String[] expenditure=expenditurearray.get(j).split("::");
					if(!expenditure[0].trim().equalsIgnoreCase("undefined") && !expenditure[0].trim().equalsIgnoreCase("NaN") && !expenditure[0].trim().equalsIgnoreCase("") && !expenditure[0].trim().equalsIgnoreCase("0")){
					
						expenditureseparatearray.add(expendituremonth1+":: "+expenditure[0]+":: "+expenditure[1]);expenditureseparatearray.add(expendituremonth2+":: "+expenditure[0]+":: "+expenditure[2]);expenditureseparatearray.add(expendituremonth3+":: "+expenditure[0]+":: "+expenditure[3]);expenditureseparatearray.add(expendituremonth4+":: "+expenditure[0]+":: "+expenditure[4]);
						expenditureseparatearray.add(expendituremonth5+":: "+expenditure[0]+":: "+expenditure[5]);expenditureseparatearray.add(expendituremonth6+":: "+expenditure[0]+":: "+expenditure[6]);expenditureseparatearray.add(expendituremonth7+":: "+expenditure[0]+":: "+expenditure[7]);expenditureseparatearray.add(expendituremonth8+":: "+expenditure[0]+":: "+expenditure[8]);
						expenditureseparatearray.add(expendituremonth9+":: "+expenditure[0]+":: "+expenditure[9]);expenditureseparatearray.add(expendituremonth10+":: "+expenditure[0]+":: "+expenditure[10]);expenditureseparatearray.add(expendituremonth11+":: "+expenditure[0]+":: "+expenditure[11]);expenditureseparatearray.add(expendituremonth12+":: "+expenditure[0]+":: "+expenditure[12]);
						
					}
				 }
				 /*Expenditure Grid and Details Separating Ends*/
				
				/*Income Grid and Details Separated Saving*/
				for(int k=0;k< incomeseparatearray.size();k++){
					String[] incomeseparate=incomeseparatearray.get(k).split("::");
					if(!incomeseparate[2].trim().equalsIgnoreCase("undefined") && !incomeseparate[2].trim().equalsIgnoreCase("NaN") && !incomeseparate[2].trim().equalsIgnoreCase("") && !incomeseparate[2].trim().equalsIgnoreCase("0")){
						
						stmtBGT = conn.prepareCall("{CALL budgetdDML(?,?,?,?,?,?,?)}");
						
						/*Insertion to my_budgetd*/
						stmtBGT.setInt(5,docno);
						stmtBGT.registerOutParameter(6, java.sql.Types.INTEGER);
						stmtBGT.setString(1,(incomeseparate[1].trim().equalsIgnoreCase("undefined") || incomeseparate[1].trim().equalsIgnoreCase("NaN") || incomeseparate[1].trim().isEmpty()?0:incomeseparate[1].trim()).toString());  //doc_no of my_head
						stmtBGT.setString(2,(incomeseparate[0].trim().equalsIgnoreCase("undefined") || incomeseparate[0].trim().equalsIgnoreCase("NaN") || incomeseparate[0].trim().isEmpty()?0:incomeseparate[0].trim()).toString()); //date
						stmtBGT.setString(3,(incomeseparate[2].trim().equalsIgnoreCase("undefined") || incomeseparate[2].trim().equalsIgnoreCase("NaN") || incomeseparate[2].trim().equals(0) || incomeseparate[2].isEmpty()?0:incomeseparate[2].trim()).toString()); //amount 
						
						stmtBGT.setString(4,branch);
						stmtBGT.setString(7,mode);
						stmtBGT.execute();
						if(stmtBGT.getInt("irowsNo")<=0){
							stmtBGT.close();
							conn.close();
							return 0;
						}
					  }
				    }
				/*Income Grid and Details Separated Saving Ends*/
				
				/*Expenditure Grid and Details Separated Saving*/
				for(int l=0;l< expenditureseparatearray.size();l++){
					String[] expenditureseparate=expenditureseparatearray.get(l).split("::");
					if(!expenditureseparate[2].trim().equalsIgnoreCase("undefined") && !expenditureseparate[2].trim().equalsIgnoreCase("NaN") && !expenditureseparate[2].trim().equalsIgnoreCase("") && !expenditureseparate[2].trim().equalsIgnoreCase("0")){
						
						stmtBGT = conn.prepareCall("{CALL budgetdDML(?,?,?,?,?,?,?)}");
						
						/*Insertion to my_budgetd*/
						stmtBGT.setInt(5,docno);
						stmtBGT.registerOutParameter(6, java.sql.Types.INTEGER);
						stmtBGT.setString(1,(expenditureseparate[1].trim().equalsIgnoreCase("undefined") || expenditureseparate[1].trim().equalsIgnoreCase("NaN") || expenditureseparate[1].trim().isEmpty()?0:expenditureseparate[1].trim()).toString());  //doc_no of my_head
						stmtBGT.setString(2,(expenditureseparate[0].trim().equalsIgnoreCase("undefined") || expenditureseparate[0].trim().equalsIgnoreCase("NaN") || expenditureseparate[0].trim().isEmpty()?0:expenditureseparate[0].trim()).toString()); //date
						stmtBGT.setString(3,(expenditureseparate[2].trim().equalsIgnoreCase("undefined") || expenditureseparate[2].trim().equalsIgnoreCase("NaN") || expenditureseparate[2].trim().equals(0) || expenditureseparate[2].isEmpty()?0:expenditureseparate[2].trim()).toString()); //amount 
						
						stmtBGT.setString(4,branch);
						stmtBGT.setString(7,mode);
						stmtBGT.execute();
						if(stmtBGT.getInt("irowsNo")<=0){
							stmtBGT.close();
							conn.close();
							return 0;
						}
					  }
				    }
				 /*Expenditure Grid and Details Separated Saving Ends*/
				
				/*Income Grid and Details Saving*/
				for(int m=0;m< incomearray.size();m++){
					String[] income=incomearray.get(m).split("::");
					if(!income[14].trim().equalsIgnoreCase("undefined") && !income[14].trim().equalsIgnoreCase("NaN") && !income[14].trim().equalsIgnoreCase("") && !income[14].trim().equalsIgnoreCase("0")){
						
						stmtBGT = conn.prepareCall("{CALL budgetdetDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_budgetdet*/
						stmtBGT.setInt(17,docno);
						stmtBGT.registerOutParameter(18, java.sql.Types.INTEGER);
						stmtBGT.setString(1,(income[0].trim().equalsIgnoreCase("undefined") || income[0].trim().equalsIgnoreCase("NaN") || income[0].trim().isEmpty()?0:income[0].trim()).toString());  //doc_no of my_head
						stmtBGT.setString(2,(income[1].trim().equalsIgnoreCase("undefined") || income[1].trim().equalsIgnoreCase("NaN") || income[1].trim().isEmpty()?0:income[1].trim()).toString()); //month 1
						stmtBGT.setString(3,(income[2].trim().equalsIgnoreCase("undefined") || income[2].trim().equalsIgnoreCase("NaN") || income[2].trim().isEmpty()?0:income[2].trim()).toString()); //month 2
						stmtBGT.setString(4,(income[3].trim().equalsIgnoreCase("undefined") || income[3].trim().equalsIgnoreCase("NaN") || income[3].trim().isEmpty()?0:income[3].trim()).toString()); //month 3
						stmtBGT.setString(5,(income[4].trim().equalsIgnoreCase("undefined") || income[4].trim().equalsIgnoreCase("NaN") || income[4].trim().isEmpty()?0:income[4].trim()).toString()); //month 4
						stmtBGT.setString(6,(income[5].trim().equalsIgnoreCase("undefined") || income[5].trim().equalsIgnoreCase("NaN") || income[5].trim().isEmpty()?0:income[5].trim()).toString()); //month 5
						stmtBGT.setString(7,(income[6].trim().equalsIgnoreCase("undefined") || income[6].trim().equalsIgnoreCase("NaN") || income[6].trim().isEmpty()?0:income[6].trim()).toString()); //month 6
						stmtBGT.setString(8,(income[7].trim().equalsIgnoreCase("undefined") || income[7].trim().equalsIgnoreCase("NaN") || income[7].trim().isEmpty()?0:income[7].trim()).toString()); //month 7
						stmtBGT.setString(9,(income[8].trim().equalsIgnoreCase("undefined") || income[8].trim().equalsIgnoreCase("NaN") || income[8].trim().isEmpty()?0:income[8].trim()).toString()); //month 8
						stmtBGT.setString(10,(income[9].trim().equalsIgnoreCase("undefined") || income[9].trim().equalsIgnoreCase("NaN") || income[9].trim().isEmpty()?0:income[9].trim()).toString()); //month 9
						stmtBGT.setString(11,(income[10].trim().equalsIgnoreCase("undefined") || income[10].trim().equalsIgnoreCase("NaN") || income[10].trim().isEmpty()?0:income[10].trim()).toString()); //month 10
						stmtBGT.setString(12,(income[11].trim().equalsIgnoreCase("undefined") || income[11].trim().equalsIgnoreCase("NaN") || income[11].trim().isEmpty()?0:income[11].trim()).toString()); //month 11
						stmtBGT.setString(13,(income[12].trim().equalsIgnoreCase("undefined") || income[12].trim().equalsIgnoreCase("NaN") || income[12].trim().isEmpty()?0:income[12].trim()).toString()); //month 12
						stmtBGT.setString(14,(income[13].trim().equalsIgnoreCase("undefined") || income[13].trim().equalsIgnoreCase("NaN") || income[13].trim().equals(0) || income[13].isEmpty()?0:income[13].trim()).toString()); //grtype 
						stmtBGT.setString(15,(income[14].trim().equalsIgnoreCase("undefined") || income[14].trim().equalsIgnoreCase("NaN") || income[14].trim().equals(0) || income[14].isEmpty()?0:income[14].trim()).toString()); //net income
						
						stmtBGT.setString(16,branch);
						stmtBGT.setString(19,mode);
						stmtBGT.execute();
						if(stmtBGT.getInt("irowsNo")<=0){
							stmtBGT.close();
							conn.close();
							return 0;
						}
					  }
				    }
				/*Income Grid and Details Saving Ends*/
				
				/*Expenditure Grid and Details Saving*/
				for(int n=0;n< expenditurearray.size();n++){
					String[] expenditure=expenditurearray.get(n).split("::");
					if(!expenditure[14].trim().equalsIgnoreCase("undefined") && !expenditure[14].trim().equalsIgnoreCase("NaN") && !expenditure[14].trim().equalsIgnoreCase("") && !expenditure[14].trim().equalsIgnoreCase("0")){
						
						stmtBGT = conn.prepareCall("{CALL budgetdetDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
						
						/*Insertion to my_budgetd*/
						stmtBGT.setInt(17,docno);
						stmtBGT.registerOutParameter(18, java.sql.Types.INTEGER);
						stmtBGT.setString(1,(expenditure[0].trim().equalsIgnoreCase("undefined") || expenditure[0].trim().equalsIgnoreCase("NaN") || expenditure[0].trim().isEmpty()?0:expenditure[0].trim()).toString());  //doc_no of my_head
						stmtBGT.setString(2,(expenditure[1].trim().equalsIgnoreCase("undefined") || expenditure[1].trim().equalsIgnoreCase("NaN") || expenditure[1].trim().isEmpty()?0:expenditure[1].trim()).toString()); //month 1
						stmtBGT.setString(3,(expenditure[2].trim().equalsIgnoreCase("undefined") || expenditure[2].trim().equalsIgnoreCase("NaN") || expenditure[2].trim().isEmpty()?0:expenditure[2].trim()).toString()); //month 2
						stmtBGT.setString(4,(expenditure[3].trim().equalsIgnoreCase("undefined") || expenditure[3].trim().equalsIgnoreCase("NaN") || expenditure[3].trim().isEmpty()?0:expenditure[3].trim()).toString()); //month 3
						stmtBGT.setString(5,(expenditure[4].trim().equalsIgnoreCase("undefined") || expenditure[4].trim().equalsIgnoreCase("NaN") || expenditure[4].trim().isEmpty()?0:expenditure[4].trim()).toString()); //month 4
						stmtBGT.setString(6,(expenditure[5].trim().equalsIgnoreCase("undefined") || expenditure[5].trim().equalsIgnoreCase("NaN") || expenditure[5].trim().isEmpty()?0:expenditure[5].trim()).toString()); //month 5
						stmtBGT.setString(7,(expenditure[6].trim().equalsIgnoreCase("undefined") || expenditure[6].trim().equalsIgnoreCase("NaN") || expenditure[6].trim().isEmpty()?0:expenditure[6].trim()).toString()); //month 6
						stmtBGT.setString(8,(expenditure[7].trim().equalsIgnoreCase("undefined") || expenditure[7].trim().equalsIgnoreCase("NaN") || expenditure[7].trim().isEmpty()?0:expenditure[7].trim()).toString()); //month 7
						stmtBGT.setString(9,(expenditure[8].trim().equalsIgnoreCase("undefined") || expenditure[8].trim().equalsIgnoreCase("NaN") || expenditure[8].trim().isEmpty()?0:expenditure[8].trim()).toString()); //month 8
						stmtBGT.setString(10,(expenditure[9].trim().equalsIgnoreCase("undefined") || expenditure[9].trim().equalsIgnoreCase("NaN") || expenditure[9].trim().isEmpty()?0:expenditure[9].trim()).toString()); //month 9
						stmtBGT.setString(11,(expenditure[10].trim().equalsIgnoreCase("undefined") || expenditure[10].trim().equalsIgnoreCase("NaN") || expenditure[10].trim().isEmpty()?0:expenditure[10].trim()).toString()); //month 10
						stmtBGT.setString(12,(expenditure[11].trim().equalsIgnoreCase("undefined") || expenditure[11].trim().equalsIgnoreCase("NaN") || expenditure[11].trim().isEmpty()?0:expenditure[11].trim()).toString()); //month 11
						stmtBGT.setString(13,(expenditure[12].trim().equalsIgnoreCase("undefined") || expenditure[12].trim().equalsIgnoreCase("NaN") || expenditure[12].trim().isEmpty()?0:expenditure[12].trim()).toString()); //month 12
						stmtBGT.setString(14,(expenditure[13].trim().equalsIgnoreCase("undefined") || expenditure[13].trim().equalsIgnoreCase("NaN") || expenditure[13].trim().equals(0) || expenditure[13].isEmpty()?0:expenditure[13].trim()).toString()); //grtype 
						stmtBGT.setString(15,(expenditure[14].trim().equalsIgnoreCase("undefined") || expenditure[14].trim().equalsIgnoreCase("NaN") || expenditure[14].trim().equals(0) || expenditure[14].isEmpty()?0:expenditure[14].trim()).toString()); //net income
						
						stmtBGT.setString(16,branch);
						stmtBGT.setString(19,mode);
						stmtBGT.execute();
						if(stmtBGT.getInt("irowsNo")<=0){
							stmtBGT.close();
							conn.close();
							return 0;
						}
					  }
				    }
				/*Expenditure Grid and Details Saving Ends*/
				
				/*Deleting account of value zero*/
				String sql2=("DELETE FROM my_budgetd where rdocno="+docno+" and brhid="+branch+" and acno=0");
			    int data = stmtBGT1.executeUpdate(sql2);
			    
			    String sql3=("DELETE FROM my_budgetdet where rdocno="+docno+" and brhid="+branch+" and acno=0");
			    int data1 = stmtBGT1.executeUpdate(sql3);
			    /*Deleting account of value zero ends*/
					
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
	 
	 public  JSONArray convertColumnArrayToJSON(ArrayList<String> columnsList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			JSONArray jsonArray1 = new JSONArray();
			
			for (int i = 0; i < columnsList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				String[] columnArray=columnsList.get(i).split("::");
				
				obj.put("text",columnArray[0]);
				obj.put("datafield",columnArray[1]);
				obj.put("cellsAlign",columnArray[2]);
				obj.put("align",columnArray[3]);
				if(!(columnArray[4].trim().equalsIgnoreCase(""))){
					obj.put("hidden",columnArray[4]);
			    }
				if(!(columnArray[5].trim().equalsIgnoreCase(""))){
					obj.put("width",columnArray[5]);
			    }
				if(!(columnArray[6].trim().equalsIgnoreCase(""))){
				    obj.put("cellsFormat",columnArray[6]);
				}
				if(!(columnArray[7].trim().equalsIgnoreCase(""))){
				    obj.put("cellclassname",columnArray[7]);
				}
				if(!(columnArray[8].trim().equalsIgnoreCase(""))){
				    obj.put("aggregates",columnArray[8]);
				}
				
				jsonArray.add(obj);
			}
			JSONObject obj1 = new JSONObject();
			obj1.put("columns",jsonArray);
			jsonArray1.add(obj1);
			return jsonArray1;
			}
		
		public  JSONArray convertRowArrayToJSON(ArrayList<ArrayList<String>> rowsList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			JSONArray jsonArray1 = new JSONArray();
			
			for (int i = 0; i < rowsList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				ArrayList<String> rowArray=rowsList.get(i);
				
				obj.put("acno",rowArray.get(0));
				obj.put("account",rowArray.get(1));
				obj.put("accountname",rowArray.get(2));

				for (int k=1; k < 13; k++) {
						obj.put("monthamt"+k,"");
				}
				
				obj.put("grtype",rowArray.get(3));
				obj.put("netincome",rowArray.get(4));
				
				jsonArray.add(obj);
			}
			JSONObject obj1 = new JSONObject();
			obj1.put("rows",jsonArray);
			jsonArray1.add(obj1);
			return jsonArray1;
		 }
		
		public  JSONArray convertRowDetailsArrayToJSON(ArrayList<ArrayList<String>> rowsList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			JSONArray jsonArray1 = new JSONArray();
			
			for (int i = 0; i < rowsList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				ArrayList<String> rowArray=rowsList.get(i);
				
				obj.put("acno",rowArray.get(0));
				obj.put("account",rowArray.get(1));
				obj.put("accountname",rowArray.get(2));
				obj.put("grtype",rowArray.get(3));
				obj.put("netincome",rowArray.get(4));
				
				for (int j = 5,k=1; j < 17; j++,k++) {
					if(!(rowArray.get(j).trim().equalsIgnoreCase(""))){  
						obj.put("monthamt"+k,rowArray.get(j));
					}
				}
				
				jsonArray.add(obj);
			}
			JSONObject obj1 = new JSONObject();
			obj1.put("rows",jsonArray);
			jsonArray1.add(obj1);
			return jsonArray1;
			}
		public  JSONArray convertRowDetailsArrayToJSON11(ArrayList<ArrayList<String>> rowsList) throws Exception {
			JSONArray jsonArray = new JSONArray();
			JSONArray jsonArray1 = new JSONArray();
			
			for (int i = 0; i < rowsList.size(); i++) {
				
				JSONObject obj = new JSONObject();
				
				ArrayList<String> rowArray=rowsList.get(i);
				
				obj.put("accountname",rowArray.get(0));  
				for (int j = 1,k=1; j < 13; j++,k++) {
					if(!(rowArray.get(j).trim().equalsIgnoreCase(""))){
						obj.put("monthamt"+k,rowArray.get(j));
					}
				}
				
				jsonArray.add(obj);
			}
			JSONObject obj1 = new JSONObject();
			obj1.put("rows",jsonArray);
			jsonArray1.add(obj1);
			return jsonArray1;
			}

}
