package com.cargo.costingforinvoicing;

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

public class ClsCostingForInvoicingDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	
	
	 public JSONArray refSearchMasters(HttpSession session,String docnoss,String mobno,String aa,String client,String refno) throws SQLException {
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
	        String brhid = session.getAttribute("BRANCHID").toString(); 
	        
	        System.out.println("====="+aa);
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sqltest="";
			    java.sql.Date  sqlDate = null;
			    if(!aa.equalsIgnoreCase("yes")){
			    	return RESULTDATA;
			    }
			    else{
			  	 
			       	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
			      		sqltest+=" and l1.jobno like '%"+docnoss+"%'";
			      	}
			  	    
			      	if((!(client.equalsIgnoreCase(""))) && (!(client.equalsIgnoreCase("NA")))){
			      		sqltest+=" and l1.refname like '%"+client+"%'  ";
			      	}
			      	
			    	if((!(mobno.equalsIgnoreCase(""))) && (!(mobno.equalsIgnoreCase("NA")))){
			      		sqltest+=" and l1.per_mob = '"+mobno+"'  ";
			      	}
			    	
			    	if((!(refno.equalsIgnoreCase(""))) && (!(refno.equalsIgnoreCase("NA")))){
			      		sqltest+=" and l1.refno = '"+refno+"'  ";
			      	}
			    	
			    	
			   
 		    	
			    	
			    	String   sql=" select  l1.brhid, masterdocno,l1.refname,l1.date,per_mob mob ,l1.jobno,l1.refno,l1.job,l1.rdocno,l1.refdocno from( "
			    			+ "  select d.refdocno,d.rdocno,l.jobno job,cc.doc_no,cc.pstatus ,  m.brhid,mm.tr_no masterdocno, a.per_mob,a.refname, "
			    			+ "  m.date,mm.doc_no jobno,mm.refno ,m.voc_no from cr_qotm m left join cr_qotd d on m.doc_no=d.rdocno "
			    			 + " 	left join cr_enqm em on m.rrefno=em.doc_no  and m.reftype='ENQ'  left join cr_enqd ed on em.doc_no=ed.rdocno and ed.doc_no=d.refdocno  "
			    			 + "   	left join cr_joblist l on l.enqdocno=ed.doc_no  left join cm_srvcontrm mm on mm.tr_no=l.jobno "
			    			  + "     left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' "
			    			  + "      left join cr_assignment cc on cc.rdocno=d.doc_no  and l.jobno=cc.jobno "
			    			 + "       where cc.doc_no is not null and cc.pstatus=1 group by cc.jobno ) l1 "
			    			       + "  left join( select jobno,coalesce(count(srvtype),0) nos1 from cr_assignment  where srvtype>0 group by jobno) aa1  on aa1.jobno=l1.job "
			    			 + "  left join(select count(typeid)  nos2 ,rdocno,refdocno from cr_qotd group by rdocno,refdocno) aa2  on aa2.rdocno=l1.rdocno and aa2.refdocno=l1.refdocno "
			    			   + "     left join(select jobno,coalesce(count(pstatus),0) nos "
			    			     + "   from cr_assignment where pstatus=0 group by jobno) aa on aa.jobno=l1.job "
			    			     + "   	 left join cr_cfim cf on cf.refno=l1.job where  coalesce(nos,0)=0 and coalesce(nos1,0)=coalesce(nos2,0) and "
			    			       + "      l1.brhid='"+brhid+"' and cf.refno is null "+sqltest+"  " ;
			     
			        System.out.println("--job listing sql--"+sql);
	/*		    	
			      	String sql="select brhid, masterdocno,refname,date,per_mob mob ,jobno,refno from( "
			      			+ " select m.brhid,mm.tr_no masterdocno, a.per_mob,a.refname,m.date,mm.doc_no jobno,mm.refno ,m.voc_no,  coalesce(nos,0) nos from cr_qotm m "
			      			+ " left join cm_srvcontrm mm on mm.tr_no=m.jobno left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' "
			      			+ " left join cr_cfim mm1 on mm1.refno=m.jobno  "
			      			+ " left join(select rdocno,coalesce(count(pstatus),0) nos from cr_qotd where pstatus=0 group by rdocno) aa on aa.rdocno=m.doc_no where mm1.refno is null  ) l "
			      			+ " where coalesce(nos)=0  and l.brhid='"+brhid+"' "+sqltest;*/
			   
					ResultSet resultSet = stmtCRM.executeQuery (sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
					stmtCRM.close();
					conn.close();
			    }
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
	 
	 
	 public JSONArray estmDataLoad(String docno) throws SQLException { 
	 
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	       
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement(); 
/*				String sql="select  if(l.agtype=1,aa.refname,ss.sal_name) name, if(l.agtype=1,'Vendor','Own') atype, 1 status,s.srvtype sertype,"
						+ " d.typeid srvdocno,cr.code currency,d.curid,convert(d.rate,char(50)) rate,convert(d.price,char(50)) price,"
						+ " convert(d.qty,char(50)) qty,d.uom unitid,u.unit uom,convert(d.total,char(50)) total,convert(d.btotal,char(50))  basetotal,d.billing,"
						+" d.vndid  from cr_qotm m  left  join  cr_qotd d  on d.rdocno=m.doc_no left join cr_srvtype s on d.typeid=s.doc_no"
						+ " left join my_curr cr on cr.doc_no=d.curid  left join cr_qotd d on m.doc_no=d.rdocno "
						+ " left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ' "
						+ "  left join cr_enqd ed on em.doc_no=ed.rdocno "
						+ " left join cr_joblist l on l.enqdocno=ed.doc_no   left join cr_assignment cc on cc.rdocno=d.doc_no and l.jobno=cc.jobno  "
						+" left join my_acbook aa on aa.cldocno=d.agto and aa.dtype='VND' and l.agtype=1"
						+ " left join my_salesman ss on ss.doc_no=d.agto and sal_type='STF' and l.agtype=2 "
						+ "  left join my_unitm u on u.doc_no=d.uom   where  where cc.doc_no is not null cc.jobno="+docno+" and cc.pstaus=1  " ;
				
				*/
				String sql=" select  s.acno,h.atype actype,h.description,h.account,h.gr_type, if(cc.agtype=1,aa.refname,ss.sal_name) name, if(cc.agtype=1,'Vendor','Own') atype, "
						+ " 1 status,convert(if(m.brhid=2,concat('Job: ',ct.doc_no,'-',ct.refno,'-',s.srvtype,coalesce(sm.submode,''),' - ',cc.equipment ,' - ' , if(cc.agtype=1,aa.refname,ss.sal_name)  ),s.srvtype),char(50)) sertype, d.typeid srvdocno,cr.code currency,d.curid,convert(d.rate,char(50)) rate, "
						+ " convert(d.price,char(50)) price, convert(d.qty,char(50)) qty,d.uom unitid,u.unit uom, "
						+ " convert(d.total,char(50)) total,convert(d.btotal,char(50))  basetotal,d.billing, d.vndid "
						+ " from cr_qotm m left  join  cr_qotd d  on d.rdocno=m.doc_no left join cr_srvtype s on d.typeid=s.doc_no "
						+ " left join my_curr cr on cr.doc_no=d.curid left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ' " 
				    	+ " left join cr_enqd ed on em.doc_no=ed.rdocno and ed.doc_no=d.refdocno left join cr_joblist l on l.enqdocno=ed.doc_no "
				     	+ " left join cr_assignment cc on cc.rdocno=d.doc_no and l.jobno=cc.jobno "
				      	+ " left join my_acbook aa on aa.cldocno=cc.agto and aa.dtype='VND' and cc.agtype=1 left join my_head h on h.doc_no=s.acno "
				      	+ " left join my_salesman ss on ss.doc_no=cc.agto and sal_type='STF' and cc.agtype=2 "
				      	+ " left join my_unitm u on u.doc_no=d.uom left join cr_smode  sm on ed.smodeid=sm.doc_no "
				      	+ " left join cm_srvcontrm ct on l.jobno=ct.tr_no "
				      	+ " where    cc.doc_no is not null  and cc.jobno="+docno+" and cc.pstatus=1  ";
						
						
						
						
						 
				System.out.println("==estmsql=="+sql);
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	 }
	
	 
	 
	 public JSONArray expDataLoad(HttpSession session,String docno) throws SQLException { 
		 
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	       String branchid=session.getAttribute("BRANCHID")+"";
			try {
				/*if(!docno.equalsIgnoreCase("0")){
					*/
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql="select "+commonDAO.getFinanceVocTablesCase(conn)+"  a.date,a.transtype,a.brhid,a.description acname,a.desc1,a.account,a.acno,a.amount from "
					+" (select  j.date,j.doc_no transno,j.dtype transtype,j.brhid,h.description,j.description desc1, h.account,j.acno,j.dramount amount "
					+ "from my_costtran c inner join my_jvtran j on j.tranid=c.tranid "
					+" left join my_head h on h.doc_no=j.acno "
					+"  where c.costtype='4' and jobid='"+docno+"' and j.dtype!='SRS' and j.brhid="+branchid+" ) a  "+commonDAO.getFinanceVocTablesJoins(conn) ;
//				System.out.println("==estmsql=="+sql);
				ResultSet resultSet = stmtCRM.executeQuery (sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
/*
				}*/
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	 }

	 
	 
	 public JSONArray masterSearch(HttpSession session, String date,String docno,String jobno,String refno,String id) throws SQLException {
	 
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
	        String brhid = session.getAttribute("BRANCHID").toString(); 
		 
	        Connection conn = null;
	        System.out.println("----dao----");
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				java.sql.Date sqlDate=null;
		        String sqltest="";
		        if(!date.equalsIgnoreCase("")){
					sqlDate=commonDAO.changeStringtoSqlDate(date);
					sqltest+= " and m.date='"+sqlDate+"'";
				}
		        if(!jobno.equalsIgnoreCase("")){
					sqltest+=" and cm.doc_no ="+jobno+"";
				}
		        if(!docno.equalsIgnoreCase("")){
					sqltest+=" and m.voc_no = "+docno+" ";
				}
		        if(!refno.equalsIgnoreCase("")){
					sqltest+=" and m.refnos = "+refno+" ";
				}
				String sql=" select m.voc_no,m.date,m.desc1,cm.doc_no jobno,m.refno mastertrno,m.refnos "
						+ "  from cr_cfim m left join cm_srvcontrm cm on cm.tr_no=m.refno where m.status<>7 and m.brhid='"+brhid+"' "+sqltest+" ";
				System.out.println("==searchsql=="+sql);
				ResultSet resultSet = stmtCRM.executeQuery (sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	 }
	 

	public int saveData(int masterdoc_no, int mastertr_no, int refno, 
			Date masterdate, String mode, String formdetailcode,
			String txtRemarks, String refnos, HttpSession session,
			HttpServletRequest request, ArrayList<String> descarray,int vocno,String mawb, String mbl, String hawb, String hbl,
			String shipper, String consignee, String carrier, String flightno, String voage,
			String eta, String etd, String ttime, String boe, String contno,
			String truckno) throws SQLException {
		
		Connection conn=null;
		try
		{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
		 
			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("D"))
			{
				
				CallableStatement stmtsave= conn.prepareCall("{call cr_costingForInvoicingDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				
				if(mode.equalsIgnoreCase("A"))
				{
					
					stmtsave.registerOutParameter(16, java.sql.Types.INTEGER);
					stmtsave.registerOutParameter(18, java.sql.Types.INTEGER);
				}
				else
				{
					stmtsave.setInt(16,masterdoc_no);
					stmtsave.setInt(18,vocno);
				}
						
				String acctype="AR";
				String cmbcurr="1";
				String accdoc="0";
				String currate="1";
				 Statement stmt=conn.createStatement();
				String sqls=" select h.atype,h.curid,h.rate,a.acno from cr_qotm  m "
						+ " left join my_acbook a on a.cldocno=m.cldocno and  a.dtype='CRM' "
						+ " left join my_head h on h.doc_no=a.acno   left join cr_qotd d on m.doc_no=d.rdocno "
						+ " left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ'  left join cr_enqd ed on em.doc_no=ed.rdocno and ed.doc_no=d.refdocno "
						+ "  	left join cr_joblist l on l.enqdocno=ed.doc_no where l.jobno="+mastertr_no+" group by l.jobno ";
				
			
				System.out.println("=====sqls==="+sqls);
				
				
				
				ResultSet rss0101=stmt.executeQuery(sqls);
				if(rss0101.next())
				{acctype=rss0101.getString("atype");
				cmbcurr=rss0101.getString("curid");
				accdoc=rss0101.getString("acno");
				currate=rss0101.getString("rate");
				}
			
				stmtsave.setDate(1,masterdate);
				stmtsave.setInt(2,mastertr_no);
				stmtsave.setString(3,acctype);
				stmtsave.setString(4,accdoc);
				stmtsave.setString(5,cmbcurr);
				stmtsave.setString(6,currate);
				stmtsave.setString(7,"");
				stmtsave.setString(8,"");
				stmtsave.setString(9,txtRemarks);
				stmtsave.setDate(10,masterdate);
				stmtsave.setDouble(11,0);
				stmtsave.setString(12,formdetailcode);
				stmtsave.setString(13,session.getAttribute("USERID").toString());
				stmtsave.setString(14,session.getAttribute("BRANCHID").toString());
				stmtsave.setString(15,"DIR");
				stmtsave.setString(17,mode);
				stmtsave.setInt(19,0);
 	 
				int aa=stmtsave.executeUpdate();
				
				
				masterdoc_no=stmtsave.getInt("docNo");
				 vocno=stmtsave.getInt("vocNo");
				request.setAttribute("vocno", vocno);
				
				
				
				if(aa<=0)
				{
					conn.close();
					return 0;
					
				}
				
				if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E"))
				{
						
					String sqls111="update cr_cfim set mawb='"+mawb+"', mbl='"+mbl+"', hawb='"+hawb+"', hbl='"+hbl+"',shipper='"+shipper+"',"
							+ "  consignee ='"+consignee+"', carrier ='"+carrier+"', flightno ='"+flightno+"', voage ='"+voage+"',eta ='"+eta+"', etd ='"+etd+"', "
									+ "ttime='"+ttime+"', boe='"+boe+"', contno='"+contno+"',truckno='"+truckno+"' where doc_no='"+masterdoc_no+"'  ";
									 
					stmtsave.executeUpdate(sqls111);
				
				for(int i=0;i< descarray.size();i++){
					
					String[] purorderarray=descarray.get(i).split("::");
					
					
					if(i==0)
						
					{
						stmtsave.executeUpdate("delete from cr_cfid where rdocno= "+masterdoc_no+" ");
						
					}
					
					
				    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
				     {
				    	
			
			    		 String sql="INSERT INTO cr_cfid(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,taxamount,nettaxamount,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
							       + " ("+(i+1)+","
							       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
							       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
							       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
							       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
							       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
							       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
							       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
							       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
							       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
							       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
							       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
							       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
							       + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
							       + "'"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"',"
							       + "'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"',"
							       + "'"+session.getAttribute("BRANCHID").toString()+"',"
							       +"'"+masterdoc_no+"')";
			    		// System.out.println("__saled--"+sql);
			    		 int resultSet2 = stmtsave.executeUpdate(sql);
					     
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
				     }
					
					
					
				}	
				
				}
				
				if(masterdoc_no>0)
				{
					
					conn.commit();
					conn.close();
					return masterdoc_no;
				}
				
				
				
				
				
			}
			
			
			if(mode.equalsIgnoreCase("S"))
			{
				
				double nettotal=0;
				double taxamount=0;
				double nettaxamont=0;
				Statement stmt111=conn.createStatement();
				String sqlss="SELECT sum(nettotal) nettotal,coalesce(sum(taxamount),0) taxamount,sum(nettotal+coalesce(taxamount,0)) nettaxamont "
						+ " FROM cr_cfid where rdocno='"+masterdoc_no+"' ";
				
				System.out.println("=============sqlss======masterdoc_no========"+sqlss);
				
				ResultSet rsss=stmt111.executeQuery(sqlss);
				
				if(rsss.first())
				{
					nettotal=rsss.getDouble("nettotal");
					taxamount=rsss.getDouble("taxamount");
					nettaxamont=rsss.getDouble("nettaxamont");
					
				}
				
				
				
				String acctype="AR";
				String cmbcurr="1";
				String accdoc="0";
				String currate="1";
				 Statement stmt=conn.createStatement();
				/*String sqls=" select h.atype,h.curid,h.rate,a.acno from cr_qotm  m "
						+ " left join my_acbook a on a.cldocno=m.cldocno and  a.dtype='CRM' left join my_head h on h.doc_no=a.acno   where m.jobno="+mastertr_no+" ";
				*/
				/* String sqls=" select h.atype,h.curid,h.rate,a.acno from cr_qotm  m "
							+ " left join my_acbook a on a.cldocno=m.cldocno and  a.dtype='CRM' "
							+ " left join my_head h on h.doc_no=a.acno   left join cr_qotd d on m.doc_no=d.rdocno "
							+ " left join cr_enqm em on m.rrefno=em.doc_no and m.reftype='ENQ'  left join cr_enqd ed on em.doc_no=ed.rdocno "
							+ "  	left join cr_joblist l on l.enqdocno=ed.doc_no where l.jobno="+mastertr_no+" group by l.jobno ";
				 */
				 
				 String sqls="select type atype,acno,curid,rate from cr_cfim where doc_no='"+masterdoc_no+"' ";
				 
				 
				 
					//select type,acno,curid,rate from cr_cfim where doc_no='"+masterdoc_no+"';
				ResultSet rss0101=stmt.executeQuery(sqls);
				if(rss0101.next())
				{acctype=rss0101.getString("atype");
				cmbcurr=rss0101.getString("curid");
				accdoc=rss0101.getString("acno");
				currate=rss0101.getString("rate");
				}
			
				
				
				CallableStatement stmtnipurchase= conn.prepareCall("{call ServiceSaleDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				stmtnipurchase.registerOutParameter(16, java.sql.Types.INTEGER);
				
				java.sql.Date sqlStartDate=masterdate;
				
				stmtnipurchase.setInt(18, java.sql.Types.INTEGER);
				stmtnipurchase.setDate(1,sqlStartDate);
				stmtnipurchase.setString(2,refnos);
				stmtnipurchase.setString(3,acctype);
				stmtnipurchase.setString(4,accdoc);
			   	stmtnipurchase.setString(5,cmbcurr);
				stmtnipurchase.setString(6,currate);
				stmtnipurchase.setString(7,"");
				stmtnipurchase.setString(8,"");
				stmtnipurchase.setString(9,txtRemarks);
				stmtnipurchase.setDate(10,sqlStartDate);
				stmtnipurchase.setDouble(11,nettotal);
				stmtnipurchase.setString(12,"SRS");
				stmtnipurchase.setString(13,session.getAttribute("USERID").toString());
				stmtnipurchase.setString(14,session.getAttribute("BRANCHID").toString());
				stmtnipurchase.setString(15,formdetailcode);
				stmtnipurchase.setString(17,"A");
				stmtnipurchase.setInt(19,0);
//				System.out.println("--stmtnmipurchase-- "+stmtnipurchase.toString());
		 
				stmtnipurchase.executeQuery();
			 	int docno=stmtnipurchase.getInt("docNo");
				int mastervocno=stmtnipurchase.getInt("vocNo");
				
				 
				if(docno<=0)
				{
					conn.close();
					return 0;
					
				}
				
				
				
				
				
				Statement stm2=conn.createStatement();
				
				double fdramt=0;
				double tdramt=0;
				
				
				int sno=0;
				String refdetails="SRS"+""+mastervocno;
				
				
				String jvdesc=refdetails;  
				int tranno=0;
				String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
			
				ResultSet tass = stm2.executeQuery (trsql);
				
				if (tass.next()) {
			
					tranno=tass.getInt("trno");		
					
			     }
				int iapprovalStatus=3;
				
				int count=0;
				String appsql="select count(*)   icount from my_apprmaster where status=3 and dtype='SRS' ";
				
				ResultSet appsqlrs = stm2.executeQuery(appsql);
				
				if (appsqlrs.next()) {
			
					count=appsqlrs.getInt("icount");		
					
			     }
				if(count==0)
				{
					
					iapprovalStatus=3;
					
					
				}
				else
				{
					iapprovalStatus=0;
				}
				
				
				
				
				String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
				
				int dd=stm2.executeUpdate(trnosql);
			     
						 if(dd<=0)
							{
								conn.close();
								return 0;
								
							}
						 
						String sqlsss="update cr_cfim  set tr_no='"+tranno+"' where doc_no='"+masterdoc_no+"' ";
						stm2.executeUpdate(sqlsss);
						 
						 
							for(int i=0;i< descarray.size();i++){
								
								String[] purorderarray=descarray.get(i).split("::");
								String newjvdesc=jvdesc+"  "+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim());
								 
								
								if(i==0){
					 
									double dramt=nettaxamont;
									double as=Double.parseDouble(currate);
									double ldramt=dramt*as;
									
									String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
									 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+accdoc+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
									 
//								   System.out.println("client account sql ="+sql1);
									 int ss = stmtnipurchase.executeUpdate(sql1);

								     if(ss<=0)
										{
											conn.close();
											return 0;
										}
									
								   }
							
 
								 
						    	 
							    if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
							     {
						
						    		 String sql="INSERT INTO my_srvsaled(srno,qty,desc1,unitprice,total,discount,nettotal,taxper,tax,nettaxamount,nuprice,costtype,costcode,remarks,acno,brhid,rdocno)VALUES"
										       + " ("+(i+1)+","
										       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
										       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
										       + "'"+(purorderarray[3].trim().equalsIgnoreCase("undefined") || purorderarray[3].trim().equalsIgnoreCase("NaN")||purorderarray[3].trim().equalsIgnoreCase("")|| purorderarray[3].isEmpty()?0:purorderarray[3].trim())+"',"
										       + "'"+(purorderarray[4].trim().equalsIgnoreCase("undefined") || purorderarray[4].trim().equalsIgnoreCase("NaN")||purorderarray[4].trim().equalsIgnoreCase("")|| purorderarray[4].isEmpty()?0:purorderarray[4].trim())+"',"
										       + "'"+(purorderarray[5].trim().equalsIgnoreCase("undefined") || purorderarray[5].trim().equalsIgnoreCase("NaN")||purorderarray[5].trim().equalsIgnoreCase("")|| purorderarray[5].isEmpty()?0:purorderarray[5].trim())+"',"
										       + "'"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"',"
										       + "'"+(purorderarray[7].trim().equalsIgnoreCase("undefined") || purorderarray[7].trim().equalsIgnoreCase("NaN")||purorderarray[7].trim().equalsIgnoreCase("")|| purorderarray[7].isEmpty()?0:purorderarray[7].trim())+"',"
										       + "'"+(purorderarray[8].trim().equalsIgnoreCase("undefined") || purorderarray[8].trim().equalsIgnoreCase("NaN")||purorderarray[8].trim().equalsIgnoreCase("")|| purorderarray[8].isEmpty()?0:purorderarray[8].trim())+"',"
										       + "'"+(purorderarray[9].trim().equalsIgnoreCase("undefined") || purorderarray[9].trim().equalsIgnoreCase("NaN")||purorderarray[9].trim().equalsIgnoreCase("")|| purorderarray[9].isEmpty()?0:purorderarray[9].trim())+"',"
										       + "'"+(purorderarray[10].trim().equalsIgnoreCase("undefined") || purorderarray[10].trim().equalsIgnoreCase("NaN")||purorderarray[10].trim().equalsIgnoreCase("")|| purorderarray[10].isEmpty()?0:purorderarray[10].trim())+"',"
										       + "'"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"',"
										       + "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"
										       + "'"+(purorderarray[13].trim().equalsIgnoreCase("undefined") || purorderarray[13].trim().equalsIgnoreCase("NaN")||purorderarray[13].trim().equalsIgnoreCase("")|| purorderarray[13].isEmpty()?0:purorderarray[13].trim())+"',"
										       + "'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"',"
										       + "'"+session.getAttribute("BRANCHID").toString()+"',"
										       +"'"+docno+"')";
						    		// System.out.println("__saled--"+sql);
						    		 int resultSet2 = stmtnipurchase.executeUpdate(sql);
								     
								     if(resultSet2<=0)
										{
											conn.close();
											return 0;
											
										}
								     String acno1=""+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"";
								     int acno=Integer.parseInt(acno1);
								     String tmp=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
								     fdramt=Double.parseDouble(tmp)*1;
								     tdramt=fdramt*Double.parseDouble(currate);
								    
								     String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
							 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
					 				+ "'"+newjvdesc+"', "+ "'"+cmbcurr+"','"+currate+"','"+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:Double.parseDouble(purorderarray[6].trim())*-1)+"',"+tdramt*-1+",0,-1,5,"+(i+1)+",0,0,0,'SRS', "
									+ "'"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"','"+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+"', "
									+ "'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"')";
									     
								   //  System.out.println("other account sql ="+don);	
								int samp=stmtnipurchase.executeUpdate(don);

								     
								 if(samp<=0)
									{
										conn.close();
										return 0;
										
									}
										//}
								   
								 
								 
								 
								 if(!(purorderarray[11].trim().equalsIgnoreCase("undefined")|| purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty() ||purorderarray[11].trim().equalsIgnoreCase("0")))
							     {
									 int TRANID=0;
									 sno=sno+1;
									  String tmp1=""+(purorderarray[6].trim().equalsIgnoreCase("undefined") || purorderarray[6].trim().equalsIgnoreCase("NaN")||purorderarray[6].trim().equalsIgnoreCase("")|| purorderarray[6].isEmpty()?0:purorderarray[6].trim())+"";
									  double  fdramt1=Double.parseDouble(tmp1)*1;
								    		
								
										String trsqlss="SELECT coalesce(max(TRANID),1) TRANID FROM my_jvtran where tr_no="+tranno+" and acno='"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"' ";
								System.out.println("==========trsqlss=========="+trsqlss);
										
										ResultSet tass1 = stmtnipurchase.executeQuery (trsqlss);
										
										if (tass1.next()) {
									
											TRANID=tass1.getInt("TRANID");	
										
										
											
									     }
										
										String ssql="insert into my_costtran(sr_no,acno,costtype,amount,jobid,tranid,tr_no) values("+sno+",'"+(purorderarray[14].trim().equalsIgnoreCase("undefined") || purorderarray[14].trim().equalsIgnoreCase("NaN")||purorderarray[14].trim().equalsIgnoreCase("")|| purorderarray[14].isEmpty()?0:purorderarray[14].trim())+"', "
												+ " "+(purorderarray[11].trim().equalsIgnoreCase("undefined") || purorderarray[11].trim().equalsIgnoreCase("NaN")||purorderarray[11].trim().equalsIgnoreCase("")|| purorderarray[11].isEmpty()?0:purorderarray[11].trim())+","+fdramt1+",'"+(purorderarray[12].trim().equalsIgnoreCase("undefined") || purorderarray[12].trim().equalsIgnoreCase("NaN")||purorderarray[12].trim().equalsIgnoreCase("")|| purorderarray[12].isEmpty()?0:purorderarray[12].trim())+"',"+TRANID+","+tranno+")";
										System.out.println("==========trsqlss=========="+trsqlss);		 
								  int costabsq=  stmtnipurchase.executeUpdate(ssql);
								  
								  if(costabsq<=0)
									{
										conn.close();
										return 0;
										
									}
								  
							     }
									String updat="update  my_srvsalem set tr_no="+tranno+",invno='"+refno+"',invdate='"+masterdate+"'  where doc_no="+docno+"  ";
									  int tabs=  stmtnipurchase.executeUpdate(updat);
									  if(tabs<=0)
										{
											conn.close();
											return 0;
										}
							     }
						     }
							
							
							    String upsql="select method from gl_config where field_nme like'tax'";
							    ResultSet resultSet = stmt.executeQuery(upsql);
							    int docval = 0;
							    if(resultSet.next())
							    {
							    	docval=resultSet.getInt("method");
							    }		  
								if(docval==0)
								 {
									 String upsql2="select method from gl_prdconfig where field_nme like'tax'";
								     ResultSet resultSet2 = stmt.executeQuery(upsql2);
								    if (resultSet2.next()) {
								    	docval=resultSet2.getInt("method");
								     }
								 }
					 
								System.out.println("===docval====="+docval);
					 if(docval>0)
						 
					 {	
						 
						 
						 String newjvdesc=jvdesc;
						 Statement stmtt2=conn.createStatement();
						 double amount,dramt=0,as,ldramt = 0;
		    			 long acno=0;
		    			 double taxperc=0;
		    			 String upsql1=" select doc_no docno,acno,per,cstper from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		    			 System.out.println("===upsql1====="+upsql1);
		    			 ResultSet resultSet4 = stmtt2.executeQuery(upsql1);
		 		    	 while(resultSet4.next()){
		 		    		amount=((taxamount)*-1);
		    			 	dramt=amount;
			 				as=Double.parseDouble(currate);
			 				ldramt=dramt*as;
			 				acno=resultSet4.getLong("acno");
		 		    	 }
			 				String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 				 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+acno+"','"+newjvdesc+"','"+cmbcurr+"','"+currate+"',"+dramt+","+ldramt+",0,-1,5,0,0,0,0,0,0,'SRS','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",'"+iapprovalStatus+"')";
			 				 System.out.println("===sql1====="+sql1); 
 	 			 	  System.out.println("===taxperc====="+taxperc); 
			 			if(taxamount>0 && acno>0){	 
			 				int ss = stmtnipurchase.executeUpdate(sql1);
//			 				 
			 			     if(ss<=0)
			 					{
			 						conn.close();
			 						return 0;
			 						
			 					}
			 			}
						 
					 }
						
					 
						if (docno > 0) {
							conn.commit();
							stmtnipurchase.close();
							conn.close();
							return docno;
						}
				
			} 
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			conn.close();
		}
		
		 
		return 0;
	}


	public   JSONArray reloadsrv(String nidoc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
 
	    
	    Connection conn = null;
		try {
				 conn = connDAO.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.nuprice,d.acno headdoc,h.gr_type grtype ,"
	        			+ "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup,d.taxper,d.tax taxperamt,d.nettaxamount taxamount "
	        			+ " from cr_cfid d left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype "
	        			+ "  where d.rdocno='"+nidoc+"'  ");
	        //	System.out.println("========"+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=commonDAO.convertToJSON(resultSet); 
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
	
	
	
	public ClsCostingForInvoicingBean getViewDetails(int docno, HttpSession session) throws SQLException {
	 
		ClsCostingForInvoicingBean bean=new ClsCostingForInvoicingBean();
		Connection conn=null;
		try
		{
			conn=connDAO.getMyConnection();
			
		Statement stmt=conn.createStatement();
		
		String sql=" select   mawb, mbl,hawb, hbl, shipper, consignee, carrier, flightno, Voage, etd, eta, ttime, boe, contno, truckno ,"
				+ " m.doc_no, m.voc_no,m.date,m.desc1,cm.doc_no jobno,m.refno ,m.refnos "
				+ "  from cr_cfim m left join cm_srvcontrm cm on cm.tr_no=m.refno  "
				+ " where m.voc_no="+docno+" and m.brhid='"+session.getAttribute("BRANCHID").toString()+"' ";
		ResultSet rsss=stmt.executeQuery(sql);
		
		
		if(rsss.first())
		{
			
			bean.setHidestmDate(rsss.getString("date"));
			bean.setRefno(rsss.getInt("jobno"));
			bean.setMasterdoc_no(rsss.getInt("doc_no"));
			bean.setRefnos(rsss.getString("refnos"));
			bean.setMastertr_no(rsss.getInt("refno"));
			bean.setTxtRemarks(rsss.getString("desc1"));
			 
			bean.setMawb(rsss.getString("mawb"));
			bean.setMbl(rsss.getString("mbl"));
			bean.setHawb(rsss.getString("hawb"));
			bean.setHbl(rsss.getString("hbl"));
			bean.setShipper(rsss.getString("shipper"));
			bean.setConsignee(rsss.getString("consignee"));
			bean.setCarrier(rsss.getString("carrier"));
			bean.setFlightno(rsss.getString("flightno"));
			bean.setVoage(rsss.getString("Voage"));
			bean.setEta(rsss.getString("eta"));
			bean.setEtd(rsss.getString("etd"));
			bean.setTtime(rsss.getString("ttime"));
			bean.setBoe(rsss.getString("boe"));
			bean.setContno(rsss.getString("contno"));
			bean.setTruckno(rsss.getString("truckno"));								 
			 
			
			
			
		}
		
		conn.close();
				
				
		}
		catch(Exception e)
		{
			conn.close();
		}
		
		return bean;
	}
	
	 
	 
	 
 
}
