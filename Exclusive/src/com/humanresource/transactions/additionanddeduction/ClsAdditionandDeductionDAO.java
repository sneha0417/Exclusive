package com.humanresource.transactions.additionanddeduction;

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

import com.common.ClsCommon;
import com.connection.ClsConnection;
 
	public class ClsAdditionandDeductionDAO {
		
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public int insert(String desc, int years, int months, Date masterdate, String refno, String formdetailcode, String mode, HttpServletRequest request,
			HttpSession session, ArrayList<String> comparray) throws SQLException {
		
	Connection conn=null;

	try{
	        conn=ClsConnection.getMyConnection();
	        conn.setAutoCommit(false);
	        
		    CallableStatement stmtALW = conn.prepareCall("{CALL HR_additionanddeduction(?,?,?,?,?,?,?,?,?,?,?)}");
			
		    stmtALW.registerOutParameter(11, java.sql.Types.INTEGER);
		    stmtALW.setDate(1,masterdate);
		    stmtALW.setInt(2,years);
		    stmtALW.setInt(3,months);
		    stmtALW.setString(4,refno);
		    stmtALW.setString(5,mode);
		    stmtALW.setString(6,session.getAttribute("USERID").toString().trim());
		    stmtALW.setString(7,session.getAttribute("BRANCHID").toString().trim());
		    stmtALW.setString(8,session.getAttribute("COMPANYID").toString().trim());
		    stmtALW.setString(9,formdetailcode);
		    stmtALW.setString(10,desc);
		    stmtALW.executeQuery();
			int	 docno=stmtALW.getInt("docNo");
			if(docno<=0) {
				conn.close();
				return 0;
			}	     
 
			for(int i=0;i< comparray.size();i++){
		    	
			     String[] comarray=comparray.get(i).split("::");
			     if(!(comarray[0].trim().equalsIgnoreCase("undefined")|| comarray[0].trim().equalsIgnoreCase("NaN")||comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty())) {

		            String sql="INSERT INTO hr_adddedd(srno, empId, addition, deduction, remarks, atype, acno, costtype, costcode, rdocno) VALUES "
				       + " ("+(i+1)+","
				       + "'"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim())+"',"
				       + "'"+(comarray[1].trim().equalsIgnoreCase("undefined") || comarray[1].trim().equalsIgnoreCase("NaN")|| comarray[1].trim().equalsIgnoreCase("")|| comarray[1].isEmpty()?0:comarray[1].trim())+"',"
				       + "'"+(comarray[2].trim().equalsIgnoreCase("undefined") || comarray[2].trim().equalsIgnoreCase("NaN")|| comarray[2].trim().equalsIgnoreCase("")|| comarray[2].isEmpty()?0:comarray[2].trim())+"',"
				       + "'"+(comarray[3].trim().equalsIgnoreCase("undefined") || comarray[3].trim().equalsIgnoreCase("NaN")|| comarray[3].trim().equalsIgnoreCase("")|| comarray[3].isEmpty()?0:comarray[3].trim())+"',"
				       + "'"+(comarray[4].trim().equalsIgnoreCase("undefined") || comarray[4].trim().equalsIgnoreCase("NaN")|| comarray[4].trim().equalsIgnoreCase("")|| comarray[4].isEmpty()?0:comarray[4].trim())+"',"
				       + "'"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")|| comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim())+"',"
				       + "'"+(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")|| comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim())+"',"
				       + "'"+(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")|| comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim())+"',"
				       +"'"+docno+"')";
				     int resultSet2 = stmtALW.executeUpdate(sql);
				     if(resultSet2<=0) {
							conn.close();
							return 0;
					 }
			     }
			}
			
			if(docno > 0) {
				conn.commit();
				stmtALW.close();
				conn.close();
				return docno;
			}
         } catch (Exception e) {
			conn.close();
			e.printStackTrace();
		}
		return 0;
	}

	public int update(int docno, String desc, int years, int months, Date masterdate, String refno, String formdetailcode, String mode, HttpServletRequest request, 
			HttpSession session, ArrayList<String> comparray)  throws SQLException {
	
	Connection conn=null;

	try{
            conn=ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
           
		    CallableStatement stmtALW = conn.prepareCall("{CALL HR_additionanddeduction(?,?,?,?,?,?,?,?,?,?,?)}");
			
		    stmtALW.setInt(11, docno);
		    stmtALW.setDate(1,masterdate);
		    stmtALW.setInt(2,years);
			stmtALW.setInt(3,months);
			stmtALW.setString(4,refno);
			stmtALW.setString(5,mode);
			stmtALW.setString(6,session.getAttribute("USERID").toString().trim());
			stmtALW.setString(7,session.getAttribute("BRANCHID").toString().trim());
			stmtALW.setString(8,session.getAttribute("COMPANYID").toString().trim());
			stmtALW.setString(9,formdetailcode);
			stmtALW.setString(10,desc);
			int res=stmtALW.executeUpdate();
			stmtALW.getInt("docNo");
			if(res<=0) {
				conn.close();
				return 0;
			}
							
			String delsql="delete from hr_adddedd where rdocno='"+docno+"'";			
			stmtALW.executeUpdate(delsql);
							
			for(int i=0;i< comparray.size();i++){
			    	
				String[] comarray=comparray.get(i).split("::");
				if(!(comarray[0].trim().equalsIgnoreCase("undefined")|| comarray[0].trim().equalsIgnoreCase("NaN")||comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty())) {

			       String sql="INSERT INTO hr_adddedd(srno, empId, addition, deduction, remarks, atype, acno, costtype, costcode, rdocno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(comarray[0].trim().equalsIgnoreCase("undefined") || comarray[0].trim().equalsIgnoreCase("NaN")|| comarray[0].trim().equalsIgnoreCase("")|| comarray[0].isEmpty()?0:comarray[0].trim())+"',"
					       + "'"+(comarray[1].trim().equalsIgnoreCase("undefined") || comarray[1].trim().equalsIgnoreCase("NaN")|| comarray[1].trim().equalsIgnoreCase("")|| comarray[1].isEmpty()?0:comarray[1].trim())+"',"
					       + "'"+(comarray[2].trim().equalsIgnoreCase("undefined") || comarray[2].trim().equalsIgnoreCase("NaN")|| comarray[2].trim().equalsIgnoreCase("")|| comarray[2].isEmpty()?0:comarray[2].trim())+"',"
					       + "'"+(comarray[3].trim().equalsIgnoreCase("undefined") || comarray[3].trim().equalsIgnoreCase("NaN")|| comarray[3].trim().equalsIgnoreCase("")|| comarray[3].isEmpty()?0:comarray[3].trim())+"',"
					       + "'"+(comarray[4].trim().equalsIgnoreCase("undefined") || comarray[4].trim().equalsIgnoreCase("NaN")|| comarray[4].trim().equalsIgnoreCase("")|| comarray[4].isEmpty()?0:comarray[4].trim())+"',"
					       + "'"+(comarray[5].trim().equalsIgnoreCase("undefined") || comarray[5].trim().equalsIgnoreCase("NaN")|| comarray[5].trim().equalsIgnoreCase("")|| comarray[5].isEmpty()?0:comarray[5].trim())+"',"
					       + "'"+(comarray[6].trim().equalsIgnoreCase("undefined") || comarray[6].trim().equalsIgnoreCase("NaN")|| comarray[6].trim().equalsIgnoreCase("")|| comarray[6].isEmpty()?0:comarray[6].trim())+"',"
					       + "'"+(comarray[7].trim().equalsIgnoreCase("undefined") || comarray[7].trim().equalsIgnoreCase("NaN")|| comarray[7].trim().equalsIgnoreCase("")|| comarray[7].isEmpty()?0:comarray[7].trim())+"',"
					       +"'"+docno+"')";

					int resultSet2 = stmtALW.executeUpdate(sql);
					if(resultSet2<=0) {
								conn.close();
								return 0;
					}
				 }
			}
		
		if (docno > 0) {
			conn.commit();
			stmtALW.close();
			conn.close();
			return docno;
		}
      } catch (Exception e) {
    	  conn.close();
    	  e.printStackTrace();
	  }
	return 0;
	}

	public int delete(int docno, String mode, String formdetailcode, HttpSession session, HttpServletRequest request) throws SQLException {

	Connection conn=null;

	try{
		    conn=ClsConnection.getMyConnection();
          
		    CallableStatement stmtALW = conn.prepareCall("{CALL HR_additionanddeduction(?,?,?,?,?,?,?,?,?,?,?)}");
			
		    stmtALW.setInt(11, docno);
		    stmtALW.setDate(1,null);
		    stmtALW.setInt(2,0);
		    stmtALW.setInt(3,0);
		    stmtALW.setString(4,null);
		    stmtALW.setString(5,mode);
		    stmtALW.setString(6,session.getAttribute("USERID").toString().trim());
		    stmtALW.setString(7,session.getAttribute("BRANCHID").toString().trim());
		    stmtALW.setString(8,session.getAttribute("COMPANYID").toString().trim());
		    stmtALW.setString(9,formdetailcode);
		    stmtALW.setString(10,null);
			int res=stmtALW.executeUpdate();
			stmtALW.getInt("docNo");
						
				if(res<=0) {
					conn.close();
					return 0;
				}
							 
				if (docno > 0) {
					stmtALW.close();
					conn.close();
					return docno;
				}
			} catch (Exception e) {
					conn.close();
					e.printStackTrace();
			}
		  return 0;
		}
	
	public JSONArray employeeDetailsSearch(String empid,String employeename,String contact) throws SQLException {
	   
		Connection conn=null;
	     
	      JSONArray RESULTDATA1=new JSONArray();
	  
	      try {
	           conn = ClsConnection.getMyConnection();
	           Statement stmtALW = conn.createStatement();
	    
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
	             
		     sql = 	"select m.doc_no,m.codeno,m.dtjoin,m.pmmob,m.name,m.desc_id,m.dept_id,m.pay_catid,m.acno,d.desc1 dept,ds.desc1 desig,ca.desc1 category,h.atype,h.account,"
		    	+ "h.description accountname  from hr_empm m left join hr_setdept d on d.doc_no=m.dept_id left join hr_setdesig ds on ds.doc_no=m.desc_id left join hr_setpaycat ca "
		    	+ "on ca.doc_no=m.pay_catid left join my_head h on m.acno=h.doc_no where m.status=3 and m.active=1 and m.dtype='EMP' "+sql;
	     
		     ResultSet resultSet1 = stmtALW.executeQuery(sql);
	     
		     RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
	     
		 stmtALW.close();
	     conn.close();
	   } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
	   } finally{
		   conn.close();
	   }
	      return RESULTDATA1;
	  }
	
	public JSONArray accountDetailsSearch(String accountno,String accountname,String atype,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtALW = conn.createStatement();
            	
				if(check.equalsIgnoreCase("1")){
					
					String sql="";
					
					if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
			            sql=sql+" and account like '%"+accountno+"%'";
			        }
					
			        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
			         sql=sql+" and description like '%"+accountname+"%'";
			        }
						
			        sql = "select doc_no,account,description,gr_type grtype from my_head where m_s=0 and atype='"+atype+"'"+sql+"";

			        ResultSet resultSet = stmtALW.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
				}
				
				stmtALW.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
        return RESULTDATA;
    }

	
	public JSONArray reloadgridSearch(String docno) throws SQLException {
	   
		Connection conn=null;
	     
	    JSONArray RESULTDATA1=new JSONArray();
	  
	    try {
	           conn = ClsConnection.getMyConnection();
	           Statement stmtALW = conn.createStatement();
	    
	           String sql = "";
	   
	           sql = "select d.empId empdoc,m.codeno empid,d.addition,d.deduction,d.remarks,d.srno,d.atype,d.acno,d.costtype,d.costcode,m.name empname,f.costgroup,h.account,h.description accountname,h.gr_type grtype "
	        	   + "from hr_adddedd d left join hr_empm m on m.doc_no=d.empid and m.dtype='EMP' left join my_costunit f on d.costtype=f.costtype left join my_head h on d.acno=h.doc_no where d.rdocno='"+docno+"' ";
	     
	           ResultSet resultSet1 = stmtALW.executeQuery(sql);
	          //  System.out.println("grid load"+sql);
	           
	           RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
	     
	     stmtALW.close();
	     conn.close();
	   } catch(Exception e){
	      e.printStackTrace();
	      conn.close();
	   } finally{
	     conn.close();
	   }
	      return RESULTDATA1;
	  }
	
	public JSONArray alwMainSearch(HttpSession session,String date,String docNo,String year,String month,String description) throws SQLException {

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
        
        //String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlDate=null;
        
        date.trim();
        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
        sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }

        String sqltest="";
        
        if(!(sqlDate==null)){
        	sqltest=sqltest+" and m.date='"+sqlDate+"'";
	    } 
        if(!(docNo.equalsIgnoreCase(""))){
            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
        }
        if(!(month.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.month='"+month+"'";
        }
        if(!(year.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.year like '%"+year+"%'";
        }
        if(!(description.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.description like '%"+description+"%'";
        }
       
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtALW = conn.createStatement();
	       
	       ResultSet resultSet = stmtALW.executeQuery("select m.date,m.year,m.description,m.refno,m.doc_no,mn.monthname month from hr_adddedm m left join hr_month mn on m.month=mn.doc_no where m.status<>7"+sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtALW.close();
	       conn.close();
     } catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     } finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public  ClsAdditionandDeductionBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		    ClsAdditionandDeductionBean additionandDeductionBean = new ClsAdditionandDeductionBean();
			
			Connection conn = null;
			
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtALW = conn.createStatement();
			
				//String branch = session.getAttribute("BRANCHID").toString();
				
				ResultSet resultSet = stmtALW.executeQuery ("select date, month ,year,description,refno,doc_no from hr_adddedm where status<>7 and doc_no="+docNo);
				
				while (resultSet.next()) {
						additionandDeductionBean.setDocno(docNo);
						additionandDeductionBean.setMasterdate(resultSet.getDate("date").toString());
						additionandDeductionBean.setRefno(resultSet.getString("refno"));
						additionandDeductionBean.setHidcmbyear(resultSet.getInt("year"));
						additionandDeductionBean.setHidcmbmonth(resultSet.getInt("month"));
						additionandDeductionBean.setDesc(resultSet.getString("description"));
				}
			  stmtALW.close();
			  conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return additionandDeductionBean;
			}
}
