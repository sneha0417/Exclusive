package com.dashboard.cargo.quotationfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 

import net.sf.json.JSONArray;

public class ClsQuotationFollowupDAO {

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	
	public   JSONArray listsearch(String branch,String fromdate,String todate,String status,String reqdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
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
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
      	if((!(reqdocno.equalsIgnoreCase("NA")) )&&(!(reqdocno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+reqdocno+"'";
 		}
    	
    	 
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();  
			      			 
				Statement stmt = conn.createStatement ();     //and mm.clstatus=0 and mm.jobno=0 and 
		 			 
				
	/*			String sql=" select eqd.doc_no enqdetdocno, mm.doc_no,mm.voc_no,mm.date,eq.voc_no enqno,ac.refname client,bv.fdate, mm.brhid,mm.remarks desc1"
						+ " ,eqd.pol,eqd.pod ,md.modename mode "
						+ "  from cr_qotm mm left join cr_enqm eq on eq.doc_no=mm.rrefno left join cr_enqd eqd on eqd.rdocno=eq.doc_no "
						+ "  left join cr_qotd dd on dd.rdocno=mm.doc_no"
						+ "    left join my_acbook ac on ac.cldocno=mm.cldocno and ac.dtype='CRM' left join cr_mode md on md.doc_no=eqd.modeid  "
				 		+ " left join (select max(b.doc_no) doc_no,rdocno from cr_caqf b where rrefno=1 group by  rdocno) "
	        			+ "  b on(b.rdocno=mm.doc_no) left join  cr_caqf bv on b.doc_no=bv.doc_no     "
	        			+ "  where   mm.status=3 and  mm.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest+"   "
	        					+ " and  mm.clstatus=0 and  (eqd.qty-eqd.out_qty)>0  group by eqd.doc_no  ";
				
				*/
				
		         
//				String sql="  select  eqd.doc_no enqdetdocno, mm.doc_no,mm.voc_no,sl.sal_name salesman,mm.date,eq.voc_no enqno,ac.refname client, "
//						+ "   bv.fdate, mm.brhid,mm.remarks desc1 ,eqd.pol,eqd.pod ,md.modename mode,eqd.qty,eqd.out_qty from cr_qotm mm "
//						+ "  left join cr_qotd dd on dd.rdocno=mm.doc_no "
//						+ "  left join cr_enqm eq on eq.doc_no=mm.rrefno left join cr_enqd eqd on eqd.rdocno=eq.doc_no  and dd.refdocno=eqd.doc_no "
//						+ "    left join my_acbook ac on ac.cldocno=mm.cldocno and ac.dtype='crm' left join my_salm sl on ac.sal_id=sl.doc_no "
//						+ "    left join cr_mode md on md.doc_no=eqd.modeid "
//						+ "   left join (select max(b.doc_no) doc_no,rdocno from cr_caqf b where rrefno=1 group by  rdocno) "
//						+ "   b on(b.rdocno=eqd.doc_no) left join  cr_caqf bv on b.doc_no=bv.doc_no "
//						+ "   where   mm.status=3 and  mm.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest+"   "
//						+ "     and  eqd.clstatus=0 and  (eqd.qty-eqd.out_qty)>0   group by eqd.doc_no ";

				String sql=" select  eqd.doc_no enqdetdocno, mm.doc_no,mm.voc_no,sl.sal_name salesman,mm.date,eq.voc_no enqno,ac.refname client, "
						+ " bv.fdate, mm.brhid,mm.remarks desc1 ,eqd.pol,eqd.pod ,md.modename mode,eqd.qty,eqd.out_qty "
						+ " from cr_enqm eq left join cr_enqd eqd on eqd.rdocno=eq.doc_no "
						+ " left join  cr_qotm mm  on eq.doc_no=mm.rrefno left join cr_qotd dd on dd.rdocno=mm.doc_no and dd.refdocno=eqd.doc_no "
						+ " left join my_acbook ac on ac.cldocno=mm.cldocno and ac.dtype='crm' left join my_salm sl on ac.sal_id=sl.doc_no "
						+ " left join cr_mode md on md.doc_no=eqd.modeid "
						+ " left join (select max(b.doc_no) doc_no,rdocno from cr_caqf b where rrefno=1 group by  rdocno) "
						+ " b on(b.rdocno=eqd.doc_no) left join  cr_caqf bv on b.doc_no=bv.doc_no "
						+ " where   mm.status=3 and  mm.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest+"   "
						+ " and  eqd.clstatus=0 and  (eqd.qty-eqd.out_qty)>0   group by eqd.doc_no ";

			 System.out.println("-----qtnfup grid------"+sql);
			 
            		   ResultSet resultSet = stmt.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		   stmt.close();
     				
            
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
				Statement stmt = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from cr_caqf m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"' and  m.rrefno=1     group by m.doc_no ";
///System.out.println("=======sql=="+sql);
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmt.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
}
