package com.common;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.*;
import com.google.gson.JsonElement;

import freemarker.core.ParseException;

import org.apache.commons.collections.map.StaticBucketMap;
import org.apache.struts2.ServletActionContext;

public class ClsCommon {
	ClsConnection ClsConnection=new ClsConnection();
	
	public  Date changeStringtoSqlDate(String startDate){
		java.sql.Date sqlStartDate=null;
		try{
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd.MM.yyyy");
			java.util.Date date = sdf1.parse(startDate);
			sqlStartDate = new java.sql.Date(date.getTime());
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return sqlStartDate;
	}
	
	public  Date changeStringtoSqlDate2(String startDate){
		java.sql.Date sqlStartDate=null;
		try{
			SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
			java.util.Date date = sdf1.parse(startDate);
			sqlStartDate = new java.sql.Date(date.getTime());
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return sqlStartDate;
	}
	public  String changeSqltoString(Date startDate){
		String testdate=startDate.toString();
		String temp="";
		try{
		    SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy");
		    temp = format2.format(startDate);
		    
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return temp;
	}
	
	public  JSONArray convertToJSON(ResultSet resultSet)
			throws Exception {
			JSONArray jsonArray = new JSONArray();
			while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				 /*obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));*/
				//  obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ")));
				  obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? ""
						 : resultSet.getObject(i + 1).toString().replaceAll("[^a-zA-Z0-9/.+\\s+\\s-\\s:\\s*\\s@\\s\\&\\s%\\s(\\s)\\s;\\s_\\s,]", " ").replaceAll("\\r?\\n|\\r", " ")));
			//	obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replaceAll("[^\\w\\s\\-_]", "")));
				
			}
			jsonArray.add(obj);
			}
			//System.out.println("ConvertTOJson:   "+jsonArray);
			return jsonArray;
			}
			
	public  JSONArray convertToSIF(ResultSet resultSet) throws Exception {
		   
		   JSONArray jsonArray = new JSONArray();

		   while (resultSet.next()) {
		   int total_rows = resultSet.getMetaData().getColumnCount();
		   
		   JSONObject obj = new JSONObject();
		   for (int i = 0; i < total_rows; i++) {
			 obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
		   }
		   jsonArray.add(obj);
		   }
	   return jsonArray;
	   }
	
	public  Date changetstmptoSqlDate(String startDate){

		   java.sql.Date sqlStartDate=null;
		    try{
		     
              SimpleDateFormat targetFormat = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss");
              java.util.Date date1 = targetFormat.parse(startDate);
              sqlStartDate = new java.sql.Date(date1.getTime());
		              
		  }
		  catch(Exception e){
		   e.printStackTrace();
		  }
		  return sqlStartDate;
		 }
	
	public  double round(double value,HttpSession session) {
          int places=session.getAttribute("AMTDEC")==null?0:Integer.parseInt(session.getAttribute("AMTDEC").toString());
          if (places < 0) throw new IllegalArgumentException();
      
          BigDecimal bd = new BigDecimal(value);
          bd = bd.setScale(places, RoundingMode.HALF_UP);
          return bd.doubleValue();
      }
	public  String getMonthandDays(java.sql.Date closedate,java.sql.Date opendate,Connection conn) throws SQLException{
		Statement stmt=conn.createStatement();
		/*String getMonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday, DATEDIFF( '"+closedate+"', DATE_ADD('"+opendate+"',INTERVAL a.months month) ) days from ("+
				" select if(day('"+opendate+"')>day('"+closedate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )) months) a";*/
		
		/*String getMonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday, DATEDIFF( '"+closedate+"',if(a.months>0,LAST_DAY(DATE_ADD( '"+opendate+"',INTERVAL a.months month)),"+
				" DATE_ADD('"+opendate+"',INTERVAL a.months month))) days from (select if(day('"+opendate+"')>day('"+closedate+"'),PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )) months) a";*/
		
		/*(2015-05-18) String getMonth="select a.months,DAY(LAST_DAY('"+closedate+"')) lastday,DATEDIFF('"+closedate+"', '"+opendate+"' ) days from (select if(day('"+opendate+"')>day('"+closedate+"'),"+
				" PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )-1,PERIOD_DIFF( EXTRACT( YEAR_MONTH FROM '"+closedate+"' ),"+
				" EXTRACT( YEAR_MONTH FROM '"+opendate+"' ) )) months) a";*/
		
		
		
		
		String getMonth="select if((DATEDIFF('"+closedate+"', '"+opendate+"')/DAY(LAST_DAY('"+closedate+"'))>=1),"+
				" concat(round(DATEDIFF('"+closedate+"', '"+opendate+"')/DAY(LAST_DAY('"+closedate+"'))),' Month'),concat(round(DATEDIFF('"+closedate+"', '"+opendate+"')),"+
				" ' Days')) days";
//		System.out.println("MnthDays Query:"+getMonth);
		ResultSet rsgetMonth=stmt.executeQuery(getMonth);
		String months="",days="",returnvalue="";
		while(rsgetMonth.next()){
			//months=rsgetMonth.getString("months");
			days=rsgetMonth.getString("days");
		}
/*		if(Double.parseDouble(months)<=0){
			returnvalue=days+" Days";
		}
		else if(Double.parseDouble(months)==1 && Double.parseDouble(days)==0){
			returnvalue=months+" Month";
		}
		else if(Double.parseDouble(months)>0 && Double.parseDouble(days)==0){
			
				returnvalue=months+" Months";
		}
		else if(Double.parseDouble(months)==1 && Double.parseDouble(days)==1){
			returnvalue=months+" Month "+days+" Day";
		}
		else{
			returnvalue=months+" Months "+days+" Days";
		}*/
		returnvalue=days;
		return returnvalue;
	}
	
	public  java.sql.Date getSqlDate(Object value)
    {
       java.sql.Date dtvalue=null;
       try
       {
        java.util.Date utilDate=null;
          if(value instanceof java.util.Date)
           utilDate=(java.util.Date) value;
          else  if(value instanceof java.sql.Date)
          {
           dtvalue=(java.sql.Date) value;
           return dtvalue; 
          }
          else
         utilDate=parseDate((String)value);
           dtvalue=new java.sql.Date(utilDate.getTime());
       }catch(Exception e){
    	   e.printStackTrace();
    	   
       }
        return dtvalue;
    }
 

    public  java.util.Date parseDate(Object ostr_date) throws ParseException, java.text.ParseException
    {
         DateFormat formatter ;
         //Date date = null ;
         java.util.Date date =null;
         String str_date=null;
         formatter = new SimpleDateFormat("dd/MM/yyyy");
         formatter.setLenient(false);
         if (ostr_date!=null)
         {
        if (ostr_date instanceof java.sql.Date)
        {
         date =new java.util.Date(((java.sql.Date)ostr_date).getTime());
        }
        if (ostr_date instanceof java.util.Date)
        {
         date =(java.util.Date)ostr_date;
        }
        else
        {
          str_date=String.valueOf(ostr_date);
          if (str_date.length()>4 && (str_date.indexOf('/')==4 || str_date.indexOf('.')==4 || str_date.indexOf('-')==4))
          {
           str_date=(str_date.substring(8,10)+"/"+str_date.substring(5,7) +"/"+ str_date.substring(0,4));
          }
          if (str_date!=null && !str_date.isEmpty())
              date = formatter.parse(str_date);                     
          }
        }
        return date;
    }
    
    public String checkFuelName(Connection conn,String fuel) throws SQLException{
		String fuelname="";
		try{
		Statement stmtfuelcheck=conn.createStatement();
		String strfuelcheck="select CASE WHEN "+fuel+"=0.000 THEN 'Level 0/8' WHEN "+fuel+"=0.125 THEN 'Level 1/8' WHEN "+fuel+"=0.250 THEN 'Level 2/8'"+
				" WHEN "+fuel+"=0.375 THEN 'Level 3/8' WHEN "+fuel+"=0.500 THEN 'Level 4/8' WHEN "+fuel+"=0.625 THEN 'Level 5/8'  WHEN "+fuel+"=0.750"+
				" THEN 'Level 6/8' WHEN "+fuel+"=0.875 THEN 'Level 7/8' WHEN "+fuel+"=1.000 THEN 'Level 8/8'  END as 'fuel'";
		ResultSet rsfuelcheck=stmtfuelcheck.executeQuery(strfuelcheck);
		while(rsfuelcheck.next()){
			fuelname=rsfuelcheck.getString("fuel");
		}
		}
		catch(Exception e){
			conn.close();
			return fuelname;
		}
		return fuelname;
	}
    
    
    public  double Round(double value,int deci) throws SQLException
    {
    	Connection conn=null;
    	try{
    		
    		conn=ClsConnection.getMyConnection();
    		Statement stmt=conn.createStatement();
    		String compid="1";
    		String str="select cvalue from my_system where comp_id="+compid+" and codeno='amtdec'";
    		ResultSet rs=stmt.executeQuery(str);
    		while(rs.next()){
    			deci=rs.getInt("cvalue");
    		}
    		BigDecimal bd = new BigDecimal(value).setScale(deci, RoundingMode.HALF_UP);
    	      value = bd.doubleValue();
    	      stmt.close();
    	      conn.close();
    	      
    	}
    	catch(Exception e){
    		e.printStackTrace();
    		conn.close();
    	}
    	finally{
    		conn.close();
    	}
    	return value; 
   }
    
    public  double sqlRound(double value,int deci) throws SQLException
    {
    	Connection conn=null;
    	double roundvalue=0.0;
    	try{
    		
    		conn=ClsConnection.getMyConnection();
    		Statement stmt=conn.createStatement();
    		String str="select round("+value+","+deci+") roundvalue";
    		ResultSet rs=stmt.executeQuery(str);
    		while(rs.next()){
    			roundvalue=rs.getDouble("roundvalue");
    		}

    		stmt.close();
    	      conn.close();
    	      
    	}
    	catch(Exception e){
    		e.printStackTrace();
    		conn.close();
    	}
    	finally{
    		conn.close();
    	}
    	return roundvalue; 
   }
    
    public String getBIBPrintPath(String dtype) throws SQLException{
	     
		Connection conn=null;
	    String path="";
	     
	     try{
	        conn=ClsConnection.getMyConnection();
	        Statement stmtpath=conn.createStatement();
	      
	        String sqlpath="select printpath from gl_bibd where dtype='"+dtype+"'";
	        ResultSet rspath=stmtpath.executeQuery(sqlpath);
	      
	        while(rspath.next()){
	           path=rspath.getString("printpath");
	        }
	        
	        stmtpath.close();
	        conn.close();
	     }
	     catch(Exception e){
	         e.printStackTrace();
	         conn.close();
	         return "fail";
	     }
	     return path;
	    }
    
    public String getBIBPrintPath1(String dtype) throws SQLException{
	     
		Connection conn=null;
	    String path="";
	     
	     try{
	        conn=ClsConnection.getMyConnection();
	        Statement stmtpath=conn.createStatement();
	      
	        String sqlpath="select printpath1 from gl_bibd where dtype='"+dtype+"'";
	        ResultSet rspath=stmtpath.executeQuery(sqlpath);
	      
	        while(rspath.next()){
	           path=rspath.getString("printpath1");
	        }
	        
	        stmtpath.close();
	        conn.close();
	     }
	     catch(Exception e){
	         e.printStackTrace();
	         conn.close();
	         return "fail";
	     }
	     return path;
	    }
    
    public  String getPrintPath(String dtype) throws SQLException{
	     
		Connection conn=null;
	    String path="";
	     
	     try{
	        conn=ClsConnection.getMyConnection();
	        Statement stmtpath=conn.createStatement();
	      
	        String sqlpath="select printpath from my_menu where doc_type='"+dtype+"'";
	        ResultSet rspath=stmtpath.executeQuery(sqlpath);
	      
	        while(rspath.next()){
	           path=rspath.getString("printpath");
	        }
	        
	        stmtpath.close();
	        conn.close();
	     }
	     catch(Exception e){
	         e.printStackTrace();
	         conn.close();
	         return "fail";
	     }
	     return path;
	    }
    
	public  String getPrintPath2(String dtype) throws SQLException{
        
        Connection conn=null;
           String path2="";
           // System.out.println("---------------------------------");
            try{
               conn=ClsConnection.getMyConnection();
               Statement stmtpath=conn.createStatement();
             
               String sqlpath="select printpath2 from my_menu where doc_type='"+dtype+"'";
              // System.out.println("sqlpath---------------"+sqlpath);
               ResultSet rspath=stmtpath.executeQuery(sqlpath);
             
               while(rspath.next()){
                  path2=rspath.getString("printpath2");
                  
                  //System.out.println("path------"+path2);
                  
               }
               
               stmtpath.close();
               conn.close();
            }
            catch(Exception e){
                e.printStackTrace();
                conn.close();
                return "fail";
            }
            return path2;
           }
		   
		   public  JSONArray convertToEXCEL(ResultSet resultSet)
		   throws Exception {
//		   System.out.println("==== "+resultSet);
		   JSONArray jsonArray = new JSONArray();
//		   resultSet.first();
		   while (resultSet.next()) {
			 //  System.out.println("===== TOT=== "+resultSet.getMetaData().getColumnCount());
		   int total_rows = resultSet.getMetaData().getColumnCount();
		   
		   JSONObject obj = new JSONObject();
		   for (int i = 0; i < total_rows; i++) {
			//   System.out.println("===="+resultSet.getMetaData().getColumnLabel(i + 1)+"===="+ ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
		     // obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
		     obj.put(resultSet.getMetaData().getColumnLabel(i + 1), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ")));
		   }
		   jsonArray.add(obj);
		   }
//		   System.out.println("js=="+jsonArray);
		   return jsonArray;
		   }
    
		/*For Cheque Line Breaker[Amount in Words]*/
		public  String addLinebreaks(String input, double maxLineLength) {

	 	StringTokenizer tok = new StringTokenizer(input, " ");
	    StringBuilder output = new StringBuilder(input.length());
	    int lineLen = 0;
	    while (tok.hasMoreTokens()) {
	        String word = tok.nextToken()+" ";

	        if (lineLen + word.length() > maxLineLength) {
	            output.append("::"+"\n");
	            lineLen = 0;
	        }
	        output.append(word);
	        lineLen += word.length();
	    }
	        return output.toString();
	    }
		/*For Cheque Line Breaker[Amount in Words] Ends*/
		
		/*Finace Reports Case Statement for Voc_no in Doc_no*/
		public  String getFinanceVocTablesCase(Connection conn) throws SQLException{
    	String vocCase="CASE";
    	
		try{
			Statement stmtFinace=conn.createStatement();
		
			String strvoctable="select alias_name,dtype from win_tbldet where vocno_status=1";
			ResultSet rsvocjoins=stmtFinace.executeQuery(strvoctable);
			
			String aliasName="";String vocDtypeName="";
			
			while(rsvocjoins.next()){
				aliasName=rsvocjoins.getString("alias_name");
				vocDtypeName=rsvocjoins.getString("dtype");
				
				vocCase+=" WHEN a.transType in ("+vocDtypeName+") THEN "+aliasName+".voc_no";
			}
			vocCase+=" ELSE a.transno END AS 'transno',";
			
		stmtFinace.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return vocCase;
		}
		return vocCase;
	}
    /*Finace Reports Case Statement for Voc_no in Doc_no Ends*/
	
	/*Finace Reports Joins for Voc_no in Doc_no*/
		public  String getFinanceVocTablesJoins(Connection conn) throws SQLException{
	    	String vocJoins="";
	    	
			try{
				Statement stmtFinace=conn.createStatement();
			
				String strvoctable="select voc_joins from win_tbldet where vocno_status=1";
				ResultSet rsvocjoins=stmtFinace.executeQuery(strvoctable);
				
				while(rsvocjoins.next()){
					
					vocJoins+=" "+rsvocjoins.getString("voc_joins");
				}
			
			stmtFinace.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				return vocJoins;
			}
			return vocJoins;
		}
		 public  JSONObject JVTotalCheck(Connection conn, int trno) throws SQLException {  
    	JSONObject validobj = new JSONObject();
    	int val = 0;
    	try{
    		Statement stmt = conn.createStatement();
    		double total = 0.0; 
    		String acno="";
    		String sql0="select coalesce(ldramount,0) as jvtotal,id,dramount,acno from my_jvtran where tr_no="+trno+"";
			ResultSet rs0 = stmt.executeQuery(sql0);
			while (rs0.next()) {
			    System.out.println(rs0.getDouble("dramount")+" = JV LINE AMOUNT = "+rs0.getDouble("jvtotal"));
			} 
    		String sql1 = "select sum(coalesce(ldramount,0)) as jvtotal from my_jvtran where tr_no="+trno+"";
    		//System.out.println("sql1==="+sql1);
			ResultSet rs1 = stmt.executeQuery(sql1);
			while (rs1.next()) {
			    total = rs1.getDouble("jvtotal");
			}
			
    		if(total != 0) {
    			validobj.put("value", 1);
    			validobj.put("validmsg", "Total is not zero");
    			val = 1;
    			return validobj;
    		}
    		
    		String sql2="select * from my_jvtran jv left join my_head h on jv.acno=h.doc_no where h.rate IS NULL and jv.tr_no="+trno+"";   
    		//System.out.println("sql2==="+sql2);
			ResultSet rs2 = stmt.executeQuery(sql2);
			if (rs2.next()) {
				validobj.put("value", 2);
    			validobj.put("validmsg", "Rate is missing for some accounts");
    			val = 1;
    			return validobj;
			}
    		
			String sql3="select * from my_jvtran jv left join my_head h on jv.acno=h.doc_no where h.curid IS NULL and jv.tr_no="+trno+"";
			//System.out.println("sql3==="+sql3);
			ResultSet rs3 = stmt.executeQuery(sql3);
			if (rs3.next()) {
				validobj.put("value", 3);
    			validobj.put("validmsg", "Currency is missing for some accounts");
    			val = 1;
    			return validobj;
			}
			
			String sql4="select * from my_jvtran where dramount>0 and id<0 and tr_no="+trno+"";
			//System.out.println("sql4==="+sql4);   
			ResultSet rs4 = stmt.executeQuery(sql4);
			if (rs4.next()) {
				validobj.put("value", 4);
    			validobj.put("validmsg", "Amount and sign not matching");
    			val = 1;
    			return validobj;
			}
			
			String sql5="select * from my_jvtran where dramount<0 and id>0 and tr_no="+trno+"";
			//System.out.println("sql5==="+sql5);
			ResultSet rs5 = stmt.executeQuery(sql5);
			if (rs5.next()) {
				validobj.put("value", 5);
    			validobj.put("validmsg", "Amount and sign not matching");
    			val = 1;
    			return validobj;
			}
			
			String sql6="select TR_NO,date,DTYPE,dramount,ldramount from my_jvtran where rate=1 and dramount!=ldramount and tr_no="+trno+"";
			//System.out.println("sql6==="+sql6);
			ResultSet rs6 = stmt.executeQuery(sql6);
			if (rs6.next()) {
				//System.out.println(rs6.getString("dramount")+"=6="+rs6.getString("ldramount"));
				validobj.put("value", 6);
    			validobj.put("validmsg", "Amount mistmach");
    			val = 1;
    			return validobj;
			}
			
			if(val==0) {
				validobj.put("value", 0);  
    			validobj.put("validmsg", "");
    			//System.out.println("validobj=="+validobj);
    			return validobj;
			}
			
    	      stmt.close();
    	}
    	catch(Exception e){
    		e.printStackTrace();
    		conn.close();
    	}
    	return validobj; 
   }
		/*public  String getFinanceVocTablesJoins(Connection conn) throws SQLException{
    	String vocJoins="";
    	
		try{
			Statement stmtFinace=conn.createStatement();
		
			String strvoctable="select mstTable,alias_name,dtype from win_tbldet where vocno_status=1";
			ResultSet rsvocjoins=stmtFinace.executeQuery(strvoctable);
			
			String vocTableJoins="";String aliasName="";String vocDtypeName="";
			
			while(rsvocjoins.next()){
				vocTableJoins=rsvocjoins.getString("mstTable");
				aliasName=rsvocjoins.getString("alias_name");
				vocDtypeName=rsvocjoins.getString("dtype");
				
				vocJoins+=" left join "+vocTableJoins+" "+aliasName+" on a.transno="+aliasName+".doc_no and a.transType in ("+vocDtypeName+")";
			}
		
		stmtFinace.close();
		}
		catch(Exception e){
			conn.close();
			return vocJoins;
		}
		return vocJoins;
	}*/
	/*Finace Reports Joins for Voc_no in Doc_no Ends*/




	
}
