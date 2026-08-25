package com.dashboard.purchases.goodsreceiptnotefollowup;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsGoodsReceiptNoteFollowupDAO {
	ClsConnection ClsConnection=new ClsConnection();
	
	ClsCommon ClsCommon =new ClsCommon();
	
	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String mob,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
    
        Connection conn = null;
 
        String sqltest="";
               
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and t.account like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and t.description like '%"+accountname+"%'";
                     }
                     if(!(mob.equalsIgnoreCase("0")) && !(mob.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and if(a.per_mob=0,a.per_tel,a.per_mob) like '%"+mob+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmt = conn.createStatement ();
      
   
    String  sql= "select t.doc_no,t.account,t.description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t "
    		+ " inner join my_acbook a on t.cldocno=a.cldocno and a.dtype='VND'	and t.atype='AP' where a.active=1 and t.m_s=0 "+sqltest;
 
    ResultSet resultSet = stmt.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmt.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }
	
	public   JSONArray locationsearch(HttpSession session,String brhid) throws SQLException {

		 
	    
		JSONArray RESULTDATA=new JSONArray();
 
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
				Statement stmtmain = conn.createStatement (); 
				
 
				
	        	String pySql=("select loc_name,doc_no,brhid from my_locm where status=3 and brhid='"+brhid+"'" );
 
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				


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


	public   JSONArray listsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
/*        java.sql.Date sqlfromdate = null;
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
     
     	}*/

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
		
				
				String sql=" select l.name names,bv.fdate,mm.brhid,mm.description desc1,mm.rdtype,case when  mm.rdtype='PO' then 'Purchase Order' else 'Direct' end as dtype"
						+ "  ,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno   "
						+ "  from my_grnm mm left join my_grnd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId "
						+ "  left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "left join (select max(b.doc_no) doc_no,rdocno from my_bgrnf b group by  rdocno) "
	        			+ "  b on(b.rdocno=mm.doc_no) left join  my_bgrnf bv on b.doc_no=bv.doc_no  left join my_statuslist l on l.doc_no=mm.statuschg and l.dtype='GRN' "
	        			+ "    where    d.qty>d.out_qty   "+sqltest+" group by mm.doc_no  ";
						
            	      // System.out.println("-----------"+sql);	
            		   ResultSet resultSet = stmtVeh.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		   stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray listsearchEX(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
/*        java.sql.Date sqlfromdate = null;
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
     
     	}*/

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
		 
		
				
				String sql=" select mm.voc_no 'Doc No',mm.date 'Date',mm.refno 'Ref No',mm.rdtype,case when  mm.rdtype='PO' then 'Purchase Order' else 'Direct' end as  'Type'  ,  "
						+ "  h.account 'Account',h.description 'Account Name' ,l.name 'Status',mm.description 'Description',bv.fdate  'Follow up Date' "
						+ "  from my_grnm mm left join my_grnd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId "
						+ "  left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "left join (select max(b.doc_no) doc_no,rdocno from my_bpof b group by  rdocno) "
	        			+ "  b on(b.rdocno=mm.doc_no) left join  my_bpof bv on b.doc_no=bv.doc_no  left join my_statuslist l on l.doc_no=mm.statuschg and l.dtype='PO' "
	        			+ "    where    d.qty>d.out_qty   "+sqltest+" group by mm.doc_no  ";
				
 
            		   ResultSet resultSet = stmtVeh.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
            		   stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	

	
	

	public   JSONArray Details(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from my_bgrnf m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'     group by m.doc_no ";
///System.out.println("=======sql=="+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public   JSONArray listsubsearch(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();      
		 
		
				
				String sql=" select d.stockid,at.mspecno as specid ,d.psrno, bd.brandname , mm.rdtype dtype, " 
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno , "
						+ "  d.qty-d.out_qty  qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,"
						+ "  convert(if(d.amount=0,'',d.amount),char(30)) amount,convert(if(d.amount=0,'',d.amount*(d.qty-d.out_qty)),char(30))  total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.disper=0,'',(d.amount*(d.qty-d.out_qty))*d.disper/100),char(30)) discount ,"
						+ " convert(if(d.amount=0,'',(d.amount*(d.qty-d.out_qty))-((d.amount*(d.qty-d.out_qty))* d.disper/100)),char(100))  nettotal  "
						+ "  from my_grnm mm left join my_grnd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId "
						+ "  left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where     d.qty>d.out_qty and   mm.doc_no="+docno+" ";
          
            	  System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	public   JSONArray listsubsearchEx(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();     
 
				String sql=" select mm.voc_no 'Doc No' , "
						+ "  m.part_no 'Product Id',m.productname 'Product Name', bd.brandname 'Brand Name',u.unit 'Unit',  "
						+ "  d.qty-d.out_qty  'Qty'  ,"
						+ "  convert(if(d.amount=0,'',d.amount),char(30))  'Unit Price',convert(if(d.amount=0,'',d.amount*(d.qty-d.out_qty)),char(30))   'Total' "
						+ "  ,round(convert(if(d.disper=0,'',d.disper),char(30)),2) 'Discount %',"
						+ "  convert(if(d.disper=0,'',(d.amount*(d.qty-d.out_qty))*d.disper/100),char(30)) 'Discount',  "
						+ "  convert(if(d.amount=0,'',(d.amount*(d.qty-d.out_qty))-((d.amount*(d.qty-d.out_qty))* d.disper/100)),char(100))   'Net Total' "
						+ "  from my_grnm mm left join my_grnd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId "
						+ "  left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where    d.qty>d.out_qty and   mm.doc_no="+docno+" ";
          
				
      	        
            	// System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
 
	
	
	
		public int insert(Date masterdate, Date deldate, String refno, int vendocno, 
				int cmbcurr, double currate, String delterms, String payterms,
				String purdesc, double productTotal, double descPercentage,
				double descountVal, double roundOf, double netTotaldown,
				double servnettotal, double orderValue, int chkdiscount,
				HttpSession session, String mode,  
				String formdetailcode, HttpServletRequest request, ArrayList <String> descarray, ArrayList <String> masterarray, String reftype,
				String rrefno, double prddiscount, ArrayList<String> exparray,  
				double exptotal, Date invdate, String invno, String locationid, double stval, double tax1, double tax2, double tax3, double nettax, 
				int cmbbilltype,Connection conn,int brhid,int itermtype,int costtrno) throws SQLException  {
			
			
			
			 
			try{
				int docno;
			
				 
				CallableStatement stmtpuchase= conn.prepareCall("{call tr_PurchaseinvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtpuchase.registerOutParameter(20, java.sql.Types.INTEGER);
				stmtpuchase.registerOutParameter(24, java.sql.Types.INTEGER);
	 
				stmtpuchase.setDate(1,masterdate);
				stmtpuchase.setDate(2,deldate);
				stmtpuchase.setString(3,refno);
				stmtpuchase.setInt(4,vendocno);
			   	stmtpuchase.setInt(5,cmbcurr);
				stmtpuchase.setDouble(6,currate);
				stmtpuchase.setString(7,delterms); 
				stmtpuchase.setString(8,payterms);
				stmtpuchase.setString(9,purdesc);
				stmtpuchase.setDouble(10,productTotal);
				stmtpuchase.setDouble(11,descPercentage);
				stmtpuchase.setDouble(12,descountVal);
				stmtpuchase.setDouble(13,roundOf);
				stmtpuchase.setDouble(14,netTotaldown); 
				stmtpuchase.setDouble(15,servnettotal);
				stmtpuchase.setDouble(16,orderValue);
				stmtpuchase.setString(17,session.getAttribute("USERID").toString());
				stmtpuchase.setInt(18,brhid);
				stmtpuchase.setString(19,session.getAttribute("COMPANYID").toString());
				
				
			//	System.out.println("-----------"+session.getAttribute("BRANCHID").toString());
				stmtpuchase.setString(21,formdetailcode);
				stmtpuchase.setString(22,mode);
				stmtpuchase.setInt(23,chkdiscount);
				stmtpuchase.setString(25,reftype);
				stmtpuchase.setString(26,rrefno);
				stmtpuchase.setDouble(27,prddiscount);
				
				stmtpuchase.setDouble(28,exptotal);
				
				stmtpuchase.setDate(29,invdate);
				
				stmtpuchase.setString(30,invno);
				stmtpuchase.setString(31,locationid);
				 
				
				stmtpuchase.executeQuery();
				docno=stmtpuchase.getInt("docNo");
		 
				int vocno=stmtpuchase.getInt("vocNo");	
				request.setAttribute("vocno", vocno);
				//System.out.println("====vocno========"+vocno);
			
				if(docno<=0)
				{
					conn.close();
					return 0;
					
				}
				//System.out.println("sssssss"+session.getAttribute("USERID").toString());
				
				
				int mastertr_no=0;
				
		    	
				 Statement stmt1=conn.createStatement();
				
				String sqlss="select tr_no from my_srvm where doc_no='"+docno+"' ";
				ResultSet selrs=stmt1.executeQuery(sqlss);
				
				if(selrs.next())
				{
					mastertr_no=selrs.getInt("tr_no");
					
				}
				
				
				int cosrcodemethod=0;			
				Statement coststmt=conn.createStatement();
				String chks="select method  from gl_prdconfig where field_nme='costcenter'";
				ResultSet rss1=coststmt.executeQuery(chks); 
				if(rss1.next())
				{
					
					cosrcodemethod=rss1.getInt("method");
				}
				
				if(cosrcodemethod>0) 
				{
					String upcostsql="update my_srvm set costtype='"+itermtype+"',costcode='"+costtrno+"' where doc_no="+docno+" ";
					coststmt.executeUpdate(upcostsql);
					
					
					
				}
					
				
				int taxmethod=0;
				 Statement stmttax=conn.createStatement();
				 String chk="select method  from gl_prdconfig where field_nme='tax'";
				 ResultSet rssz=stmttax.executeQuery(chk); 
				 if(rssz.next())
				 {
				 	
					 taxmethod=rssz.getInt("method");
				 }

				 int stacno=0;
				 int stacno1=0;
				 int tax1acno=0;
				 int tax2acno=0;
				 int tax3acno=0;
				 
				 
				  if(taxmethod>0)
				  {
					  String sqltax1= " update my_srvm set totaltax='"+stval+"',tax1='"+tax1+"',tax2='"+tax2+"',tax3='"+tax3+"',"
					  		+ "nettotaltax='"+nettax+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+docno+"' ";
					  
					  System.out.println("======sqltax1========="+sqltax1);
					  
					  stmt1.executeUpdate(sqltax1);
				
				  int prvdocno=0;
					 
					  Statement pv=conn.createStatement();
						
						String dd="select prvdocno from my_brch where doc_no="+brhid+" ";
						
						System.out.println("=======dd========"+dd);
						
						
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						System.out.println("======prvdocno========"+prvdocno);

						 
					 
					  
					  	Statement ssss10=conn.createStatement();
				  
		/*				 String sql10="  select acno,value from gl_taxmaster where doc_no=(select max(doc_no) tdocno from gl_taxmaster where  "
						 		+ "  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and provid='"+prvdocno+"'  )  "
						 				+ "  and status=3 and type=1 and provid='"+prvdocno+"'  " ;
						 */
						 
						 String sql10="  select acno,value from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and provid='"+prvdocno+"'   "
							 				+ "  and status=3 and type=1 and provid='"+prvdocno+"' and  if(1="+cmbbilltype+",per,cstper)>0  " ;
						 
						 
						 
						// System.out.println("====sql10========"+sql10);
						 
						 
						 int mm=0;
					
						 ResultSet rstaxxx101=ssss10.executeQuery(sql10); 
						 while(rstaxxx101.next())
						 {
							 if(mm==0)
							 {
							 stacno=rstaxxx101.getInt("acno");
							 }

							 if(mm==1)
							 {
								 stacno1=rstaxxx101.getInt("acno");
							 } 
							 mm=mm+1;
													 	
						 	
						 }

					  
					  	Statement ssss=conn.createStatement();
				  
						 String sql100=" select s.acno,s.value "
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  ) "
								 		+ "  and status=3 and type=1 and seqno=1 and provid='"+prvdocno+"'  " ;
					System.out.println("=====sql======"+sql100);
						 ResultSet rstaxxx=ssss.executeQuery(sql100); 
						 if(rstaxxx.next())
						 {
							 String typeoftax="0";
							 tax1acno=rstaxxx.getInt("acno");
							 typeoftax=rstaxxx.getString("value");
							 
							 String sqltax11= " update my_srvm set typeoftax='"+typeoftax+"'    where doc_no='"+docno+"' ";
								  
							 System.out.println("======sqltax11========="+sqltax11);
								  
							 stmt1.executeUpdate(sqltax11);						 	
						 	
						 }

						  	Statement ssss1=conn.createStatement();
					  
							 String sql166=" select s.acno"
									 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
									 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=2 and provid='"+prvdocno+"'  " ;
						
							 ResultSet rstaxxx1=ssss1.executeQuery(sql166); 
							 if(rstaxxx1.next())
							 {
								 
								 tax2acno=rstaxxx1.getInt("acno");
														 	
							 	
							 }
				  
								Statement ssss3=conn.createStatement();
								  
								 String sql311=" select s.acno "
										 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
										 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  ) and status=3 and type=1 and seqno=3 and provid='"+prvdocno+"'  " ;
							
								 ResultSet rstaxxx3=ssss3.executeQuery(sql311); 
								 if(rstaxxx3.next())
								 {
									 
									 tax3acno=rstaxxx3.getInt("acno");
															 	
								 	
								 }
					  
				  
				  
				  }
				 
				  
				  
					int bachmethod=0;
					 Statement stmtw=conn.createStatement();
					 String batchs="select method  from gl_prdconfig where field_nme='batch_no'";
					 ResultSet rz=stmtw.executeQuery(batchs); 
					 if(rz.next())
					 {
					 	
						 bachmethod=rz.getInt("method");
					 }

						int expmethod=0;
						 Statement stmtd=conn.createStatement();
						 String expdatesql="select method  from gl_prdconfig where field_nme='exp_date'";
						 ResultSet exprs=stmtd.executeQuery(expdatesql); 
						 if(exprs.next())
						 {
						 	
							 expmethod=exprs.getInt("method");
						 }

						  
			
				
				String rownochk="0"; 
				for(int i=0;i< masterarray.size();i++){
			    	
				     String[] detmasterarrays=masterarray.get(i).split("::");
				     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
				     {
				    	 
				    	 
				    	String qtychk=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
				    	 
				    	 
					     double chkqty=Double.parseDouble(qtychk);
				    	
					     
					     double expenxetotal=0;
					     double resultexptotal=0;
					     double totalpriceallqty=0;
					     
					     double costprice=0;
					     
					     if(chkqty>0){
				    	
					    	// netTotaldown servnettotal exptotal
					    	 
					    	 //chkqty,
					    	 
					    	 String gridnettotals=""+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"";
					    	 
					    	 double gridnettotal=Double.parseDouble(gridnettotals);
					    	 
					    	// System.out.println("--gridnettotal---"+gridnettotal);
					    	 expenxetotal=servnettotal+exptotal;
					    	 
					    	 if(expenxetotal>0)
					    	 {
						//	 System.out.println("--expenxetotal---"+expenxetotal);
					    	 resultexptotal=(expenxetotal/netTotaldown)*gridnettotal;
					    	// System.out.println("--resultexptotal---"+resultexptotal);
					    	 totalpriceallqty=gridnettotal+resultexptotal;
					    	// System.out.println("--totalpriceallqty---"+totalpriceallqty);
					    	 costprice=totalpriceallqty/chkqty;
					    	// System.out.println("--costprice---"+costprice);
					    	 }
					    	 else
					    	 {
					    		 
					    		 costprice=gridnettotal/chkqty;
					    		 
					    	 }
					    	 
					    	 
					    	 
					    	   if(reftype.equalsIgnoreCase("GRN")||reftype.equalsIgnoreCase("PO"))
						         {	 
					    	
					    		   
					    		 if(reftype.equalsIgnoreCase("GRN"))
					    		 {
					  
	/*				    			 
					   			  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
										   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
										   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc
										   +" :: "+rows[i].orderdiscper+" :: "+rows[i].orderamount+"::"+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::"); 
					    			                                                                         17                    18                   19
					    		   */
					    		   
				    	 
							             String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno)VALUES"
									       + " ("+(i+1)+","
									       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
									       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
									       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
									       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
									       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
									       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
									       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
									       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
									       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
									       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
									       + "'"+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"',"
									       +"'"+mastertr_no+"','"+docno+"',"
									       + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
									       + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
									       + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"',"
									       + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"' )";
					                      //   System.out.println("-----insql-"+insql);
									     int resultSet2 = stmtpuchase.executeUpdate(insql);
									     if(resultSet2<=0)
											{
												conn.close();
												return 0;
												
											}
									     
									     
									     
									     
									 }
					    		 
					    		 else if(reftype.equalsIgnoreCase("PO"))
					    		 {
								    			 
								  			    String	paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
								 			    String	foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";	 
												    	 
												    	 
													     double paidqty=Double.parseDouble(paidqtyd);
													     
													     double focqty=Double.parseDouble(foc);
													 
													 
													     double opqty=paidqty+focqty; 
													     /*                          0                1                       2                       3
														  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
																  
																  
																              4                        5                       6                      7                    8
																   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
																                     9                       10                     11                   12                       13                 14
																   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc)*/
												
													     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,cost_price,invno,pstatus,date)values"
													    		 + "("+(i+1)+","
													             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
															     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
															     + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
													               + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
															     +"'"+opqty+"','"+focqty+"',"
													             +"'"+locationid+"','"+brhid+"','"+mastertr_no+"','"+formdetailcode+"',"+costprice+",'"+docno+"',1,'"+masterdate+"')";
													     
													    // System.out.println("--sql2-----"+sql2);
													     int resultSet10 = stmtpuchase.executeUpdate(sql2);
													     if(resultSet10<=0)
															{
																conn.close();
																return 0;
																
															}
											     	
											     int stockid=0;	
											    
										         Statement selstmt=conn.createStatement();
										     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";
										     
										  
										     
										     ResultSet selrss=selstmt.executeQuery(sqlssel);
										     
										     if(selrss.next())
										     {
										    	 stockid=selrss.getInt("stockid") ;
										    	 
										    	 
										    	 
										 	 
										     }
										      
							     
									     
									     String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno)VALUES"
											       + " ("+(i+1)+","
											       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
											       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
											       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
											       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
											       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
											       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
											       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
											       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
											       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
											       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
											      + "'"+stockid+"',"
											       +"'"+mastertr_no+"','"+docno+"',"
											       	+ "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| taxmethod==0 ||  detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
											       	+ "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| taxmethod==0 ||  detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
											       	+ "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")|| taxmethod==0 ||  detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"' ,"
									     + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"')";         
									     
									     
									     //   System.out.println("-----insql-"+insql);
											     int resultSet2 = stmtpuchase.executeUpdate(insql);
											     if(resultSet2<=0)
													{
														conn.close();
														return 0;
														
													}
					    			 
					     } // noushad
					     
					    // rrefno
					     
					     
					     String prdid=""+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"";
					     
					  
					     String entrytype=""+(detmasterarrays[9].trim().equalsIgnoreCase("undefined") || detmasterarrays[9].trim().equalsIgnoreCase("NaN")|| detmasterarrays[9].trim().equalsIgnoreCase("")|| detmasterarrays[9].isEmpty()?0:detmasterarrays[9].trim())+"";
					     
					     
					     String  rqty=""+(detmasterarrays[8].trim().equalsIgnoreCase("undefined") || detmasterarrays[8].trim().equalsIgnoreCase("NaN")|| detmasterarrays[8].trim().equalsIgnoreCase("")|| detmasterarrays[8].isEmpty()?0:detmasterarrays[8].trim())+"";
					     
					     double masterqty=Double.parseDouble(rqty);
					     
					     
					 	String psrno=""+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+""; 
				    	  
				    	   
					     String specno=""+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")|| detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"";
					    
						 
					    	String  stockid=""+(detmasterarrays[12].trim().equalsIgnoreCase("undefined") || detmasterarrays[12].trim().equalsIgnoreCase("NaN")||detmasterarrays[12].trim().equalsIgnoreCase("")|| detmasterarrays[12].isEmpty()?0:detmasterarrays[12].trim())+"";
					    	 

						     String prddoutqty=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
						     
						     
						     String amounts=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
					     
					  
							  if(reftype.equalsIgnoreCase("GRN"))
							  {		   

						    
					    		 
						 	   double balqty=0;
								 
					             int tr_no=0;
								double remqty=0;
								double out_qty=0;
									double qty=0;
									
									double grnout=0;
									
									
									double grnsaveqty=0; 
									double prddinsaveqty=0;
									
									
		
									
					    	 Statement stmt=conn.createStatement();
					    	 
					    	 String strSql="select dd.tr_no,dd.psrno,d.specno,sum(dd.op_qty) qty,sum((dd.op_qty-(dd.rsv_qty+dd.out_qty+dd.del_qty))) balstkqty,sum(dd.out_qty) out_qty,date,sum(d.out_qty) grnout from my_prddin dd "
										+ " left join my_grnd d on dd.stockid=d.stockid and dd.psrno=d.psrno and dd.specno=d.specno and dd.prdid=d.prdid  where dd.psrno='"+psrno+"' and dd.specno='"+specno+"' and dd.prdid='"+prdid+"' and dd.brhid="+brhid+" and dd.stockid='"+stockid+"' "
												+ "group by dd.stockid,dd.psrno,dd.prdid having sum(d.qty-d.out_qty)>0 order by dd.date";
		 
					        // System.out.println("---1111111111strSql-----"+strSql);
					    		ResultSet rs = stmt.executeQuery(strSql);
					    		
					    		
					    		while(rs.next()) {


									balqty=rs.getDouble("balstkqty");
									tr_no=rs.getInt("tr_no");
									out_qty=rs.getDouble("out_qty");

									//stockid=rs.getInt("stockid");
									qty=rs.getDouble("qty");
									grnout=rs.getDouble("grnout");
							//	System.out.println("---masterqty-----"+masterqty);	
								
							//	System.out.println("---grnout-----"+grnout);	
							//	System.out.println("---out_qty-----"+out_qty);	

									//System.out.println("---masterqty-----"+masterqty);	

								//	System.out.println("---balqty-----"+balqty);	

									//System.out.println("---out_qty-----"+out_qty);	
								//	System.out.println("---qty-----"+qty);

					 

								if(masterqty<=balqty)
								{
									
									grnsaveqty=masterqty+grnout;
									
									String sqls="update my_grnd set out_qty="+grnsaveqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
									

								//	System.out.println("--1---sqls---"+sqls);


									stmtpuchase.executeUpdate(sqls);
									
									
	                              	String prdinsqls="update my_prddin set cost_price="+costprice+",invno='"+docno+"',pstatus=1,unit_price='"+amounts+"' where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
									

								//	System.out.println("--1---prdinsqls---"+prdinsqls);


									stmtpuchase.executeUpdate(prdinsqls); 
									
									
								/*	prddinsaveqty=masterqty+out_qty;
									
	                              	String prdinsqls="update my_prddin set out_qty="+prddinsaveqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  stockid="+stockid+"";
									

									System.out.println("--1---prdinsqls---"+prdinsqls);

	cost_price
									stmtpuchase.executeUpdate(prdinsqls);*/
									
									
					/*					
									String insertsql="insert into my_prddout(sr_no,TR_NO, dtype, specid, psrno, stockid, qty, rdocno,prdid)values("+(i+1)+",'"+mastertr_no+"','"+formdetailcode+"','"+specno+"','"+psrno+"','"+stockid+"','"+prddoutqty+"','"+docno+"','"+prdid+"')";
									
									stmtpuchase.executeUpdate(insertsql);
									
									System.out.println("--1---insertsql---"+insertsql);*/
									
									
									break;


								}

								} 


					    		
					 
				  }

				   else  if(reftype.equalsIgnoreCase("PO"))
		         {
			    	 
		 
				 /*    String  rqty=""+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")|| detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"";
				     
				     */
				     
				  //   double masterqty=Double.parseDouble(rqty); 
			   		 
					   
						String amount=""+(detmasterarrays[16].trim().equalsIgnoreCase("undefined") || detmasterarrays[16].trim().equalsIgnoreCase("NaN")||detmasterarrays[16].trim().equalsIgnoreCase("")|| detmasterarrays[16].isEmpty()?0:detmasterarrays[16].trim())+"";
						  
						   
						   
						String discper=""+(detmasterarrays[15].trim().equalsIgnoreCase("undefined") || detmasterarrays[15].trim().equalsIgnoreCase("NaN")||detmasterarrays[15].trim().equalsIgnoreCase("")|| detmasterarrays[15].isEmpty()?0:detmasterarrays[15].trim())+"";
						   
					   
					   
			    	   double balqty=0;
						int rowno=0;
			             int tr_no=0;
						double remqty=0;
						double out_qty=0;
							double qty=0;
			    	 
			    	 Statement stmt=conn.createStatement();
			
			    	 
			    	 String strSql="select d.qty ,sum((d.qty-d.out_qty)) balqty,d.rowno,d.tr_no,d.out_qty  from my_ordm m  left join  my_ordd d on m.tr_no=d.tr_no where   d.clstatus=0 and\r\n" + 
			    	 		"d.tr_no in ("+rrefno+")  and  d.prdid='"+prdid+"' and m.brhid="+brhid+" and d.rowno not in("+rownochk+")   group by d.rowno having "
			    	 				+ " sum((d.qty-d.out_qty)>0) order by m.date,d.rowno ";
			    	 
	                   System.out.println("-----strSql--sssssssssssssssssssssssssssssssssssssssssssssssssss-"+strSql);
			    	 
			 
			    		ResultSet rs = stmt.executeQuery(strSql);
			     
			    
			    		while(rs.next()) {
			    			 
			    			
							balqty=rs.getDouble("balqty");
							tr_no=rs.getInt("tr_no");
							out_qty=rs.getDouble("out_qty");

							rowno=rs.getInt("rowno");
							qty=rs.getDouble("qty");

						 System.out.println("---masterqty-----"+masterqty);	

						//	System.out.println("---balqty-----"+balqty);	

						//System.out.println("---out_qty-----"+out_qty);	
						//	System.out.println("---qty-----"+qty);
							
							
							rownochk=rownochk+","+rowno;
							
			    			 
							
							
							
							
							
							
							if(remqty>0)
							{

								masterqty=remqty;
							}


							if(masterqty<=balqty)
							{
								masterqty=masterqty+out_qty;

								
								String sqls="update my_ordd set out_qty="+masterqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0";
								

							 System.out.println("--1---sqls---"+sqls);


								stmtpuchase.executeUpdate(sqls);
								break;


							}
							else if(masterqty>balqty)
							{



								if(qty>=(masterqty+out_qty))

								{
									balqty=masterqty+out_qty;	
									remqty=qty-out_qty;

									//	System.out.println("---remqty-1---"+remqty);
								}
								else
								{
									
									
									remqty=masterqty-balqty;
									balqty=qty;
									
								//	System.out.println("---masterqty--"+masterqty);
									
									//System.out.println("---balqty--"+balqty);
									
									
									//System.out.println("---remqty--2--"+remqty);
								}


								String sqls="update my_ordd set out_qty="+balqty+" where tr_no="+tr_no+" and prdid="+prdid+" and  rowno="+rowno+" and clstatus=0";	
							 	System.out.println("-2----sqls---"+sqls);

								stmtpuchase.executeUpdate(sqls);	

							 



							} //else if

			    		 
			    			
			    	  		}  // while
			    	 
			     		     
			     
			    	   }
					     
					     
					    	 }
					     
	 			     else if(reftype.equalsIgnoreCase("DIR"))
					     {
					    	 

		 
	 			    String	paidqtyd=""+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"";
	 			    String	foc=""+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"";	 
					    	 
					    	 
						     double paidqty=Double.parseDouble(paidqtyd);
						     
						     double focqty=Double.parseDouble(foc);
						 
						 
						     double opqty=paidqty+focqty; 
						     /*                          0                1                       2                       3
							  newTextBox.val(rows[i].psrno+"::"+rows[i].prodoc+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
									  
									  
									              4                        5                       6                      7                    8
									   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].saveqty
									                     9                       10                     11                   12                       13                 14
									   +" :: "+rows[i].checktype+" :: "+rows[i].specid+" :: "+rows[i].discper+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+rows[i].foc)*/
					
						     String sql2="insert into my_prddin(sr_no, psrno,prdid,specno,unit_price,op_qty,foc,locid,brhid,tr_no,dtype,cost_price,invno,pstatus,date)values"
						    		 + "("+(i+1)+","
						             + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
								     + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
								     + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
						               + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
								     +"'"+opqty+"','"+focqty+"',"
						             +"'"+locationid+"','"+brhid+"','"+mastertr_no+"','"+formdetailcode+"',"+costprice+",'"+docno+"',1,'"+masterdate+"')";
						     
						    // System.out.println("--sql2-----"+sql2);
						     int resultSet10 = stmtpuchase.executeUpdate(sql2);
						     if(resultSet10<=0)
								{
									conn.close();
									return 0;
									
								}
						     	
						     int stockid=0;	
						    
					         Statement selstmt=conn.createStatement();
					     String sqlssel="select coalesce((max(stockid)),1) stockid from my_prddin  ";
					     
					  
					     
					     ResultSet selrss=selstmt.executeQuery(sqlssel);
					     
					     if(selrss.next())
					     {
					    	 stockid=selrss.getInt("stockid") ;
					    	 
					    	 
					    	 
					 	 
					     }
					      	 
					    	 
					     String insql="INSERT INTO my_srvd(sr_no,psrno,prdId,unitid,qty,amount,total,discount,nettotal,specno,disper,foc,stockid,tr_no,rdocno,taxper,taxamount,nettaxamount,taxdocno)VALUES"
							       + " ("+(i+1)+","
							     + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
							       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
							       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
							       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
							       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
							       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"',"
							       + "'"+(detmasterarrays[6].trim().equalsIgnoreCase("undefined") || detmasterarrays[6].trim().equalsIgnoreCase("NaN")||detmasterarrays[6].trim().equalsIgnoreCase("")|| detmasterarrays[6].isEmpty()?0:detmasterarrays[6].trim())+"',"
							       + "'"+(detmasterarrays[7].trim().equalsIgnoreCase("undefined") || detmasterarrays[7].trim().equalsIgnoreCase("NaN")||detmasterarrays[7].trim().equalsIgnoreCase("")|| detmasterarrays[7].isEmpty()?0:detmasterarrays[7].trim())+"',"
							       + "'"+(detmasterarrays[10].trim().equalsIgnoreCase("undefined") || detmasterarrays[10].trim().equalsIgnoreCase("NaN")||detmasterarrays[10].trim().equalsIgnoreCase("")|| detmasterarrays[10].isEmpty()?0:detmasterarrays[10].trim())+"',"
							       + "'"+(detmasterarrays[11].trim().equalsIgnoreCase("undefined") || detmasterarrays[11].trim().equalsIgnoreCase("NaN")||detmasterarrays[11].trim().equalsIgnoreCase("")|| detmasterarrays[11].isEmpty()?0:detmasterarrays[11].trim())+"',"
							       + "'"+(detmasterarrays[14].trim().equalsIgnoreCase("undefined") || detmasterarrays[14].trim().equalsIgnoreCase("NaN")||detmasterarrays[14].trim().equalsIgnoreCase("")|| detmasterarrays[14].isEmpty()?0:detmasterarrays[14].trim())+"',"
							       + "'"+stockid+"',"
							       +"'"+mastertr_no+"','"+docno+"',"
								   + "'"+(detmasterarrays[17].trim().equalsIgnoreCase("undefined") || detmasterarrays[17].trim().equalsIgnoreCase("NaN")||detmasterarrays[17].trim().equalsIgnoreCase("")|| taxmethod==0 ||  detmasterarrays[17].isEmpty()?0:detmasterarrays[17].trim())+"',"
								   + "'"+(detmasterarrays[18].trim().equalsIgnoreCase("undefined") || detmasterarrays[18].trim().equalsIgnoreCase("NaN")||detmasterarrays[18].trim().equalsIgnoreCase("")|| taxmethod==0 ||  detmasterarrays[18].isEmpty()?0:detmasterarrays[18].trim())+"',"
								   + "'"+(detmasterarrays[19].trim().equalsIgnoreCase("undefined") || detmasterarrays[19].trim().equalsIgnoreCase("NaN")||detmasterarrays[19].trim().equalsIgnoreCase("")|| taxmethod==0 ||  detmasterarrays[19].isEmpty()?0:detmasterarrays[19].trim())+"' ," 
								   + "'"+(detmasterarrays[22].trim().equalsIgnoreCase("undefined") || detmasterarrays[22].trim().equalsIgnoreCase("NaN")||detmasterarrays[22].trim().equalsIgnoreCase("")|| taxmethod==0 || detmasterarrays[22].isEmpty()?0:detmasterarrays[22].trim())+"')";         
								    
								   //     System.out.println("-----insql-"+insql);
							     int resultSet2 = stmtpuchase.executeUpdate(insql);
							     if(resultSet2<=0)
									{
										conn.close();
										return 0;
										
									}
							  	 
					    	 
				
					    	 
					    	 
					    	 
					     }
					      
					     
						
		 
					     
					 
				     }	   
					     
					     if(bachmethod>0 || expmethod>0)
					     {
					     
					     	int   updatestockid=0;
					       Statement selstmt1=conn.createStatement();
						     String sqlssel1="select stockid from  my_srvd where rdocno='"+docno+"' group by stockid";
						     
						  
						     
						     ResultSet selrss1=selstmt1.executeQuery(sqlssel1);
						     
						     while(selrss1.next()) 
						     {
						    	 updatestockid=selrss1.getInt("stockid") ;
						    	 if(bachmethod>0)
						    	 {
						    		 String ssqlss="update my_prddin set  batch_no='"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")||  detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"' where stockid="+updatestockid+" ";
						    		 stmtpuchase.executeUpdate(ssqlss);
						    		 
						    		 String ssqlss2="update my_srvd set  BATCHNO='"+(detmasterarrays[20].trim().equalsIgnoreCase("undefined") || detmasterarrays[20].trim().equalsIgnoreCase("NaN")||detmasterarrays[20].trim().equalsIgnoreCase("")||  detmasterarrays[20].isEmpty()?0:detmasterarrays[20].trim())+"' where stockid="+updatestockid+" and  rdocno='"+docno+"' ";
						    		 stmtpuchase.executeUpdate(ssqlss2);
						    	 }
						    	 
						    	 if(expmethod>0) 
						    	 { 
						    		
						    		 String ssqlss1="update my_prddin set  exp_date='"+(detmasterarrays[21].trim().equalsIgnoreCase("undefined") || detmasterarrays[21].trim().equalsIgnoreCase("NaN")||detmasterarrays[21].trim().equalsIgnoreCase("")||  detmasterarrays[21].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[21].trim()))+"' where stockid="+updatestockid+" ";
						    		 stmtpuchase.executeUpdate(ssqlss1); 
						    		 
						    		 String ssqlss3="update my_srvd set  bExpiry='"+(detmasterarrays[21].trim().equalsIgnoreCase("undefined") || detmasterarrays[21].trim().equalsIgnoreCase("NaN")||detmasterarrays[21].trim().equalsIgnoreCase("")||  detmasterarrays[21].isEmpty()?0:ClsCommon.changeStringtoSqlDate(detmasterarrays[21].trim()))+"' where stockid="+updatestockid+" and  rdocno='"+docno+"' ";
						    		 stmtpuchase.executeUpdate(ssqlss3);
						    		 
						    		 
						    	 }
						    	 
						    	 
						 	 
						     } 
					     
					     }
					    
					     
					     
					     
					     
					     
					     
					     
					     
					     
					     
				 }
				     
				     
				     
				     
				     
			 
				     
				     
				     
					     
					     }
				
	 
				
				for(int i=0;i< descarray.size();i++){
			    	
				     String[] purorderarray=descarray.get(i).split("::");
				     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
				     {
				    	 
			     String sql1="INSERT INTO my_srvser(srno,qty,desc1,unitprice,total,discount,nettotal,brhid,rdocno,tr_no)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
					       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
					       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
					       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
					       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
					       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
					       + "'"+brhid+"',"
					       +"'"+docno+"','"+mastertr_no+"')";
				//  System.out.println("===sql1==="+sql1);
					     int resultSet2 = stmtpuchase.executeUpdate(sql1);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
					 
				     }	    
					     
					     }
				
				

	/*			                            0                1                    2   
				   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].descsrno+" :: "
				                       3                     4                      5                      6                       7                     
						   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].accountdono+" :: ");*/

				for(int i=0;i< exparray.size();i++){
			    	
				     String[] singleexparray=exparray.get(i).split("::");
				     if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
				     {
				    	 
			     String sql="INSERT INTO my_srvexp(srno,qty,descdocno,unitprice,total,discount,nettotal,acno,brhid,tr_no,rdocno)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(singleexparray[1].trim().equalsIgnoreCase("undefined") || singleexparray[1].trim().equalsIgnoreCase("NaN")|| singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()?0:singleexparray[1].trim())+"',"
					       + "'"+(singleexparray[2].trim().equalsIgnoreCase("undefined") || singleexparray[2].trim().equalsIgnoreCase("NaN")|| singleexparray[2].trim().equalsIgnoreCase("")|| singleexparray[2].isEmpty()?0:singleexparray[2].trim())+"',"
					       + "'"+(singleexparray[3].trim().equalsIgnoreCase("undefined") || singleexparray[3].trim().equalsIgnoreCase("NaN")||singleexparray[3].trim().equalsIgnoreCase("")|| singleexparray[3].isEmpty()?0:singleexparray[3].trim())+"',"
					       + "'"+(singleexparray[4].trim().equalsIgnoreCase("undefined") || singleexparray[4].trim().equalsIgnoreCase("NaN")||singleexparray[4].trim().equalsIgnoreCase("")|| singleexparray[4].isEmpty()?0:singleexparray[4].trim())+"',"
					       + "'"+(singleexparray[5].trim().equalsIgnoreCase("undefined") || singleexparray[5].trim().equalsIgnoreCase("NaN")||singleexparray[5].trim().equalsIgnoreCase("")|| singleexparray[5].isEmpty()?0:singleexparray[5].trim())+"',"
					       + "'"+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"',"
					       + "'"+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"',"
					       + "'"+brhid+"',"
					       +"'"+mastertr_no+"','"+docno+"')";
			    //System.out.println("==7777777777777777777777777777777777777777777=="+sql);
					     int resultSet2 = stmtpuchase.executeUpdate(sql);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
					 
				     }	    
					     
					     }
				
				

				
				
				// jv entry pass
				
				String invdates="";
				String sqldate="SELECT DATE_FORMAT('"+invdate+"', '%d-%m-%Y') dates";
				ResultSet rsssss=stmt1.executeQuery(sqldate);
				if(rsssss.first())
				{
					invdates=rsssss.getString("dates");
				}
				
				String descs=""+invno+""+" - DT :- "+invdates+" - "+purdesc; 
				
				String refdetails="PIV"+""+vocno;
				
	 
				 
			  	Statement stmt = conn.createStatement(); 	 
			 
			  int	venderaccount=vendocno;
			 
		      
			 
			 String vendorcur="1"; 
			 double venrate=1;
			 
			 String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
				//System.out.println("---1----sqls10----"+sqls10) ;
			   ResultSet tass11 = stmt.executeQuery (sqls10);
			   if(tass11.next()) {
			
				   vendorcur=tass11.getString("curid");	
				 
					
			        }
			 
			 
		     String currencytype="";
		     String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
		        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
		     //System.out.println("-----2--sqlss----"+sqlss) ;
		     ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);
		         
		      while (resultSet33.next()) {
		    	  venrate=resultSet33.getDouble("rate");
		     currencytype=resultSet33.getString("type");
		                      }
		   
			   double	dramount=(netTotaldown+servnettotal)*-1; 
			   
				 
			   double ldramount=0;
			   if(currencytype.equalsIgnoreCase("D"))
			   {
			   
	           	
	           	 ldramount=dramount/venrate ;  
			   }
			   
			   else
			   {
				    ldramount=dramount*venrate ;  
			   }
			   

			
			 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";
		     
			   //	System.out.println("--sql1----"+sql1);
			 int ss = stmt.executeUpdate(sql1);

		     if(ss<=0)
				{
					conn.close();
					return 0;
					
				}
		     String expcurrid="1"; 
		     double exprate=1;
				for(int i=0;i< exparray.size();i++){
			    	
				     String[] singleexparray=exparray.get(i).split("::");
				     if(!(singleexparray[1].trim().equalsIgnoreCase("undefined")|| singleexparray[1].trim().equalsIgnoreCase("NaN")||singleexparray[1].trim().equalsIgnoreCase("")|| singleexparray[1].isEmpty()))
				     {
				    	 
				    String acnos=""+(singleexparray[7].trim().equalsIgnoreCase("undefined") || singleexparray[7].trim().equalsIgnoreCase("NaN")||singleexparray[7].trim().equalsIgnoreCase("")|| singleexparray[7].isEmpty()?0:singleexparray[7].trim())+"";
				    String exptotaldramounts=""+(singleexparray[6].trim().equalsIgnoreCase("undefined") || singleexparray[6].trim().equalsIgnoreCase("NaN")||singleexparray[6].trim().equalsIgnoreCase("")|| singleexparray[6].isEmpty()?0:singleexparray[6].trim())+"";	 
				    
				    String sqlsexp="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
					//System.out.println("---1----sqls10----"+sqls10) ;
				   ResultSet rsexp = stmt.executeQuery (sqlsexp);
				   if(rsexp.next()) {
				
					   expcurrid=rsexp.getString("curid");	
					 
						
				        }
				 
				 
			     String expcurrencytype="";
			     String sqlexpselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
			        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+expcurrid+"'";
			     //System.out.println("-----2--sqlss----"+sqlss) ;
			     ResultSet rsexpx = stmt.executeQuery(sqlexpselect);
			         
			      while (rsexpx.next()) {
			    	  
			    	          exprate=rsexpx.getDouble("rate");
			    	          expcurrencytype=rsexpx.getString("type");
			                      
			                            }
			   
				   double	expdramount=Double.parseDouble(exptotaldramounts)*-1; 
				   
					 
				   double expldramount=0;
				   if(expcurrencytype.equalsIgnoreCase("D"))
				   {
				   
		           	
					   expldramount=expdramount/exprate;  
				   }
				   
				   else
				   {
					   expldramount=expdramount*exprate;  
				   }
				   

				
				 String sql1s="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+expcurrid+"','"+exprate+"',"+expdramount+","+expldramount+",0,-1,3,0,0,0,'"+exprate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";
			     
				  ///// 	System.out.println("--sql1----"+sql1);
				 int sss = stmt.executeUpdate(sql1s);

			     if(sss<=0)
					{
						conn.close();
						return 0;
						
					}
			     
				    
				    
				     }
				     
				}
		     
		     
		     
		     
		     
		     
		     
		     
		     int acnos=0;
		     String curris="1";
		     double rates=1;
		     
		    
		     
		   String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
		   //System.out.println("-----4--sql2----"+sql2) ;

	       ResultSet tass1 = stmt.executeQuery (sql2);
			
			if (tass1.next()) {
		
				acnos=tass1.getInt("acno");		
				
		        }
			
			
			
			 String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
			   //System.out.println("-----5--sqls3----"+sqls3) ;
			   ResultSet tass3 = stmt.executeQuery (sqls3);
				
				if (tass3.next()) {
			
					curris=tass3.getString("curid");	
					 
					
			              }
				String currencytype1="";
				 String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
					        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
				 //System.out.println("-----6--sqlveh----"+sqlveh) ;
					     ResultSet resultSet44 = stmt.executeQuery(sqlveh);
					         
					      while (resultSet44.next()) {
					    	  rates=resultSet44.getDouble("rate");
					      currencytype1=resultSet44.getString("type");
					                 } 
				 
					      double pricetottal=orderValue;
					      double ldramounts=0 ;     
					      if(currencytype1.equalsIgnoreCase("D"))
					      {
					      
			                   ldramounts=pricetottal/venrate ;  
					      }
					      
					      else
					      {
					    	   ldramounts=pricetottal*venrate ;  
					      }
		     
			 String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
				 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,1,3,0,0,0,'"+rates+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";
		     
		     
			// System.out.println("---sql11----"+sql11) ; 
		 
				 int ss1 = stmt.executeUpdate(sql11);

			     if(ss1<=0)
					{
						conn.close();
						return 0;
						
					}
			     
			     
			     
			     
			    //tax 
			     
			     
			     
			     
			     
			     
			     
			     
			     if(taxmethod>0)
					{
						
						
			    	 double taxtotals=0;
			    	 
			    	 
			    	 String sqlsss="select sum(taxamount) taxamount  from my_srvd where rdocno= "+docno+" ";
						
			    	 ResultSet mrs= stmt.executeQuery (sqlsss);
			    	 if(mrs.next())
			    	 {
			    		 
			    		 taxtotals=mrs.getDouble("taxamount");
			    		 
			    	 }
			    		 
			    		 
			    	 nettax=taxtotals;
			    	 stval=taxtotals;
						
						//client part

						String ggg="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+venderaccount+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet tax1sql = stmt.executeQuery (ggg);
						if(tax1sql.next()) {

							vendorcur=tax1sql.getString("curid");	


						}

	  
						String taxcurrencytype1="";
						String dddd = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--dddd----"+dddd) ;
						ResultSet resultSet = stmt.executeQuery(dddd);

						while (resultSet.next()) {
							venrate=resultSet.getDouble("rate");
							taxcurrencytype1=resultSet.getString("type");
						}

						double	dramounts=nettax*-1; 


						double ldramountss=0;
						if(taxcurrencytype1.equalsIgnoreCase("D"))
						{


							ldramountss=dramounts/venrate ;  
						}

						else
						{
							ldramountss=dramounts*venrate ;  
						}



						String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+venderaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,-1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int ss1111 = stmt.executeUpdate(rdse);

						if(ss1111<=0)
						{
							conn.close();
							return 0;

						}
						
						
						
						
						
						
						
						
						
						
						// total tax amount  int stacno=0;
						int divdval=1;
						if(stacno1>0)
						{
							divdval=2;
						}
						
						
						 
						
						System.out.println("=========================stacno===================================="+stacno);
						
						
						String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
						ResultSet t1sql1 = stmt.executeQuery(lll);
						if(t1sql1.next()) {

							vendorcur=t1sql1.getString("curid");	


						}

	  
						String taxcurre="";
						String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
						 System.out.println("-----2--ppp----"+ppp) ;
						ResultSet r1 = stmt.executeQuery(ppp);

						while (r1.next()) {
							venrate=r1.getDouble("rate");
							taxcurre=r1.getString("type");
						}

						double	dramt=stval/divdval; 


						double ldramt=0;
						if(taxcurre.equalsIgnoreCase("D"))
						{


							ldramt=dramt/venrate;  
						}

						else
						{
							ldramt=dramt*venrate;  
						}



						String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
						int aa = stmt.executeUpdate(sltax11);

						if(aa<=0)
						{
							conn.close();
							return 0;

						}
						
						
						
						
						
						
						
						// total tax amount  int stacno1=0;
						//stacno1
						
						
						 
						
						System.out.println("=========================stacno1===================================="+stacno1);
						
						if(stacno1>0)
						{
						
						
						
							String llls1="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno1+"'";
						//System.out.println("---1----sqls10----"+sqls10) ;
							ResultSet t1sql1s1 = stmt.executeQuery(llls1);
							if(t1sql1s1.next()) {

							vendorcur=t1sql1s1.getString("curid");	


							}

	 
							String taxcurres1="";
							String ppp1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
								+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
							System.out.println("-----2--ppp1----"+ppp1) ;
							ResultSet rs11 = stmt.executeQuery(ppp1);

							while (rs11.next()) {
							venrate=rs11.getDouble("rate");
							taxcurres1=rs11.getString("type");
								}

							double	dramts1=stval/divdval; 


							double ldramts1=0;
							if(taxcurres1.equalsIgnoreCase("D"))
							{


							ldramts1=dramts1/venrate;  
							}

							else
							{
							ldramts1=dramts1*venrate;  
							}



							String sltax11s1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
								+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+stacno1+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramts1+","+ldramts1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";

						//	System.out.println("--sql1----"+sql1);
							int aas1 = stmt.executeUpdate(sltax11s1);

							if(aas1<=0)
							{
								conn.close();
								return 0;

							}
						
						
						
						
						}
						
						
						
						
						
						// tax1acno tax 1

						
					 
						
	/*					
						if(tax1acno>0)
						{
							System.out.println("=========================tax1acno===================================="+tax1acno);
							String tsqls="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax1acno+"'";
							//System.out.println("---1----sqls10----"+sqls10) ;
							ResultSet tsqlsa = stmt.executeQuery(tsqls);
							if(tsqlsa.next()) {

								vendorcur=tsqlsa.getString("curid");	


							}

		     
							String taxcur="";
							String sqlvenslect111 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
							 System.out.println("-----2--sqlvenslect111----"+sqlvenslect111) ;
							ResultSet r11 = stmt.executeQuery(sqlvenslect111);

							while (r11.next()) {
								venrate=r11.getDouble("rate");
								taxcur=r11.getString("type");
							}

							double	dramt1=tax1; 


							double ldramt1=0;
							if(taxcur.equalsIgnoreCase("D"))
							{


								ldramt1=dramt1/venrate ;  
							}

							else
							{
								ldramt1=dramt1*venrate ;  
							}



							String sqlax111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax1acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";

							//	System.out.println("--sql1----"+sql1);
							int aa1 = stmt.executeUpdate(sqlax111);

							if(aa1<=0)
							{
								conn.close();
								return 0;

							}
							
						
						}
						
						
						
						*/
						
					/*	
						if(tax2acno>0)
						{
							
							
							System.out.println("=========================tax2acno===================================="+tax2acno);
							
							
							String sqlstax10111="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax2acno+"'";
							//System.out.println("---1----sqls10----"+sqls10) ;
							ResultSet tax1sql111 = stmt.executeQuery(sqlstax10111);
							if(tax1sql111.next()) {

								vendorcur=tax1sql111.getString("curid");	


							}

		     
							String taxcur1="";
							String gjjj = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
							 System.out.println("-----2--gjjj----"+gjjj) ;
							ResultSet r11 = stmt.executeQuery(gjjj);

							while (r11.next()) {
								venrate=r11.getDouble("rate");
								taxcur1=r11.getString("type");
							}

							double	dramt1=tax2; 


							double ldramt1=0;
							if(taxcur1.equalsIgnoreCase("D"))
							{


								ldramt1=dramt1/venrate ;  
							}

							else
							{
								ldramt1=dramt1*venrate ;  
							}



							String oops="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax2acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";

							//	System.out.println("--sql1----"+sql1);
							int aa1 = stmt.executeUpdate(oops);

							if(aa1<=0)
							{
								conn.close();
								return 0;

							}
							
						
						}
						
						
						
						*/
						
						
					/*	
						if(tax3acno>0)
						{
							System.out.println("=========================tax3acno===================================="+tax3acno);
							String pyy="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+tax3acno+"'";
							//System.out.println("---1----sqls10----"+sqls10) ;
							ResultSet tax1sql1111 = stmt.executeQuery(pyy);
							if(tax1sql1111.next()) {

								vendorcur=tax1sql1111.getString("curid");	


							}

		     
							String taxcur2="";
							String ttt = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									+"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
							 System.out.println("-----2--sqlvenselect----"+ttt) ;
							ResultSet r111 = stmt.executeQuery(ttt);

							while (r111.next()) {
								venrate=r111.getDouble("rate");
								taxcur2=r111.getString("type");
							}

							double	dramt1=tax3; 


							double ldramt1=0;
							if(taxcur2.equalsIgnoreCase("D"))
							{


								ldramt1=dramt1/venrate ;  
							}

							else
							{
								ldramt1=dramt1*venrate ;  
							}



							String eee="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+tax3acno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt1+","+ldramt1+",0,1,3,0,0,0,'"+venrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";

							//	System.out.println("--sql1----"+sql1);
							int aa1 = stmt.executeUpdate(eee);

							if(aa1<=0)
							{
								conn.close();
								return 0;

							}
							
						
						}
						*/
						 
						
						
						
					}
					
					
					
					
					
				//======================	
			     
			     
			     String clsql=" select cldocno from my_head where dtype='VND' and doc_no='"+venderaccount+"'";
			     
			     System.out.println("========clsql=========="+clsql);
			    ResultSet clrs= stmt.executeQuery(clsql);
			    
			    int vndcldocno=0;
			    if(clrs.next())
			    {
			    	vndcldocno=clrs.getInt("cldocno");
			    }
			     
			     
			     if(vndcldocno>0)
			     {
			    	 
			    	String sql1ss="update my_jvtran set cldocno='"+vndcldocno+"'  where acno='"+venderaccount+"' and tr_no='"+mastertr_no+"' and status=3  ";
			    	
			    	 System.out.println("========sql1ss=========="+sql1ss);
			    	stmt.executeUpdate(sql1ss);
			    	
			     }
			     
			     
			     
			     
			     
			    //=========================================================================== 
			     
			     
			     double jvdramount=0;
			     int id=0;
			     int adjustacno=0;
			     
			     String adjustcurrid="1";
			     
			     
			     double adjustcurrate=1;
			     
				 String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+mastertr_no+"'";
				    System.out.println("-----5--sqls3----"+sqls3) ;
				   ResultSet jvrs = stmt.executeQuery (jvselect);
					
					if (jvrs.next()) {
				
						jvdramount=jvrs.getDouble("dramount");	
						 
						
				              }
					 System.out.println("--jvdramount----"+jvdramount) ;
					if(jvdramount>0 || jvdramount<0)
					{
						
						
						if(jvdramount>0)
						{
							id=1;
								
							
						}
						
						else
						{
							
							id=-1;
						}
						
						
						
					     
						   String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
						 System.out.println("-----4--sql2----"+sql2) ;

					       ResultSet adjaccount = stmt.executeQuery (sqls2);
							
							if (adjaccount.next()) {
						
								adjustacno=adjaccount.getInt("acno");		
								
						        }
							
							
						
							 String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
							   //System.out.println("-----5--sqls3----"+sqls3) ;
							   ResultSet exptass3 = stmt.executeQuery (expsqls3);
								
								if (exptass3.next()) {
							
									adjustcurrid=exptass3.getString("curid");	
									 
									
							              }
								String adjustcurrencytype1="";
								 String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
									        +"where  coalesce(toDate,curdate())>='"+masterdate+"' and frmDate<='"+masterdate+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
								// System.out.println("---adjustsql----"+adjustsql) ;
									     ResultSet resultadj = stmt.executeQuery(adjustsql);
									         
									      while (resultadj.next()) {
									    	  adjustcurrate=resultadj.getDouble("rate");
									    	  adjustcurrencytype1=resultadj.getString("type");
									                 } 
									      
									      
									      double adjustldramounts=0 ;     
									      if(adjustcurrencytype1.equalsIgnoreCase("D"))
									      {
									      
									    	  adjustldramounts=jvdramount/adjustcurrate ;  
									      }
									      
									      else
									      {
									    	  adjustldramounts=jvdramount*adjustcurrate ;  
									      }
						
						
									      
									      
									      
									      String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											 		+ "values('"+masterdate+"','"+refdetails+"',"+docno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',3,0,0,0,'"+adjustcurrate+"',0,0,'PIV','"+brhid+"',"+mastertr_no+",3)";
									     
									     
										// System.out.println("---sql11----"+sql11) ; 
									 
											 int result1 = stmt.executeUpdate(adjustsql11);

										     if(result1<=0)
												{
													conn.close();
													return 0;
													
												}
										     	      
						
						
						
					}
					
					String sqssl="truncate my_bgrnfd";
					stmt.executeUpdate(sqssl);
					
					if(cosrcodemethod>0) 
					{
						
						String upcostsql1="update my_jvtran  set costtype='"+itermtype+"',costcode='"+costtrno+"' where tr_no="+mastertr_no+" ";
						stmt.executeUpdate(upcostsql1);
						
						 
						
						if(itermtype>0)
						{

							 int TRANIDs=0;
							 int sno=0;
	                         int accounts=0;
						     double finalamt=0;  
						     Statement sss=conn.createStatement();
						     Statement stmtg=conn.createStatement();
						
								String trsqlss="  select j.tranid,j.acno,j.tr_no,dramount nettotal from my_jvtran j inner join my_head h on j.acno=h.doc_no where gr_type in (4,5) and  j.tr_no="+mastertr_no+"     ";
						
								ResultSet tass111 = sss.executeQuery (trsqlss);
								
								while (tass111.next()) {
									sno=sno+1;
									TRANIDs=tass111.getInt("tranid");	
									accounts=tass111.getInt("acno");	
									finalamt=tass111.getDouble("nettotal");	
											if(accounts>0)
											{
											String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+accounts+"', "
													+ " "+itermtype+","+finalamt+","+costtrno+","+TRANIDs+","+mastertr_no+")";
													 
									  int costabsq=  stmtg.executeUpdate(ssql);
									  
									  if(costabsq<=0)
										{
											conn.close();
											return 0;
											
										   }
											
									     }
								}
								
							
						}
						
						
					}
				
				
			//	System.out.println("sssssss"+docno);
				if (docno > 0) {
					 
					stmtpuchase.close();
				 
					return vocno;
				}
			}catch(Exception e){	
				conn.close();
			e.printStackTrace();	
			}
			return 0;
		   }
			
	  

		
		
		


	

}
