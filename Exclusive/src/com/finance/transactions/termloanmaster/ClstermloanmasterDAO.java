package com.finance.transactions.termloanmaster;



import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.transactions.securitycheque.ClsSecurityChequeDAO;
import com.finance.transactions.unclearedchequepayment.ClsUnclearedChequePaymentDAO;
public class ClstermloanmasterDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	Connection conn;
	ClsUnclearedChequePaymentDAO unclearedChequePayDAO= new ClsUnclearedChequePaymentDAO();	
	ClsSecurityChequeDAO securityChqDAO= new ClsSecurityChequeDAO();
	 
 
	
 
	public int postingupdate(Date deldate,ArrayList<String> descarray, HttpServletRequest request,HttpSession session, double pricetottal,
			String venderaccount,int docno, String vendercurr, double vendorrate, Date invDate, String invno) throws SQLException {
	
		try
		{
		
			
			
			
			
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
 
			
			
		   	Statement stmt = conn.createStatement(); 	
		   	
		   	

			     
			     
			        int tranno=0;
					String dates="";
					String trsql="SELECT tr_no,date FROM  gl_termloanm where doc_no='"+docno+"' ";	
				
					ResultSet tass = stmt.executeQuery (trsql);
					
					if (tass.next()) {
				
						tranno=tass.getInt("tr_no");		
						dates=tass.getString("date");
				     }
					
					 String upsqls2="update my_jvtran set status=3  where tr_no='"+tranno+"'";
					 stmt.executeUpdate(upsqls2);
					 
					 
					 
 
				String sqlupdates="update gl_termloanm set psgstatus=1,loanentrydate='"+invDate+"' where doc_no='"+docno+"' ";	
			//	System.out.println("-------sqlupdates-"+sqlupdates);	
				
					int lastval=stmt.executeUpdate(sqlupdates);
					
					if(lastval<=0)
					{
						conn.close();
						return 0;
					}
								
			     
		 
			
			if(docno>0)
			{
			conn.commit();
			 stmt.close();
				conn.close(); 
				return 1;
			}
		
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
		return 0;
	}
		
		
		return 0;
	}
	
	public int detupdate(Date sqlStartDate,String formdetailcode, String dealno, int docno1, Date sqldetDate, String secchaqueno, String nameincheque,
			String txtdescription, int calcumethod, int finaccdocno,
			int banckaccdocno, int interestaccdocno, int loanaccdocno,
			int paymentmethod, BigDecimal downpaymet, BigDecimal loanamount,
			BigDecimal chqamount, ArrayList<String> descarray,
			HttpServletRequest request, double percentage, int installmaent,HttpSession session, String bankcurr, String inertcurr, String loancurr, 
			double bankrate, double interrate, double loanrate, Date sqluptoDate,String vehdesc) throws SQLException {
		
		
	 
		
		try
		{
			int docno=0;
			 
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		
		CallableStatement stmtvehpurchase= conn.prepareCall("{call termloanDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		stmtvehpurchase.setDate(1,sqldetDate);
		stmtvehpurchase.setString(2,secchaqueno);
		stmtvehpurchase.setString(3,nameincheque);
		stmtvehpurchase.setString(4,txtdescription);
		stmtvehpurchase.setInt(5,calcumethod);
		stmtvehpurchase.setInt(6,finaccdocno);
		stmtvehpurchase.setInt(7,banckaccdocno);
		stmtvehpurchase.setInt(8,interestaccdocno);
		stmtvehpurchase.setInt(9,loanaccdocno);
		stmtvehpurchase.setInt(10,paymentmethod);
		stmtvehpurchase.setBigDecimal(11,downpaymet);
		stmtvehpurchase.setBigDecimal(12,loanamount);
		stmtvehpurchase.setBigDecimal(13,chqamount);
	 	stmtvehpurchase.setDouble(14,percentage);
		stmtvehpurchase.setInt(15,installmaent);
		stmtvehpurchase.setDate(16,sqluptoDate);
		stmtvehpurchase.setString(17,dealno);
		stmtvehpurchase.setDate(18,sqlStartDate);
		stmtvehpurchase.setString(19,vehdesc);
		stmtvehpurchase.setString(20,session.getAttribute("USERID").toString());
		stmtvehpurchase.setString(21,session.getAttribute("BRANCHID").toString());
		stmtvehpurchase.setString(22,formdetailcode);
		stmtvehpurchase.registerOutParameter(23, java.sql.Types.INTEGER);
		stmtvehpurchase.registerOutParameter(24, java.sql.Types.INTEGER);
		stmtvehpurchase.executeQuery();
		docno=stmtvehpurchase.getInt("docNo");
		int vocno=stmtvehpurchase.getInt("vocNo");	
		request.setAttribute("vocno", vocno);
		if(docno<=0)
		{
			conn.close();
			return 0;
			
		}
		 
	 
		
		  Calendar now = Calendar.getInstance();
		  Date docdate = ClsCommon.changeStringtoSqlDate(now.get(Calendar.DATE)+"."+(now.get(Calendar.MONTH) + 1)+"."+now.get(Calendar.YEAR));
	     
		  double chqamounts = chqamount.doubleValue();
		  
		int val1=securityChqDAO.insert(docdate,"SEC","GL",loanaccdocno,banckaccdocno,secchaqueno,sqluptoDate,"0",docdate,"1",chqamounts,vehdesc,"",session,"A");
		
		if(val1<=0)
		{
			conn.close();
			return 0;
			
		}

 
		for(int i=0;i< descarray.size();i++){
	    	
		     String[] vehpurreqarray=descarray.get(i).split("::");
			 
		     if(!(vehpurreqarray[1].trim().equalsIgnoreCase("undefined")|| vehpurreqarray[1].trim().equalsIgnoreCase("NaN")||vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()))
		     {
		    	
		    	 
		 
		    	 
		    	 String date =""+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:vehpurreqarray[1].trim())+"";
		    	 
		    	 Date chedate= ClsCommon.changeStringtoSqlDate(date); 
		    	 
		    	 String amounts=""+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"";
		    	 
		         double totamount=Double.parseDouble(amounts);
		         
	    	     String interstamounts=""+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")||vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"";
		    	 
		         double interstamount=Double.parseDouble(interstamounts);
		         
		         String txtinterst=""+chedate+" "+"Interest Amount is"+" "+interstamounts;
		         
		         double baseintamt=interstamount*interrate;
		         
		    	 
		 	     String prinamounts=""+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")||vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"";
		    	 
		         double prinamount=Double.parseDouble(prinamounts);
		         String txtprinci=""+chedate+" "+"Principal Amount is"+" "+prinamounts;
		         
		         
		         double baseprincamt=prinamount*loanrate;
		         
		         double bankamount=totamount*-1;
		         
		         double basebankamount=totamount*bankrate*-1;
		         
		         String txtbank=""+chedate+" "+"Amount is"+" "+"-"+amounts;
		         
		         String chqnos =""+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"";
		         
		      
		            
		           ArrayList <String> unclearedchequepaymentarray= new ArrayList<String>();
		       	// bank  array      		
					unclearedchequepaymentarray.add(banckaccdocno+"::"+bankcurr+"::"+bankrate+"::false::"+bankamount+"::"+txtbank+"::"+basebankamount+"::0::0::0");
					// bank  for zero      		
					unclearedchequepaymentarray.add("0::0::0::0::0::0::0::0::0::0");
		    // interest array      
					unclearedchequepaymentarray.add(interestaccdocno+"::"+inertcurr+"::"+interrate+"::true::"+interstamount+"::"+txtinterst+"::"+baseintamt+"::0::0::0");
			// loan  array      		
					unclearedchequepaymentarray.add(loanaccdocno+"::"+loancurr+"::"+loanrate+"::true::"+prinamount+"::"+txtprinci+"::"+baseprincamt+"::0::0::0");
					
				 

					int val=unclearedChequePayDAO.insert(docdate,"UCP",formdetailcode+""+docno,bankrate,chedate,chqnos,nameincheque,0,txtdescription,totamount,0,unclearedchequepaymentarray,session,request,"A");
			    	 
			    	 
		            
					if(val<=0)
					{
						conn.close();
						return 0;
						
					}
		
			     String sql="INSERT INTO gl_termloandetd(sr_no,pramt,date,intstamt,totamt,chqno,rdocno,bpvno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(vehpurreqarray[0].trim().equalsIgnoreCase("undefined") || vehpurreqarray[0].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[0].trim().equalsIgnoreCase("")|| vehpurreqarray[0].isEmpty()?0:vehpurreqarray[0].trim())+"',"
					       + "'"+(vehpurreqarray[1].trim().equalsIgnoreCase("undefined") || vehpurreqarray[1].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[1].trim().equalsIgnoreCase("")|| vehpurreqarray[1].isEmpty()?0:ClsCommon.changeStringtoSqlDate(vehpurreqarray[1].trim()))+"',"
					       + "'"+(vehpurreqarray[2].trim().equalsIgnoreCase("undefined") || vehpurreqarray[2].trim().equalsIgnoreCase("NaN")|| vehpurreqarray[2].trim().equalsIgnoreCase("")|| vehpurreqarray[2].isEmpty()?0:vehpurreqarray[2].trim())+"',"
					       + "'"+(vehpurreqarray[3].trim().equalsIgnoreCase("undefined") || vehpurreqarray[3].trim().equalsIgnoreCase("NaN")||vehpurreqarray[3].trim().equalsIgnoreCase("")|| vehpurreqarray[3].isEmpty()?0:vehpurreqarray[3].trim())+"',"
					       + "'"+(vehpurreqarray[4].trim().equalsIgnoreCase("undefined") || vehpurreqarray[4].trim().equalsIgnoreCase("NaN")||vehpurreqarray[4].trim().equalsIgnoreCase("")|| vehpurreqarray[4].isEmpty()?0:vehpurreqarray[4].trim())+"',"
					       +"'"+docno+"','"+val+"')";
			     int resultSet3 = stmtvehpurchase.executeUpdate(sql);
				    
			     if(resultSet3<=0)
					{
						conn.close();
						return 0;
						
					}
		    	 
		    	 
		     }
		 }
		
		
		if (docno > 0) {
			conn.commit();
			stmtvehpurchase.close();
			conn.close();
			return docno;
		}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
			return 0;
		}
		return 0;
			
			
			 
		
		
	}
	 
	
	 
	public  JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String currency,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
                     if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and c.code like '%"+currency+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmtCPV = conn.createStatement ();
          /*   String sql="select t.doc_no,t.account,t.description,c.code curr from my_head t,"
               + "(select curId from my_brch where doc_no=  '"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
               + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') ";*/
   
    String  sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
            + "a.dtype='VND' and t.atype='AP' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
            + "from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
             
   // System.out.println("sql===="+sql);
    
            /* String sql=" select (@i:=@i+1) recno,t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,a1.cldocno,if(a1.per_mob=0,a1.per_tel,a1.per_mob) mobile from my_head t,my_acbook a1, "
            	        + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
            	        + "and t.cldocno=a1.cldocno and a1.dtype='VND' and t.atype='AP' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
            	        + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')";*/
             
             
          //  System.out.println("==============="+sql); 
    ResultSet resultSet = stmtCPV.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmtCPV.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	 
	 
	public  JSONArray searchmaster(HttpSession session,String docnoss,String desc,String datess,String aa) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
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
	    String brcid=session.getAttribute("BRANCHID").toString();
	    java.sql.Date  sqlStartDate = null;
	    
	  //  System.out.println("====datess======="+datess);
	    
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
    	{
    	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
    	}
    	
    	
	    
		String sqltest="";
	    
	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.voc_no like '%"+docnoss+"%'";
    	}
    	 
    	if((!(desc.equalsIgnoreCase(""))) && (!(desc.equalsIgnoreCase("NA")))){
    		sqltest=sqltest+" and vo.desc1 like '%"+desc+"%'";
    	}
    	 
    	
    	if(!(sqlStartDate==null)){
    		sqltest=sqltest+" and vo.date='"+sqlStartDate+"'";
    	} 
    	Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{
				
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("  select convert(coalesce(vo.tr_no,'0'),char(30)) tr_no,vo.voc_no,vo.doc_no,vo.date, vo.desc1,vo.loanentrydate "
	        			+ " from gl_termloanm vo  where vo.status=3 and vo.brhid='"+brcid+"' "+sqltest );
	 
	        //	System.out.println("-----------"+pySql);
	        	
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			}
			conn.close();
			 return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}


	public  JSONArray bankaccountsDetails(HttpSession session,String accountno,String accountname,String currency,String check) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       

		        
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		 
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
		            String company = session.getAttribute("COMPANYID").toString();
		            String den= "";
		            
		            
		            
		          String sqltest="";
		          String sql="";
		          
		          if(check.equalsIgnoreCase("bankaac"))
		        	  
		          {
		        	  
		        	  sqltest=sqltest+" and den=305 ";  
		          }
		          
		         
		          if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		              sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		          }
		          if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		          }
		          if(!(currency.equalsIgnoreCase("0")) && !(currency.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and c.code like '%"+currency+"%'";
		                 }
		          
		        //  if(check.equalsIgnoreCase("1")){
		          
		          if(check.equalsIgnoreCase("bankaac")||check.equalsIgnoreCase("intrestacc")||check.equalsIgnoreCase("loanacc"))
		          {
		           
		          sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type from my_head t,"
		              + "(select curId from my_brch where doc_no='"+branch+"') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
		              + "and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'"+company+"') and t.brhid in(0,'"+branch+"') "+sqltest;
		              		
		       //   System.out.println("-------"+sql);    		
		                    
		  	/*	          sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.c_rate rate,c.type, from my_head t,"
		  		          		+ " (select curId from my_brch where doc_no=  '1') h,my_curr c,(select (@i:=0)) a where t.m_s=0 and t.atype='GL' "
		  		          		+ " and c.doc_no=if(t.lApply,h.curId,t.curId) and t.cmpid in(0,'01') and t.brhid in(0,'1') and den=305 "+sqltest;      */
		  		          
		              		
		          
		         // System.out.println("-------"+sql);
		          
		          
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		          }
		         stmt.close();
		         conn.close();
		         
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }
	public JSONArray rcpancesearch(HttpSession session,String accountno,String accountname,String check) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		         String sqltest="";
		        //  String sql="";
		          
		          if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		              sqltest=sqltest+" and account like '%"+accountno+"%'";
		          }
		          if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		           sqltest=sqltest+" and description like '%"+accountname+"%'";
		          }
		          
		          if(check.equalsIgnoreCase("1"))
		          {
		      
			        
		        String sql="select t.doc_no,t.account acc_no,t.description fname from my_head t where t.atype in ('GL','AP','AR') and  t.m_s=0 "+sqltest;;
		          
		           //   System.out.println("=========sql========"+sql);
		              
		              
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		          } 
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }
	public  JSONArray descriptionssss(String docno) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		       ///  sr_no     bpvno
	
		         String sql="select  d.sr_no, d.rdocno, DATE_FORMAT(d.date,'%d.%m.%Y') date, d.pramt priamount,d.intstamt interest, d.totamt amount,convert(coalesce(m.chqno,''),char(50)) chqno,d.bpvno  "
		         		+ " from gl_termloandetd d  left join my_unclrchqbm m on m.doc_no=d.bpvno where d.rdocno='"+docno+"'  and m.status<>7";
		         
		      //  System.out.println("-------------"+sql);
		         
		         ResultSet resultSet = stmt.executeQuery(sql);
		         
		         
		         
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		      
		      
		        return RESULTDATA;
		   }

	
	public  JSONArray exportdescription(String docno) throws SQLException {
        
		  JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null; 
		       
		      try {
		        
		         conn = ClsConnection.getMyConnection();
		         Statement stmt = conn.createStatement();
		       ///  sr_no     bpvno
	
		         String sql="select   (@cnt := @cnt + 1) sr_no,DATE_FORMAT(date,'%d.%m.%Y') date,round(pramt,2) priamount,round(intstamt,2) interest,(round(pramt,2)+round(intstamt,2)) amount,convert(coalesce(chqno,''),char(50)) chqno  "
		         		+ " from gl_tln_excel , (SELECT @cnt := 0) reno  where id='"+docno+"' ";
		         
		        //System.out.println("-------------"+sql);
		         
		         ResultSet resultSet = stmt.executeQuery(sql);
		         RESULTDATA=ClsCommon.convertToJSON(resultSet);
		         stmt.close();
		         conn.close();
		        
		   
		      }
		      catch(Exception e){
		        e.printStackTrace();
		        conn.close();
		      }
		        return RESULTDATA;
		   }

	 public  ClstermloanmasterBean getViewDetails(HttpSession session,int docNo) throws SQLException {
	    	
			
		 ClstermloanmasterBean masterBean = new ClstermloanmasterBean();
			Connection conn=null;
			try {
			  conn = ClsConnection.getMyConnection();
			Statement stmtCPV0 = conn.createStatement ();
			String branch = session.getAttribute("BRANCHID").toString();
			
			// gl_termloanm gl_termloandetm gl_termloandetd rpaccno returndate
			

    String sqls=" select (select restructure from gl_termloandetm where rdocno="+docNo+") restructure,vo.date,"
		+ " round(dt.dwnpyt,2) dwnpyt,dt.dealno, round(dt.loanamt,2) loanamt, dt.stdate, dt.perintst, dt.clcumtd,dt.noinstmt,dt.sectychqno, dt.chqname,"
		+ "round(dt.amt,2) chqamount, dt.pytmtd, dt.desc1,dt.returndate uptodate, "
		+ " hh.description finaccname,hh.account finaccid ,dt.rpaccno findocno,h1.description bankaccname,h1.account bankaccid,dt.bankaccno bankdocno, "
		+ "h2.description intstaccname,h2.account intstaccid,dt.intstaccno instdocno,h3.description loanaccname,h3.account loanaccid,dt.loanaccno loandocno "
		+ "    from gl_termloanm vo     left join gl_termloandetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
		+ "    left join my_head hh on hh.doc_no=dt.rpaccno left join my_head h1 on h1.doc_no=dt.bankaccno left join "
		+ "  my_head h2 on h2.doc_no=dt.intstaccno left join my_head h3 on h3.doc_no=dt.loanaccno    where vo.clstatus=1 and vo.status=3  and vo.brhid='"+branch+"' and vo.doc_no='"+docNo+"' ";
    
   // System.out.println("----------"+sqls);
			
			ResultSet resultSet = stmtCPV0.executeQuery(sqls);
	
	
			while (resultSet.next()) {
				
				masterBean.setRestructure(resultSet.getString("restructure"));
				masterBean.setJqxStartDate(resultSet.getString("stdate"));
				masterBean.setUptoDate(resultSet.getString("uptodate"));
				
				
				masterBean.setDownpayment(resultSet.getBigDecimal("dwnpyt"));
				masterBean.setLoanamount(resultSet.getBigDecimal("loanamt"));
				masterBean.setSecchaqueno(resultSet.getString("sectychqno"));
				masterBean.setNameincheque(resultSet.getString("chqname"));
				masterBean.setTxtdescription(resultSet.getString("desc1"));
				masterBean.setCalcumethod(resultSet.getInt("clcumtd"));
				masterBean.setDealno(resultSet.getString("dealno"));
				masterBean.setFinaccdocno(resultSet.getInt("findocno"));
				masterBean.setBanckaccdocno(resultSet.getInt("bankdocno"));
				masterBean.setInterestaccdocno(resultSet.getInt("instdocno"));
				masterBean.setLoanaccdocno(resultSet.getInt("loandocno"));
				
				masterBean.setPaymentmethod(resultSet.getInt("pytmtd"));
			
				masterBean.setChqamount(resultSet.getBigDecimal("chqamount"));
				
				

				masterBean.setFinanceaccid(resultSet.getString("finaccid"));
				masterBean.setFinanceaccname(resultSet.getString("finaccname"));
				masterBean. setBankaccid(resultSet.getString("bankaccid"));
				masterBean. setBankaccname(resultSet.getString("bankaccname"));
				masterBean.setInterestaccid(resultSet.getString("intstaccid")); 
				masterBean. setIntaccname(resultSet.getString("intstaccname"));
				masterBean. setLoanaccid(resultSet.getString("loanaccid"));
				masterBean.setLoanaccname(resultSet.getString("loanaccname"));
				
				masterBean.setPerinterest(resultSet.getDouble("perintst"));
				masterBean.setInstnos(resultSet.getInt("noinstmt"));
				
				masterBean.setInstnos(resultSet.getInt("noinstmt"));
				
				
				masterBean.setDetval(10);
				
				masterBean.setClstatus(1);
				
				 masterBean.setMasterstatus(1);
				
				//setDetval(10);
				//setClstatus
				
			}
				
		
				
			stmtCPV0.close();
			conn.close();
			}
			catch(Exception e){
				
			e.printStackTrace();
			conn.close();
			}
			
			return masterBean;
			}
	 
	 
	 
	 
	 
	 
	 
	 
	 
		
	 public  ClstermloanmasterBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClstermloanmasterBean bean = new ClstermloanmasterBean();
		  ClsAmountToWords c = new ClsAmountToWords();
		  Connection conn = null;
		try {
			

				 conn = ClsConnection.getMyConnection();
				Statement stmtprint = conn.createStatement ();
				String resql=("  select vo.voc_no,vo.doc_no,DATE_FORMAT(vo.date,'%d.%m.%Y') date,"
						+ " DATE_FORMAT(vo.loanentrydate,'%d.%m.%Y') purdate,vo.desc1 "
	        			+ " from gl_termloanm vo   where vo.doc_no='"+docno+"'" );
	 
			 
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   // cldatails
			    	   
			    	  /* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/
			    	   
			    	
			    	    bean.setLbldoc(pintrs.getInt("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	 
			    	    bean.setLbldesc1(pintrs.getString("desc1"));
			    	  
			    	    
			    	    bean.setLblpurchaseDate(pintrs.getString("purdate"));
			    	    
			    	   // setLbltotal(pintbean.getLbltotal());
			       }
				

			
				
			 
				
					stmtprint.close();
				
				 Statement stmtinvoice10 = conn.createStatement ();
				    String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_termloanm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	 
				    	   
				       } 
				       stmtinvoice10.close();
				       
						
						
						
						  ArrayList<String> arrdet=new ArrayList<String>();
							
							
							Statement stmti = conn.createStatement ();
						 
					
							 String sqldetgrid="select  d.sr_no, d.rdocno, DATE_FORMAT(d.date,'%d.%m.%Y') date,round(d.pramt,2) priamount,round(d.intstamt,2) interest, round(d.totamt,2) amount,convert(coalesce(m.chqno,''),char(50)) chqno,d.bpvno  "
						         		+ " from gl_termloandetd d  left join my_unclrchqbm m on m.doc_no=d.bpvno where d.rdocno='"+docno+"'  and m.status<>7 order by d.sr_no  ";
				//System.out.println("------------strSqldetail1----"+strSqldetail1);
						ResultSet rsdetailgrid=stmti.executeQuery(sqldetgrid);
						
						int rowcounts=1;
				
						while(rsdetailgrid.next()){

								String temp="";
							 
								 
								temp=rowcounts+"::"+rsdetailgrid.getString("date")+"::"+rsdetailgrid.getString("chqno")+"::"+rsdetailgrid.getString("priamount")+"::"+rsdetailgrid.getString("interest")+"::"+rsdetailgrid.getString("amount")+"::"+rsdetailgrid.getString("bpvno");

								arrdet.add(temp);
								rowcounts++;
				
						
							
					}
						
						
						
						
						
						request.setAttribute("detailsarr",arrdet); 
						stmti.close();
						
						//bean.setRowdatascount(rowcounts);
				       
						
						
						
						
					
						 
						 Statement stmttotal = conn.createStatement ();
						 
					
							String sqls11=("select  round(sum(d.pramt),2) priamount,round(sum(d.intstamt),2) interest, round(sum(d.totamt),2) amount \r\n" + 
									"  from gl_termloandetd d  left join my_unclrchqbm m on m.doc_no=d.bpvno where d.rdocno='"+docno+"' group  by d.rdocno ");
				//System.out.println("------------strSqldetail1----"+strSqldetail1);
						ResultSet rsdetail1=stmttotal.executeQuery(sqls11);
						
						 
				
						if(rsdetail1.next()){

							bean.setLblpricitotalamount(rsdetail1.getString("priamount"));
							bean.setLblinttotalamount(rsdetail1.getString("interest"));
							bean.setLbltotalgridamount(rsdetail1.getString("amount"));
							bean.setLbltotalint(rsdetail1.getString("interest"));
						
							
					                 }
						stmttotal.close();
						 
						
						
						
						

						
						/*gl_termloanm, gl_termloandetm ,gl_termloandetd;
						rpaccno returndate,loanentrydate
						
						*/
						
						
						
						Statement stmtCPV0 = conn.createStatement ();
					   

			    String sqls=" select vo.date,vo.loanentrydate purdate,"
					+ "   round(dt.loanamt,2) loanamt,DATE_FORMAT(dt.stdate,'%d.%m.%Y') stdate, round(dt.perintst,2) perintst, "
					+ " if(dt.clcumtd=1,'Flat Rate','Diminishing Rate') clcumtd,dt.noinstmt,dt.sectychqno, dt.chqname,"
					+ "round(dt.amt,2) chqamount, if(dt.pytmtd=1,'Cheque','Direct Debit') pytmtd, dt.desc1,DATE_FORMAT(dt.returndate,'%d.%m.%Y') uptodate, "
					+ " hh.description finaccname , hh.account finaccid,dt.rpaccno findocno,h1.description bankaccname,h1.account bankaccid,dt.bankaccno bankdocno, "
					+ "h2.description intstaccname,h2.account intstaccid,dt.intstaccno instdocno,h3.description loanaccname,h3.account loanaccid,dt.bankaccno loandocno "
					+ "    from gl_termloanm vo    left join gl_termloandetm dt on(vo.doc_no=dt.rdocno and vo.clstatus=1) "
					+ "   left join my_head hh on hh.doc_no=dt.rpaccno left join my_head h1 on h1.doc_no=dt.bankaccno left join "
					+ "  my_head h2 on h2.doc_no=dt.intstaccno left join my_head h3 on h3.doc_no=dt.loanaccno    where vo.clstatus=1  and vo.doc_no='"+docno+"' ";
			    
			  //  System.out.println("----------"+sqls);
			    
			    
			    
			    
			    
			    

						
						ResultSet resultSet1 = stmtCPV0.executeQuery(sqls);
				
				
						while (resultSet1.next()) {   
							bean.setFirstarray(1);
							bean.setLblstartdate(resultSet1.getString("stdate"));
							bean.setLbluptodate(resultSet1.getString("uptodate"));
							
							

							bean.setLblloanamt(resultSet1.getString("loanamt"));
							bean.setLblsecucqNo(resultSet1.getString("sectychqno"));
							bean.setLblnameinchq(resultSet1.getString("chqname"));
							bean.setLblDesc(resultSet1.getString("desc1"));
							
							bean.setLblcalcumethod(resultSet1.getString("clcumtd"));
							
						
							
							bean.setLblpayval(resultSet1.getString("pytmtd"));
							
						
							bean.setLblanamt(resultSet1.getString("chqamount"));
							
							//setLblfinacc setLblfinaccName setLblbankacc setLblbankaccName setLblintacc getLblintaccName getLblloanacc setLblloanaccName

							bean.setLblfinacc(resultSet1.getString("finaccid"));
							bean.setLblfinaccName(resultSet1.getString("finaccname"));
							bean.setLblbankacc(resultSet1.getString("bankaccid"));
							bean.setLblbankaccName(resultSet1.getString("bankaccname"));
							bean.setLblintacc(resultSet1.getString("intstaccid")); 
							bean.setLblintaccName(resultSet1.getString("intstaccname"));
							bean.setLblloanacc(resultSet1.getString("loanaccid"));
							bean.setLblloanaccName(resultSet1.getString("loanaccname"));
							
							bean.setLblperinterst(resultSet1.getString("perintst"));
							bean.setLblnoofinst(resultSet1.getString("noinstmt"));
							
						
							
							
						}
				       
						stmtCPV0.close();    
				       
				       
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	 
	 
	 
	 
		
		public  JSONArray journalVoucherGridReloading(HttpSession session,String docNo,String dtypes) throws SQLException {
	     
	        
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
	    conn = ClsConnection.getMyConnection();
	    Statement stmtJVT = conn.createStatement();
	  
	    String dtype="";
	    ResultSet resultSet1 = stmtJVT.executeQuery ("select dtype from gl_termloanm where tr_no='"+docNo+"' ");
	    if(resultSet1.next())
	    {
	    	dtype=resultSet1.getString("dtype");
	    }
	   
	   String sql= ("SELECT j.acno docno,j.description,j.curId currencyid,round(j.rate,2) rate,if(j.dramount>0,round(j.dramount*j.id,2),0) debit ,"
	     + "if(j.dramount<0,round(j.dramount*j.id,2),0) credit,round(j.ldramount*j.id,2) baseamount,j.ref_row sr_no, j.costtype,if(j.costcode=0,'',j.costcode) costcode,coalesce(c.costgroup,'') costgroup,t.atype type,"
	     + "t.account accounts,t.description accountname1,t.gr_type grtype,cr.type currencytype FROM my_jvtran j left join my_costunit c on j.costtype=c.costtype left join "
	     + "my_head t on j.acno=t.doc_no left join my_curr cr on cr.doc_no=j.curId WHERE j.dtype='"+dtype+"' and j.brhId='"+branch+"' and j.tr_no='"+docNo+"'");
	//  System.out.println("---------sql--"+sql);
	   ResultSet resultSet = stmtJVT.executeQuery (sql);
	  
	                
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    
	    stmtJVT.close();
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
