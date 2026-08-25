package com.dashboard.realestate.ejaripayment;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsEjariPaymentDAO {
	
	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	ClsConnection ClsConnection=new ClsConnection();
 
	ClsCommon ClsCommon=new ClsCommon();
	
public   JSONArray accountsDetails(HttpSession session,String dtype,String accountno,String accountname,String currency,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
	     try {
	       
		       conn = conobj.getMyConnection();
		       Statement stmt = conn.createStatement();
	
		       System.out.println("====dtype======="+dtype);
	           String den= "";
	           
	            if(dtype.equalsIgnoreCase("CA")){
					den="604";
				}
				else if(dtype.equalsIgnoreCase("BA")){
					den="305";
				}
				 
				
	           java.sql.Date sqlDate=null;
		       
	           if(check.equalsIgnoreCase("1")){
	        	   
	 
	            
		        String sqltest="";
		        String sql="";
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
			         sqltest=sqltest+" and c.code like '%"+currency+"%'";
			    }
		        
		        	
		         
	        	sql="SELECT description,account,curid,rate FROM MY_HEAD WHERE DEN=604 AND M_S=0"; // bank 305 cash 604
		        System.out.println("====sql======="+sql);
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=com.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		      stmt.close();
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
	
	public   JSONArray listsearch(String branch,String fromdate,String todate,String aa) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	    if(!aa.equalsIgnoreCase("yes"))
	    {
	    	return RESULTDATA;
	    }
	    
	   
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	} 

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
    	 
 
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stm = conn.createStatement ();     
		 
				 
				
				String sql=" select m.voc_no,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.name pname,"
						+ "coalesce((round(rt.nettotal,2)),0)ejamt,coalesce((round(rt.ejaripay,2)),0)pymt from rl_tncm m"
						+ " left join rl_propertymaster pm on pm.doc_no=m.prtype left join my_acbook a on a.acno=m.acno"
						+ " left join rl_tncterms rt on m.doc_no=rt.rdocno AND IDNO=7 where m.status=3 and rt.paytrno=0 and RT.NETTOTAL!=0 order by m.voc_no";
						
            	      System.out.println("-----maingrid------"+sql);	
            		   ResultSet resultSet = stm.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		   stm.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
}
