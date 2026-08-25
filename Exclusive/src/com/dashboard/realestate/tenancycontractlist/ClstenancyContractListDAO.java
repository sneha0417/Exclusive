package com.dashboard.realestate.tenancycontractlist;

import java.sql.Connection;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;

	import javax.servlet.http.HttpSession;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	import net.sf.json.JSONArray;

	public class ClstenancyContractListDAO {
		ClsConnection conobj= new ClsConnection();
		ClsCommon com=new ClsCommon();

		ClsConnection ClsConnection=new ClsConnection();
	 
		ClsCommon ClsCommon=new ClsCommon();
		
		public   JSONArray listsearch(String branch,String fromdate,String todate,String aa,String cldocno,String prdocno,String searchby) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();
		    
		    if(!aa.equalsIgnoreCase("yes"))
		    {
		    	return RESULTDATA;
		    }
		    
		   
	        
	/*        java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}
	*/
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
	    	
	     
	    	
	         
	     	if(!(cldocno.equalsIgnoreCase("undefined"))&&!(cldocno.equalsIgnoreCase(""))&&!(cldocno.equalsIgnoreCase("0")))
	     	{
	     		sqltest=sqltest+ " and m.cldocno='"+cldocno+"' ";
	     		
	     	}
	 
	        
	     	if(!(prdocno.equalsIgnoreCase("undefined"))&&!(prdocno.equalsIgnoreCase(""))&&!(prdocno.equalsIgnoreCase("0")))
	     	{
	     		sqltest=sqltest+ " and pm.doc_no='"+prdocno+"' ";
	     		
	     	}
	 
	     	if(!(searchby.equalsIgnoreCase("undefined"))&&!(searchby.equalsIgnoreCase(""))&&!(searchby.equalsIgnoreCase("0")))
	     	{
	     		if(searchby.equalsIgnoreCase("open"))
	     		{
	     		sqltest=sqltest+ " and m.clstatus=0 ";
	     		}
	     		else if(searchby.equalsIgnoreCase("close"))
	     		{
	     			sqltest=sqltest+ " and m.clstatus=1 ";	
	     		}
	     	else{
	     	
	     		
	     	}
		} 
	     	Connection conn = null;
	        
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stm = conn.createStatement ();     
			 
					 
					
					String sql=" select m.voc_no ,m.doc_no, m.date,m.ttype , m.cldocno,a.refname,pm.name pname,cc.amount,pc.pamount, "
							+ "  if(m.ttype=1,'Residence','Commercial') protype, if(m.Period=1,'Years','Months') Period, m.Period_no, m.Period_from, m.Period_to, m.not_Period  "
					+ " from rl_tncm  m  left join(select sum(amount) amount,rdocno from rl_tncterms group by rdocno) cc on cc.rdocno=m.doc_no left join(select sum(pamount) pamount,rdocno from rl_tncpayment group by rdocno) pc on pc.rdocno=m.doc_no "
					+" left join rl_propertymaster pm on pm.doc_no=m.prtype "
					+ " left join my_acbook a on a.acno=m.acno  where m.status=3  "+sqltest+" group by m.doc_no  ";
							
	            	      System.out.println("-----------"+sql);	
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
		
		public   JSONArray listsearchexcel(String branch,String fromdate,String todate,String aa,String cldocno,String prdocno,String searchby) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();
		    
		    if(!aa.equalsIgnoreCase("yes"))
		    {
		    	return RESULTDATA;
		    }
		    
		   
	        
	/*        java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}
	*/
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
	    	
	     
	    	
	         
	     	if(!(cldocno.equalsIgnoreCase("undefined"))&&!(cldocno.equalsIgnoreCase(""))&&!(cldocno.equalsIgnoreCase("0")))
	     	{
	     		sqltest=sqltest+ " and m.cldocno='"+cldocno+"' ";
	     		
	     	}
	 
	        
	     	if(!(prdocno.equalsIgnoreCase("undefined"))&&!(prdocno.equalsIgnoreCase(""))&&!(prdocno.equalsIgnoreCase("0")))
	     	{
	     		sqltest=sqltest+ " and pm.doc_no='"+prdocno+"' ";
	     		
	     	}
	 
	     	if(!(searchby.equalsIgnoreCase("undefined"))&&!(searchby.equalsIgnoreCase(""))&&!(searchby.equalsIgnoreCase("0")))
	     	{
	     		if(searchby.equalsIgnoreCase("open"))
	     		{
	     		sqltest=sqltest+ " and m.clstatus=0 ";
	     		}
	     		else if(searchby.equalsIgnoreCase("close"))
	     		{
	     			sqltest=sqltest+ " and m.clstatus=1 ";	
	     		}
	     	else{
	     	
	     		
	     	}
		} 
	     	Connection conn = null;
	        
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stm = conn.createStatement ();     
			 
					 
					
					String sql=" select m.voc_no 'Doc No' , m.date 'Date',a.refname 'Tenant',pm.name 'Property',cc.amount 'Amount' ,pc.pamount 'Payamount',"
							+ "  if(m.ttype=1,'Residence','Commercial') 'Type', if(m.Period=1,'Years','Months') 'Period', m.Period_no 'Period No', m.Period_from 'From', m.Period_to 'To', m.not_Period 'Not_Period' "
					+ " from rl_tncm  m  left join(select sum(amount) amount,rdocno from rl_tncterms group by rdocno) cc on cc.rdocno=m.doc_no left join(select sum(pamount) pamount,rdocno from rl_tncpayment group by rdocno) pc on pc.rdocno=m.doc_no "
					+" left join rl_propertymaster pm on pm.doc_no=m.prtype "
					+ " left join my_acbook a on a.acno=m.acno  where m.status=3  "+sqltest+" group by m.doc_no";
							
	            	      System.out.println("-----------"+sql);	
	            		   ResultSet resultSet = stm.executeQuery(sql);
	            		   RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
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
		
		
		
		public   JSONArray clientSrearch(HttpSession session,String sclname,String smob,String rno,String Contact) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			String brnchid=session.getAttribute("BRANCHID").toString();


			String sqltest="";

			if(!(sclname.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.refname like '%"+sclname+"%'";
			}
			if(!(smob.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.com_mob like '"+smob+"'";
			}
			if(!(rno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.cldocno like '"+rno+"%'";
			}
			if(!(Contact.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.contactperson like '"+Contact+"%'";
			}


			Connection conn =null;
			Statement stmtVeh7=null;

			try {
				conn = conobj.getMyConnection();
				stmtVeh7 = conn.createStatement ();  
				String str1Sql=("select m.cldocno,m.refname,m.com_mob,m.contactperson as contact from my_acbook m "
						+ " left join my_clcatm c on c.doc_no=m.catid  where m.dtype='CRM' and c.tenant=1 and m.status<>7  " +sqltest);
				System.out.println("=========="+str1Sql);
				ResultSet resultSet = stmtVeh7.executeQuery (str1Sql);
				RESULTDATA=com.convertToJSON(resultSet);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmtVeh7.close();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}

		public   JSONArray pmaterearch(HttpSession session,String docnoss,String own,String pname,String datess,String aa,String descriptions,String mob) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();
		    
		    if(!aa.equalsIgnoreCase("yes"))
		    {
		    	return RESULTDATA;
		    }
		    
		   
		    if(!aa.equalsIgnoreCase("yes"))
		    {
		    	return RESULTDATA;
		    }
		    
		    
		    java.sql.Date  sqlStartDate = null;
		  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
		      	{
		      	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		      	}
		      	
		      	
		  	    
		  		String sqltest="";
		  	    
		  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
		      		sqltest=sqltest+" and  m.voc_no like '%"+docnoss+"%'";
		      	}
		      	if((!(own.equalsIgnoreCase(""))) && (!(own.equalsIgnoreCase("NA")))){
		      		sqltest=sqltest+" and o.primary_owner like '%"+own+"%'  ";
		      	}
		      	if((!(pname.equalsIgnoreCase(""))) && (!(pname.equalsIgnoreCase("NA")))){
		      		sqltest=sqltest+" and m.name like '%"+pname+"%'";
		      	}
		      
		      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
		      		sqltest=sqltest+" and m.desc1 like '%"+descriptions+"%'";
		      	}
		  
		 
		      
		      	
		      	
		      	
		      	if(!(sqlStartDate==null)){
		      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		      	}
		    
		    Connection conn = null;
			try {
				conn = ClsConnection.getMyConnection();
				if(aa.equalsIgnoreCase("yes"))
				{	 
				
					Statement stmtmain = conn.createStatement (); 
					
		 
		        	
		        	 String pySql=(" select  m.doc_no, m.voc_no,  m.date, m.name,  o.primary_owner  owner,desc1,if(m.cnt_no>0,'RENTED','AVAILABLE') type,"
		        	 		+ " convert(if(m.cnt_no>0,DATE_ADD(cnt_date, INTERVAL 1 DAY),''),char(100)) adate "
		        	 		+ " from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid where m.status=3 and m.active=1   "+sqltest+" group by m.doc_no ");
		        	
		        	
		   
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
//			System.out.println(RESULTDATA);
		    return RESULTDATA;
		}
	}

