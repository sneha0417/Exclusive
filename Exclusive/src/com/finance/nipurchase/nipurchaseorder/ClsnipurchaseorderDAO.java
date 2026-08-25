package com.finance.nipurchase.nipurchaseorder;

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
 

 






import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
 
 

public class ClsnipurchaseorderDAO  {
	ClsConnection connDAO=new ClsConnection();
	
	
	ClsCommon commDAO=new ClsCommon();
	Connection conn;
		
	
	public int insert(Date sqlStartDate,Date purdeldate, String refno, String acctype,
			String accdoc, String puraccname, String cmbcurr, String currate,
			String delterms, String payterms, String purdesc,
			HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,HttpServletRequest request,int ptype) throws SQLException {
		
		try{
			int docno;
		
			 conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call nipurchaseorderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.registerOutParameter(15, java.sql.Types.INTEGER);
			stmtpurorder.registerOutParameter(16, java.sql.Types.INTEGER);
			stmtpurorder.setDate(1,sqlStartDate);
			stmtpurorder.setString(2,refno);
			stmtpurorder.setString(3,acctype);
			stmtpurorder.setString(4,accdoc);
		   	stmtpurorder.setString(5,cmbcurr);
			stmtpurorder.setString(6,currate);
			stmtpurorder.setString(7,delterms); 
			stmtpurorder.setString(8,payterms);
			stmtpurorder.setString(9,purdesc);
			stmtpurorder.setDate(10,purdeldate);
			stmtpurorder.setDouble(11,nettotal);
			stmtpurorder.setString(12,Formdetailcode);
			stmtpurorder.setString(13,session.getAttribute("USERID").toString());
			stmtpurorder.setString(14,session.getAttribute("BRANCHID").toString());
			
		//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
			
			stmtpurorder.setString(17,mode);
			stmtpurorder.executeQuery();
			docno=stmtpurorder.getInt("docNo");
			int vocno=stmtpurorder.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			//System.out.println("====vocno========"+vocno);
		
			if(docno<=0)
			{
				conn.close();
				return 0;
				
			}
			
			
			 Statement stmt = conn.createStatement ();
			  
			  String upsql="select method from gl_config where field_nme='tax'";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			    
			    int typedocval = 0;
			    if (resultSet.next()) {
			     
			    	typedocval=resultSet.getInt("method");
			    }		  
			    if(typedocval==0)
			    {
			    String upsql2="select method from gl_prdconfig where field_nme='tax'";
				   ResultSet resultSet2 = stmt.executeQuery(upsql2);
				   
				    if (resultSet2.next()) {
				    	 
				    	typedocval=resultSet2.getInt("method");
				    }
			    }
  	
			
		
			//System.out.println("sssssss"+session.getAttribute("USERID").toString());
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
			    	 
			    	 
		     String sql="INSERT INTO my_srvlpod(srno,qty,desc1,unitprice,total,discount,nettotal,nuprice,taxper,taxamount,nettaxamount,brhid,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
				       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
				       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
				       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
				       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
				        + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")|| typedocval==0||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
						       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")|| typedocval==0||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
						       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")|| typedocval==0||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
						       
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+docno+"')";
		  //   System.out.println("444444444"+sql);
				     int resultSet2 = stmtpurorder.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }
				     
				     }
			
			
			 
			   
			 
				 
				 double taxtotal=0;
			 
				 
			  
			 if(typedocval>0)
			 {
				 
					
				 Statement stmt12=conn.createStatement();
				 String sqlssss="select sum(taxamount)  taxamount,sum(nettaxamount) taxtotal from my_srvlpod where rdocno="+docno+" group by rdocno";
						 
						ResultSet rs111=stmt12.executeQuery(sqlssss) ;
				 if(rs111.first())
				 {
					 
					 
					 taxtotal=rs111.getDouble("taxtotal");
					 
					 
				 }
				 
				 
				 String updat="update  my_srvlpom set typeid="+ptype+",netamount="+taxtotal+" where doc_no="+docno+"  ";
				 
				 stmtpurorder.executeUpdate(updat);
				 
				   
				   
			 }
			 
				 
			
		//	System.out.println("sssssss"+docno);
			if (docno > 0) {
				conn.commit();
				stmtpurorder.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	   }
	


	public boolean edit(int docno,Date sqlStartDate,Date purdeldate, String refno, String acctype,
			String accdoc, String puraccname, String cmbcurr, String currate,
			String delterms, String payterms, String purdesc,
			HttpSession session, String mode,Double nettotal,ArrayList<String> descarray,String Formdetailcode,int ptype) throws SQLException {
		
		try{
			
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call nipurchaseorderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtpurorder.setDate(1,sqlStartDate);
			stmtpurorder.setString(2,refno);
			stmtpurorder.setString(3,acctype);
			stmtpurorder.setString(4,accdoc);
		   	stmtpurorder.setString(5,cmbcurr);
			stmtpurorder.setString(6,currate);
			stmtpurorder.setString(7,delterms);
			stmtpurorder.setString(8,payterms);
			stmtpurorder.setString(9,purdesc);
			stmtpurorder.setDate(10,purdeldate);
			stmtpurorder.setDouble(11,nettotal);
			stmtpurorder.setString(12,Formdetailcode);
			stmtpurorder.setString(13,session.getAttribute("USERID").toString());
			stmtpurorder.setString(14,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setInt(15,docno);
			stmtpurorder.setInt(16,0);
			stmtpurorder.setString(17,"E");
			int aaa=stmtpurorder.executeUpdate();
			docno=stmtpurorder.getInt("docNo");
			
			if(aaa<=0)
			{
				conn.close();
				return false;
				
			}
			
			  String delsql="Delete from my_srvlpod where rdocno="+docno+"  ";
			  stmtpurorder.executeUpdate(delsql);
			  
       Statement stmt = conn.createStatement ();
       int typedocval = 0;
			  String upsql="select method from gl_config where field_nme='tax'";
			   ResultSet resultSet = stmt.executeQuery(upsql);
			    
			   
			    if (resultSet.next()) {
			     
			    	typedocval=resultSet.getInt("method");
			    }		  
			    if(typedocval==0)
			    {
			    String upsql2="select method from gl_prdconfig where field_nme='tax'";
				   ResultSet resultSet2 = stmt.executeQuery(upsql2);
				   
				    if (resultSet2.next()) {
				    	 
				    	typedocval=resultSet2.getInt("method");
				    }
			    }
  	
			
			  
		//	System.out.println("aaaaaaaaaaaaaaaaa"+aaa);
			for(int i=0;i<descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			    
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
			  	   
			  	 
				     String sql="INSERT INTO my_srvlpod(srno,qty,desc1,unitprice,total,discount,nettotal,nuprice,taxper,taxamount,nettaxamount,brhid,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
						       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
						       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
						       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
						       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
						       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
						       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
						      + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")|| typedocval==0||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
						       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")|| typedocval==0||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
						       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")|| typedocval==0||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
						       
						       + "'"+session.getAttribute("BRANCHID").toString()+"',"
						       +"'"+docno+"')"; 	 
			    	 
			/*    	 
		     String sql="update  my_srvlpod set SRNO="+(i+1)+","
		     		   + "qty='"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "desc1='"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "unitprice='"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
				       + "total='"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
				       + "discount='"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
				       + "nettotal='"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
				       + "nuprice='"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"' where rdocno="+docno+"";
		   */
		   
		     int resultSet4 = stmtpurorder.executeUpdate(sql);
		 	if(resultSet4<=0)
			{
				conn.close();
				return false;
				
			} 
			     }
				     
				     }
			
			
			
			 
			 
			 double taxtotal=0;
		 
			 
		  
		 if(typedocval>0)
		 {
			 
				
			 Statement stmt12=conn.createStatement();
			 String sqlssss="select sum(taxamount)  taxamount,sum(nettaxamount) taxtotal from my_srvlpod where rdocno="+docno+" group by rdocno";
					 
					ResultSet rs111=stmt12.executeQuery(sqlssss) ;
			 if(rs111.first())
			 {
				 
				 
				 taxtotal=rs111.getDouble("taxtotal");
				 
				 
			 }
			 
			 
			 String updat="update  my_srvlpom set typeid="+ptype+",netamount="+taxtotal+" where doc_no="+docno+"  ";
			 
			 stmtpurorder.executeUpdate(updat);
			 
			   
			   
		 }
		 
			 
			
						
			if (aaa > 0) {
				conn.commit();
				stmtpurorder.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno,HttpSession session,String mode,String Formdetailcode) throws SQLException {
		try{
			 conn=connDAO.getMyConnection();
	
		//	conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call nipurchaseorderDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtpurorder.setDate(1,null);
			stmtpurorder.setString(2,null);
			stmtpurorder.setString(3,null);
			stmtpurorder.setString(4,null);
		   	stmtpurorder.setString(5,null);
			stmtpurorder.setString(6,null);
			stmtpurorder.setString(7,null);
			stmtpurorder.setString(8,null);
			stmtpurorder.setString(9,null);
			stmtpurorder.setDate(10,null);
			stmtpurorder.setDouble(11,0.0);
			stmtpurorder.setString(12,Formdetailcode);
			stmtpurorder.setString(13,session.getAttribute("USERID").toString());
			stmtpurorder.setString(14,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setInt(15,docno);
			stmtpurorder.setInt(16,0);
			stmtpurorder.setString(17,"D");
			
			int aaa=stmtpurorder.executeUpdate();
			
			
			
			if (aaa > 0) {
				//conn.commit();
				stmtpurorder.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}	
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
	
	
	public   JSONArray cashPaymentGridSearch(String type) throws SQLException {
      
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
  try {
     conn = connDAO.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
             
    ResultSet resultSet = stmtCPV.executeQuery ("select t.doc_no,t.account,t.description,c.code curr,c.doc_no curid,c.c_rate from my_head t left join my_curr c "
      + "on t.curid=c.doc_no where atype='"+type+"' and m_s=0 ");

    RESULTDATA=commDAO.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();

  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	
	
	public   JSONArray reloadnioreder(HttpSession session,String nidoc) throws SQLException {

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
	//    System.out.println("==========brcid======"+brcid);
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select srno,desc1 description,unitprice,qty,total,discount,nettotal,nuprice"
	        			+ ",taxper,taxamount taxperamt,nettaxamount taxamount from my_srvlpod  where rdocno='"+nidoc+"' ");
	     //  	System.out.println("========"+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
	public   JSONArray accountsDetailsTo() throws SQLException {
	     
/*        String branch = session.getAttribute("BRANCHID").toString();
     String company = session.getAttribute("COMPANYID").toString();*/
        JSONArray RESULTDATA=new JSONArray();
        Connection conn=null;
  try {
 conn = connDAO.getMyConnection();
    Statement stmtCPV = conn.createStatement ();
             
/*    String sql=("select (@i:=@i+1) recno,t.doc_no,t.account,t.description,c.code curr from my_head t,my_acbook a1, "
      + "my_curr c,(select curId from my_brch where doc_no= '"+branch+"') h, (select (@i:=0)) a where  a1.active=1 and t.m_s=0 and c.doc_no=t.curId "
      + "and t.cldocno=a1.cldocno and t.atype='"+dtype+"' and c.doc_no=if(a1.brhId=0 and a1.curId=0,h.curId,if(a1.curId=0,h.curId,a1.curid)) and "
      + "a1.cmpid in(0,'"+company+"') and a1.brhid in(0,'"+branch+"')");*/
    String sql="select description,doc_no,account from my_head where atype='AP' and m_s=0";
    ResultSet resultSet = stmtCPV.executeQuery (sql);
   //System.out.println("------------"+sql);
    RESULTDATA=commDAO.convertToJSON(resultSet);
    
    stmtCPV.close();
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }

	
	public   JSONArray mainsearch(HttpSession session,String docnoss,String accountss,String accnamess,String datess,String aa) throws SQLException {

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
	  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
	      	{
	      	sqlStartDate = commDAO.changeStringtoSqlDate(datess);
	      	}
	      	
	      	
	  	    
	  		String sqltest="";
	  	    
	  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
	      	}
	      	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
	      	}
	      	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
	      	}
	      
	      	
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}
	    
	    Connection conn = null;
		try {
			conn = connDAO.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{	
			
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select m.doc_no,m.voc_no,m.date,m.netamount,m.type,m.acno,m.refno,m.curid,m.rate,m.delterm,m.payterm,m.deldate,m.desc1,h.description,h.account "
	        			+ "from my_srvlpom m left join my_head h on h.doc_no=m.acno where m.status<>7 and m.brhid='"+brcid+"' "+sqltest );
	        //	System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
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
	
	
	
	public   ClsnipurchaseorderBean getPrint(int docno, HttpServletRequest request,HttpSession session,String brhid) throws SQLException {
		ClsnipurchaseorderBean bean = new ClsnipurchaseorderBean();
		  Connection conn = null;
		  String brcid=session.getAttribute("BRANCHID").toString();
		  
		   ClsAmountToWords c = new ClsAmountToWords();
		  
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtprint = conn.createStatement ();
	        	
				/*String resql=("select a.address,a.contactperson,m.voc_no,date_format(m.date,'%d-%m-%Y') date,round(m.netamount,2) netamount ,m.type,m.acno,m.delterm,"
						+ "coalesce(m.payterm,'') payterm,date_format(m.deldate,'%d-%m-%Y') deldate,coalesce(m.desc1,'') desc1,coalesce(h.description,'') description,"
						+ "h.account from my_srvlpom m left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='VND'  where m.DOC_NO="+docno+" ");
				*/
				
				String resql=("select date_format(date(d.edate),'%d-%m-%Y')udate,u.user_name,time_format(time(d.edate),'%H:%i')utime,coalesce(a.trnnumber,'') clienttrn,m.refno,coalesce(a.mail1,'') mail1,  coalesce(a.fax1,'') fax1,coalesce(a.per_mob,'') per_mob,a.address, "
						+ "coalesce(a.contactperson,'') contactperson,m.voc_no,date_format(m.date,'%d-%m-%Y') date, "
						+ "round(m.netamount,2) netamount ,m.type,m.acno,if(trim(m.delterm)!='',m.delterm,null)delterm,"
						+ "if(trim(m.payterm)!='',m.payterm,null)payterm,date_format(m.deldate,'%d-%m-%Y') deldate, if(trim(m.desc1)!='',m.desc1,null)desc1,coalesce(h.description,'') description,"
						+ "h.account from my_srvlpom m left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='VND' left join datalog d on m.doc_no=d.doc_no and d.dtype='NPO' left join my_user u on m.userid=u.doc_no  where m.DOC_NO="+docno+" ");
				
				
				System.out.println("----resql--"+resql);
				
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
			     
			       while(pintrs.next()){
			    	   bean.setLblclienttrn(pintrs.getString("clienttrn"));
			    	   bean.setAttn(pintrs.getString("contactperson"));
			    	   bean.setTel(pintrs.getString("per_mob"));
			    	   bean.setFax(pintrs.getString("fax1"));
			    	   bean.setEmail(pintrs.getString("mail1"));
			    	   bean.setRefno(pintrs.getString("refno"));
			    	   bean.setUname(pintrs.getString("user_name"));
			    	   bean.setUdate(pintrs.getString("udate"));
			    	   bean.setUtime(pintrs.getString("utime"));
			    	   bean.setLbldate(pintrs.getString("date"));
			    	   bean.setDocvals(pintrs.getString("voc_no"));
			    	   bean.setLblacno(pintrs.getString("account"));
			    	    //upper
			    	    bean.setLblacnoname(pintrs.getString("description"));
			    	    bean.setLbldeldate(pintrs.getString("deldate"));
			    	    bean.setLbldddtm(pintrs.getString("delterm"));
			    	    
			    	    bean.setLbldsc(pintrs.getString("desc1"));
			    	    bean.setLblpatms(pintrs.getString("payterm"));
			    	   
			    	    
			    	    /*bean.setLblnettotal(pintrs.getString("netamount"));*/
		
			    	 // c.convertAmountToWords(pintrs.getString("netamount"));
			    	  bean.setAmountinwords(c.convertAmountToWords(pintrs.getString("netamount")));
			    	  
			    	  bean.setAmountinwords(c.convertAmountToWords(pintrs.getString("netamount")));
			    	  
			    	  
			    	  bean.setVenaddress(pintrs.getString("address"));
			    	  bean.setContactperson(pintrs.getString("contactperson"));
			    	  
			    	  
		 
			    	  
			    	//  getVenaddress getContactperson getAmountinwords
			    	  
			    	    
			       }
				

				stmtprint.close(); 
				
				
				
				 Statement stmtinvoice10 = conn.createStatement ();
				 /*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from my_srvlpom r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";
*/  String  companysql="select coalesce(b.tinno,'') comptrn,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from my_srvlpom r inner join my_brch b on  "
		+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
		+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no="+docno+" ";

			         ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 
				    
				       while(resultsetcompany.next()){
				    	   bean.setLblcomptrn(resultsetcompany.getString("comptrn"));
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	 
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	  
				    	 
				    	   
				       } 
				       stmtinvoice10.close();
				       
				       
				     //----------//
						
						String strtotal="select round(sum(total),2) total,round(sum(discount),2) discount,round(sum(taxamount),2) taxamount,round(sum(nettaxamount),2) nettotal from my_srvlpod where rdocno="+docno+" group by rdocno;";				
						Statement stmttot=conn.createStatement();
						ResultSet rstot=stmttot.executeQuery(strtotal);
						while(rstot.next()){
							bean.setLbltotal(rstot.getString("total"));
							bean.setLbltaxtot(rstot.getString("taxamount"));
							bean.setLbldiscount(rstot.getString("discount"));
							bean.setLblnettotal(rstot.getString("nettotal"));
							
							ClsAmountToWords tow= new ClsAmountToWords();
							
							bean.setLbltotinword(tow.convertAmountToWords(rstot.getString("nettotal")));
							
						}
						stmttot.close();
				       
				       
				 ArrayList<String> arr=new ArrayList<String>();
						Statement stmtinvoice2 = conn.createStatement ();

						String strSqldetail="select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettaxamount,2) nettotal,d.nuprice,round(d.taxper,2) taxper,round(d.taxamount,2) taxamount"
								+" from my_srvlpod d  where d.rdocno="+docno+"  ";
					
			System.out.println("d-----------------d--"+strSqldetail);
					ResultSet rsdetail=stmtinvoice2.executeQuery(strSqldetail);
					
					int rowcount=1;
			
					while(rsdetail.next()){
		
							String temp="";
						
							temp=rowcount+"::"+rsdetail.getString("description")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("unitprice")+"::"+rsdetail.getString("total")+"::"+rsdetail.getString("discount")+"::"+rsdetail.getString("taxper")+"::"+rsdetail.getString("taxamount")+"::"+rsdetail.getString("nettotal") ;
		
							arr.add(temp);
							rowcount++;
			
					
						
				              }
					stmtinvoice2.close();  
					request.setAttribute("details",arr); 
					
					
					
					 String descQry=" select @i:=@i+1 as srno,a.* from  (select d.srno,d.desc1 description,round(d.unitprice,2) unitprice,"
				          		+ "  round(d.qty) qty,round(d.total,2) total,round(d.discount,2) discount,round(d.nettotal,2) nettotal,d.nuprice "
				        		+ "   from my_srvlpod d  where d.rdocno="+docno+"  ) a,(select @i:=0) r;";
				           
			          
			          String termsquery="select distinct @s:=@s+1 sr_no,rdocno,termsheader terms,m.doc_no, 0 priorno from "
			          		+ " (select distinct  tr.rdocno,termsid from my_trterms tr "
			          		+ "where  tr.dtype='NPO' and tr.brhid='"+brhid+"' and tr.rdocno="+docno+" and tr.status=3 ) tr "
			          		+ "inner join my_termsm m on(tr.termsid=m.voc_no), (SELECT @s:= 0) AS s where  m.status=3 union all "
			          		+ "select '       *' sr_no ,tr.rdocno,conditions terms,m.doc_no,priorno "
			          		+ " from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where "
			          		+ "   tr.dtype='NPO' and tr.rdocno="+docno+" and tr.brhid='"+brhid+"' and tr.status=3 and m.status=3  order by doc_no,priorno" ;
			        	bean.setTermQry(termsquery);
			        	bean.setDescQry(descQry);

				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	
	
	public ClsnipurchaseorderBean getViewDetails(int docno, HttpSession session) throws SQLException {
		ClsnipurchaseorderBean showBean = new ClsnipurchaseorderBean();
		
		Connection conn=null;
		try { 
			conn = connDAO.getMyConnection();
		 
		Statement stmtmain = conn.createStatement ();
    	String pySql=("select  coalesce(m.typeid,0) typeid,coalesce(p.ptype,'') ptype,coalesce(p.per,0) per ,m.doc_no,m.voc_no,m.date,m.netamount,m.type,m.acno,m.refno,m.curid,m.rate,m.delterm,m.payterm,m.deldate,m.desc1,h.description,h.account "
	        			+ "from my_srvlpom m left join my_head h on h.doc_no=m.acno "
	        			+ " left join (select p.doc_no,p.producttype ptype,m.per,m.acno taxaccount from my_ptype p "
					     +" left join gl_taxmaster m on p.doc_no=m.typeid and m.type=1 where  p.status=3 and m.type=1 group by p.doc_no and m.typeid>0) p on p.doc_no=m.typeid "
	        			+ "where m.status<>7  and m.voc_no='"+docno+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" " );
    	System.out.println("========"+pySql);
		ResultSet resultSet = stmtmain.executeQuery(pySql);  

		while (resultSet.next())
		{
			
			  
			  showBean.setHideproducttype(resultSet.getInt("typeid"));
			  showBean.setTxtproducttype(resultSet.getString("ptype"));
			  showBean.setTaxpers(resultSet.getDouble("per"));
		 
		showBean.setHidnipurchaseorderdate(resultSet.getString("date"));
		
		 
		showBean.setHiddeliverydate(resultSet.getString("deldate"));
		 
		showBean.setRefno(resultSet.getString("refno"));
		 
		showBean.setAcctypeval(resultSet.getString("type"));
		 
		showBean.setPuraccname(resultSet.getString("description"));
		showBean.setCmbcurrval(resultSet.getString("curid"));
		showBean.setAccdocno(resultSet.getString("acno"));
		showBean.setCurrate(resultSet.getString("rate"));
		
		showBean.setPuraccid(resultSet.getString("account"));
		
		showBean.setDelterms(resultSet.getString("delterm"));
		showBean.setPayterms(resultSet.getString("payterm"));
		showBean.setPurdesc(resultSet.getString("desc1"));
		showBean.setNettotal(resultSet.getDouble("netamount"));
		 
		showBean.setDocno(resultSet.getInt("voc_no"));
		showBean.setMasterdoc_no(resultSet.getInt("doc_no"));
		
		
		}
		
		stmtmain.close();
		conn.close();
		}
		catch(Exception e){
			
		e.printStackTrace();
		conn.close();
		}
		return showBean;
		
	}
       
    }

	


