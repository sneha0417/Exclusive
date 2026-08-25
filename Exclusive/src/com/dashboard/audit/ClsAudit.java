package com.dashboard.audit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsAudit  {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	public JSONArray clientAuditGridLoading(String branch) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement();
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and cl.brhid="+branch+"";
	    		}
			    
			    sql = "SELECT cl.date,cl.brhid,cl.cldocno,category,refname,per_mob,sal_name,concat(address,'  ',address2) as address, "
			    		+ "mail1 FROM my_acbook cl left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no "
			    		+ "where cl.dtype='CRM' and cl.audit=0"+sql;
			    
			    ResultSet resultSet = stmtCRM.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
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
	
	/*public  JSONArray refundDocumentDetails() throws SQLException {
        
	    JSONArray RESULTDATA=new JSONArray();
		
	    try {
				Connection conn = ClsConnection.getMyConnection();
				Statement stmtRRP = conn.createStatement ();
            	
				String sql="select r.rdocno,r.date,r.refunddesc,c.refname from gl_rentrefund r left join my_acbook c on r.cldocno=c.cldocno and c.dtype='CRM' "
						+ "where r.status=3";
				
            	ResultSet resultSet = stmtRRP.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtRRP.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
        return RESULTDATA;
    }*/
	
	public JSONArray refundAuditGridLoading(String branch) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement();
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    
			    sql = "select r.srno,r.dtype,r.rdocno,concat(r.rtype,' - ',CONVERT(if(r.rtype='0','',if(r.rtype='RAG',ra.voc_no,la.voc_no)),CHAR(50))) agreement,if(r.paidas=1,'Security','On Account') paidas,if(r.paidas=1,netamt,onaccountamt) netamount,"
			    		+ "r.brhid,c.refname from gl_rentrefund r left join my_acbook c on r.cldocno=c.cldocno and c.dtype='CRM' left join gl_ragmt ra on r.aggno=ra.doc_no left join gl_lagmt la on r.aggno=la.doc_no "
			    		+ "where r.status=3 and r.audit=0"+sql;
			    
			    ResultSet resultSet = stmtCRM.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
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
	
	public JSONArray rentalAuditGridLoading(String branch) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtRAG = conn.createStatement();
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			    
			     sql = "select r.doc_no,r.voc_no,concat(CONVERT(r.fleet_no,CHAR(50)),' - ',m.flname) as vehicle,odate,otime,if(advchk=1,'Yes','No') advance,if(invtype=1,'Month End','Period') invoice,"
		    		+ "r.brhid,t.rentaltype,c.refname,CONVERT(if(p.payid=1,round(p.amount,2),' '),CHAR(50)) advanceamt,CONVERT(if(p1.payid=2,round(p1.amount,2),' '),CHAR(50)) securityamt from gl_ragmt r "
			    	+ "left join gl_rtarif t on r.doc_no=t.rdocno and t.rstatus=5 left join gl_rpyt p on p.rdocno=r.doc_no and p.payid=1 left join gl_rpyt p1 on p1.rdocno=r.doc_no and p1.payid=2 left join gl_vehmaster m on r.fleet_no=m.fleet_no left join my_acbook c on "
		    		+ "r.cldocno=c.cldocno and c.dtype='CRM' where r.clstatus=0 and r.audit=0"+sql;
			    
			    ResultSet resultSet = stmtRAG.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtRAG.close();
			    conn.close();
		  }catch(Exception e){
			   e.printStackTrace();
			   conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public JSONArray leaseAuditGridLoading(String branch) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtLAG = conn.createStatement();
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and l.brhid="+branch+"";
	    		}
			    
			    sql = "select l.doc_no,l.voc_no,l.outdate,l.outtime,if(l.adv_chk=1,'Yes','No') advance,if(l.inv_type=1,'Month End','Period') invoice,"
			    		+ "concat(CONVERT(if(l.perfleet=0,l.tmpfleet,l.perfleet),CHAR(10)),' - ',if(l.perfleet=0,t.flname,p.flname)) as vehicle,"
			    		+ "l.brhid,c.refname from gl_lagmt l left join gl_vehmaster t on l.tmpfleet=t.fleet_no left join gl_vehmaster p on l.perfleet=p.fleet_no "
			    		+ "left join my_acbook c on l.cldocno=c.cldocno and c.dtype='CRM' where l.clstatus=0 and l.audit=0"+sql;
			    
			    ResultSet resultSet = stmtLAG.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtLAG.close();
			    conn.close();
		  }catch(Exception e){
			   e.printStackTrace();
			   conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
		
		public JSONArray replacementAuditGridLoading(String branch) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
			
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtRPM = conn.createStatement();
				    String sql = "";
				    
				    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and r.rbrhid="+branch+"";
		    		}
				    
				    sql = "select r.doc_no,r.inbrhid,b.branchname rbranch,br.branchname inbranch,r.odate,r.otime,r.okm,CASE WHEN r.ofuel='0.000' THEN 'Level 0/8' "
				    		+ "WHEN r.ofuel='0.125' THEN 'Level 1/8' WHEN r.ofuel='0.250' THEN 'Level 2/8' WHEN r.ofuel='0.375' THEN 'Level 3/8' WHEN r.ofuel='0.500' "
				    		+ "THEN 'Level 4/8' WHEN r.ofuel='0.625' THEN 'Level 5/8' WHEN r.ofuel='0.750' THEN 'Level 6/8' WHEN r.ofuel='0.875' THEN 'Level 7/8' "
				    		+ "WHEN r.ofuel='1.000' THEN 'Level 8/8'   END as 'ofuel',s.st_desc,if(r.deldrvid=null,' ',d.name) deldrvid,if(r.cldrvid=null,' ',dr.name) "
				    		+ "cldrvid,if(r.delstatus=0,'No','Yes') delstatus,r.rfleetno,DATEDIFF(coalesce(r.indate,curdate()),coalesce(r.odate,curdate())) idledays,"
				    		+ "v.reg_no rregno,vm.reg_no oregno from gl_vehreplace r left join gl_drdetails d on r.deldrvid=d.dr_id left join gl_drdetails dr on "
				    		+ "r.cldrvid=dr.dr_id left join gl_vehmaster v on r.rfleetno=v.fleet_no left join gl_vehmaster vm on r.ofleetno=vm.fleet_no left join "
				    		+ "gl_status s on r.trancode=s.status left join my_brch b on r.rbrhid=b.doc_no left join my_brch br on r.inbrhid=br.doc_no where r.clstatus=0 "
				    		+ "and r.status=3 and r.audit=0"+sql;
				    
				    ResultSet resultSet = stmtRPM.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtRPM.close();
				    conn.close();
			  }catch(Exception e){
				   e.printStackTrace();
				   conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		
		public JSONArray rentalcloseaudit(String branch) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
			
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtRPM = conn.createStatement();
				    String sql = "";
				    
				    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and aa.brhid="+branch+"";
		    		}
				    
				    sql = "select ra.voc_no rdocno,m1.doc_no,concat(CONVERT(m1.fleet_no,CHAR(50)),' - ',v.flname) as vehicle,c.refname, "
				    		+ "CONVERT(concat(round(aa.distot/aa.totamount*100,2),' ','%'),char(200)) as prcent,round(aa.totamount,2) total,round(aa.distot,2) discount,aa.brhid,aa.rentaltype from "
				    		+ "(select sum(d.rate+d.cdw+d.pai+d.cdw1+d.pai1+d.gps+d.babyseater+d.cooler+d.exkmrte+d.exhrchg+d.chaufchg) totamount, "
				    		+ "sum(d1.rate+d1.cdw+d1.pai+d1.cdw1+d1.pai1+d1.gps+d1.babyseater+d1.cooler+d1.exkmrte+d1.exhrchg+d1.chaufchg) distot,d.*   "
				    		+ "from gl_ragmtclosem m left join gl_ragmtclosed d on   m.agmtno=d.rdocno and (d.rentaltype='Daily'  or d.rentaltype='Weekly' or d.rentaltype='Monthly') "
				    		+ " left join gl_ragmtclosed d1 on   m.agmtno=d1.rdocno and d1.rentaltype='discount' group by m.doc_no having distot>0)aa "
				    		+ "left join gl_ragmtclosem m1 on m1.agmtno=aa.rdocno  left join gl_vehmaster v on v.fleet_no=m1.fleet_no   left join gl_ragmt ra on ra.doc_no=m1.agmtno "
				    		+ " left join my_acbook c on m1.cldocno=c.cldocno and c.dtype='CRM' where  m1.audit=0 "+sql;
				    
				    
				    ResultSet resultSet = stmtRPM.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtRPM.close();
				    conn.close();
			  }catch(Exception e){
			   e.printStackTrace();
			   conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		
		public JSONArray leasecloseaudit(String branch) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
			
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtRPM = conn.createStatement();
				    String sql = "";
				    
				    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and aa.brhid="+branch+"";
		    		}
				    
				    sql = "select ra.voc_no rdocno,m1.doc_no,concat(CONVERT(m1.fleet_no,CHAR(50)),' - ',v.flname) as vehicle,c.refname, "
				    		+ "	CONVERT(concat(round(aa.distot/aa.totamount*100,2),'','%'),char(200)) as prcent, "
				    		+ "	round(aa.totamount,2) total,round(aa.distot,2) discount,aa.brhid from "
				    		+ "	(select sum(d.rate+d.cdw+d.pai+d.cdw1+d.pai1+d.gps+d.babyseater+d.cooler+d.exkmrte+d.chaufchg) totamount, "
				    		+ "	sum(d1.rate+d1.cdw+d1.pai+d1.cdw1+d1.pai1+d1.gps+d1.babyseater+d1.cooler+d1.exkmrte+d1.chaufchg) distot,d.*  "
				    		+ "	from gl_lagmtclosem m left join gl_lagmtclosed d on   m.agmtno=d.rdocno and (d.rentaltype='Total') "
				    		+ "	left join gl_lagmtclosed d1 on   m.agmtno=d1.rdocno and d1.rentaltype='discount' group by m.doc_no having distot>0)aa "
				    		+ "	left join gl_lagmtclosem m1 on m1.agmtno=aa.rdocno  left join gl_vehmaster v on v.fleet_no=m1.fleet_no  left join gl_lagmt ra on ra.doc_no=m1.agmtno "
				    		+ "	left join my_acbook c on m1.cldocno=c.cldocno and c.dtype='CRM' where m1.audit=0  "+sql;
				    
				    ResultSet resultSet = stmtRPM.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtRPM.close();
				    conn.close();
			  }catch(Exception e){
			   e.printStackTrace();
			   conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		
		public JSONArray vehStockCheckAudit(String branch) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVSTC = conn.createStatement();
					String sql = "";
					
					if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and m.brhid="+branch+"";
		    		}
					
					sql = "select m.date,m.doc_no,m.brhid,u.user_name,b.branchname from gl_vehstockm m left join my_user u on m.userid=u.doc_no left join my_brch b on "
						+ "m.brhid=b.doc_no where m.status=3 and m.audit=0"+sql+"";
					
					ResultSet resultSet = stmtVSTC.executeQuery(sql);

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVSTC.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
		
		public JSONArray vehStockCheckDetailAudit(String docno) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn = null;
	        
			try {
					conn = ClsConnection.getMyConnection();
					Statement stmtVSTC = conn.createStatement();
					String sql = "";
					
					sql = "select m.fleet_no,m.status tran_code,if(m.remarks='0',' ',m.remarks) remarks,m.brhid,v.flname,concat(coalesce(v.REG_NO,''),' - ',coalesce(p.code_name,'')) as regno,y.yom,"
						+ "l.loc_name,g.gname,s.st_desc status,br.branchname from gl_vehstockd m left join gl_vehmaster v on m.fleet_no=v.fleet_no left join my_locm l on "
						+ "l.doc_no=v.A_LOC left join gl_vehgroup g on g.doc_no=v.VGRPID left join gl_vehplate p on v.pltid=p.doc_no left join gl_status s on m.status=s.status "
						+ "left join my_brch br on br.doc_no=m.brhid  left join gl_yom y on y.doc_no=v.yom where rdocno="+docno+"";
					
					ResultSet resultSet = stmtVSTC.executeQuery(sql);

					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					stmtVSTC.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
		
		
		public JSONArray rentalCanceledAuditGridLoading(String branch) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
			
			  try {
				    conn = ClsConnection.getMyConnection();
				    Statement stmtRAG = conn.createStatement();
				    String sql = "";
				    
				    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
		    			sql+=" and r.brhid="+branch+"";
		    		}
				    
				    sql = "select r.doc_no,r.voc_no,concat(CONVERT(r.fleet_no,CHAR(50)),' - ',m.flname) as vehicle,odate,otime,if(advchk=1,'Yes','No') advance,if(invtype=1,'Month End','Period') invoice,"
			    		+ "r.brhid,t.rentaltype,c.refname from gl_ragmt r left join gl_rtarif t on r.doc_no=t.rdocno and t.rstatus=5 left join gl_vehmaster m on r.fleet_no=m.fleet_no "
			    		+ "left join my_acbook c on r.cldocno=c.cldocno and c.dtype='CRM' where r.clstatus=2 and r.canceled_audit=0"+sql;
				    
				    ResultSet resultSet = stmtRAG.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
				    
				    stmtRAG.close();
				    conn.close();
			  }catch(Exception e){
				   e.printStackTrace();
				   conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
		public JSONArray mainfollow(String barchval,String formname,String docno,String check) throws SQLException{  	 
			//System.out.println("egsssgbdf"+formname);
				JSONArray RESULTDATA=new JSONArray();
				Connection conn = null;
				try {
					//if(barchval=="NA"){
						//return RESULTDATA;
						
					//}
					 conn = ClsConnection.getMyConnection();
					Statement stmtApp = conn.createStatement ();
					//System.out.println(barchval);
					 String sqlll="";
					 
					 if(!((formname.equalsIgnoreCase("")) || (formname.equalsIgnoreCase("0")))){
				    	 sqlll +=" and t.dtype='"+formname+"'";
			    	 }

				    
					 if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
				    	 sqlll +=sqlll+" and t.brhid="+barchval+"";
			    	 }
				     if(!((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("0")))){
				    	 	sqlll=sqlll+" and t.doc_no='"+docno+"'";
		             }
					if(check.equalsIgnoreCase("1")){
					String sql="",select1="",join1="",sqll="";
					sql= "select select1,join1 from win_tbldet where dtype='lqt'";
					ResultSet resultSet=stmtApp.executeQuery(sql);
					while(resultSet.next()){
						select1=resultSet.getString("select1");
						join1=resultSet.getString("join1");
					}
					sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		      				+ " CONVERT(concat(day(t.sub_Date),'/',month(t.sub_Date),'/',year(t.sub_Date),' ', time(t.sub_Date)),CHAR(50)) subdatetime,"
		       				+ " u.user_name  "+select1
		       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
		       				+join1 +" where 1=1 "+sqlll + " order by doc_no,apprlevel";
		       				;
		       				
					//System.out.println("==============="+sqll);
					
					ResultSet result=stmtApp.executeQuery(sqll);
					RESULTDATA=ClsCommon.convertToJSON(result);
					}
					else if(check.equalsIgnoreCase("2")){
						String sql="",select1="",join1="",sqll="";
						sql= "select select1,join1 from win_tbldet where dtype='lqt'";
						ResultSet resultSet=stmtApp.executeQuery(sql);
						while(resultSet.next()){
							select1=resultSet.getString("select1");
							join1=resultSet.getString("join1");
						}
						sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
			       				+ " CONVERT(concat(day(t.sub_Date),'/',month(t.sub_Date),'/',year(t.sub_Date),' ', time(t.sub_Date)),CHAR(50)) subdatetime,"
			       				+ " u.user_name   "+select1
			       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
			       				+join1 +" where 2=2 " +sqlll+ " union "
			       	       		+ "Select t.remarks as remarks,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=1,'Submitted',if(t.apprStatus=2,'First Level',if(t.apprStatus=3,'Second Level',if(t.apprStatus=4,'Final Level','')))))) level,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
			       	    	    + " CONVERT(concat(day(t.subDate),'/',month(t.subDate),'/',year(t.subDate),' ', time(t.subDate)),CHAR(50)) subdatetime,"
			       	       	    + " u.user_name  "+select1
			       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
			       	       	    +join1 + " where 2=2 "+sqlll+ " order by doc_no,apprlevel" ;
						//System.out.println("==============="+sqll);
						
						ResultSet result=stmtApp.executeQuery(sqll);
						RESULTDATA=ClsCommon.convertToJSON(result);
						
					}
						
					
					//System.out.println(RESULTDATA);
						stmtApp.close();
						conn.close();
		    	
		  

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();	
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
			}
		public JSONArray excelmainfollow(String barchval,String formname,String docno,String check) throws SQLException{  	 
			//System.out.println("egsssgbdf"+formname);
				JSONArray RESULTDATA=new JSONArray();
				Connection conn = null;
				try {
					//if(barchval=="NA"){
						//return RESULTDATA;
						
					//}
					 conn = ClsConnection.getMyConnection();
					Statement stmtApp = conn.createStatement ();
					//System.out.println(barchval);
					 String sqlll="";
					 
					 if(!((formname.equalsIgnoreCase("")) || (formname.equalsIgnoreCase("0")))){
				    	 sqlll +=" and t.dtype='"+formname+"'";
			    	 }

				    
					 if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
				    	 sqlll +=sqlll+" and t.brhid="+barchval+"";
			    	 }
				     if(!((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("0")))){
				    	 	sqlll=sqlll+" and t.doc_no='"+docno+"'";
		             }
					if(check.equalsIgnoreCase("1")){
					String sql="",select1="",join1="",sqll="";
					sql= "select select1,join1 from win_tbldet where dtype='lqt'";
					ResultSet resultSet=stmtApp.executeQuery(sql);
					while(resultSet.next()){
						select1=resultSet.getString("select1");
						join1=resultSet.getString("join1");
					}
					sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
		      				+ " CONVERT(concat(day(t.sub_Date),'/',month(t.sub_Date),'/',year(t.sub_Date),' ', time(t.sub_Date)),CHAR(50)) subdatetime,"
		       				+ " u.user_name  "+select1
		       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
		       				+join1 +" where 1=1 "+sqlll + " order by doc_no,apprlevel";
		       				;
		       				
					//System.out.println("==============="+sqll);
					
					ResultSet result=stmtApp.executeQuery(sqll);
					RESULTDATA=ClsCommon.convertToEXCEL(result);
					}
					else if(check.equalsIgnoreCase("2")){
						String sql="",select1="",join1="",sqll="";
						sql= "select select1,join1 from win_tbldet where dtype='lqt'";
						ResultSet resultSet=stmtApp.executeQuery(sql);
						while(resultSet.next()){
							select1=resultSet.getString("select1");
							join1=resultSet.getString("join1");
						}
						sqll="Select t.desc1 as remarks,if(t.apprLevel=1,'First Level',if(t.apprLevel=2,'Secound Level',if(t.apprLevel=3,'Final Level',''))) level,t.apprLevel,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
			       				+ " CONVERT(concat(day(t.sub_Date),'/',month(t.sub_Date),'/',year(t.sub_Date),' ', time(t.sub_Date)),CHAR(50)) subdatetime,"
			       				+ " u.user_name   "+select1
			       				+ " from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no "
			       				+join1 +" where 2=2 " +sqlll+ " union "
			       	       		+ "Select t.remarks as remarks,if(t.apprStatus=1,'Submitted',if(t.apprStatus=9,'Returned document',if(t.apprStatus=1,'Submitted',if(t.apprStatus=2,'First Level',if(t.apprStatus=3,'Second Level',if(t.apprStatus=4,'Final Level','')))))) level,t.apprStatus,t.doc_no doc_no,t.dtype doctype,br.branchname branch,"
			       	    	    + " CONVERT(concat(day(t.subDate),'/',month(t.subDate),'/',year(t.subDate),' ', time(t.subDate)),CHAR(50)) subdatetime,"
			       	       	    + " u.user_name  "+select1
			       	       	    + " from my_exdet t  inner join my_brch br on t.brhId=br.doc_no left join my_user u on t.userid=u.doc_no  "
			       	       	    +join1 + " where 2=2 "+sqlll+ " order by doc_no,apprlevel" ;
						//System.out.println("==============="+sqll);
						
						ResultSet result=stmtApp.executeQuery(sqll);
						RESULTDATA=ClsCommon.convertToEXCEL(result);
						
					}
						
					
					//System.out.println(RESULTDATA);
						stmtApp.close();
						conn.close();
		    	
		  

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();	
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
			}	
		public JSONArray Approvalsearch() throws SQLException{
			JSONArray RESULTDATA=new JSONArray();
			Connection conn=null;
					try{
						conn=ClsConnection.getMyConnection();
						Statement stmtAPP = conn.createStatement();
						String sql="",select1="",join1="",sqll="" ;
						sql = "select select1,join1 from win_tbldet where dtype='lqt' ";
						//System.out.println(sql);
						ResultSet resultSet= stmtAPP.executeQuery(sql);
						while(resultSet.next()){
							select1=resultSet.getString("select1");
							join1=resultSet.getString("join1");
						}
						
						sqll="select t.doc_no,t.dtype "+select1+" from my_exeb t "+join1 ;
						//System.out.println(sqll);
						ResultSet result=stmtAPP.executeQuery(sqll);
						
						RESULTDATA=ClsCommon.convertToJSON(result);
						//System.out.println(RESULTDATA);
	     				stmtAPP.close();
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