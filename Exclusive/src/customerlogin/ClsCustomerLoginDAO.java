package customerlogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsCustomerLoginDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	public boolean clientLogin(String clientusername, String clientpassword,
			HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int cldocno=0;
			String refname="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			String str="select * from rl_propertryowner where ownerusername='"+clientusername+"' and ownerpassword='"+clientpassword+"' and status=3";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				cldocno=rs.getInt("doc_no");
				refname=rs.getString("primary_owner");
			}
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(cldocno>0){
		    	session.setAttribute("CLDOCNO", cldocno);
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID","1");
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME","ONLINEUSER");
				session.setAttribute("CLIENTNAME", refname);
				String strlog = "insert into gc_clientlog (cldocno,clientname,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ("+cldocno+",'"+refname+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					conn.close();
					return false;
				}
				else{
					conn.commit();
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	
	public JSONArray accountsStatement(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.transno docno,a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
				+ "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
				+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
				+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
				+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
				+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
				+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
				+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
				+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
				+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
				System.out.println("============"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray accountsStatementExcelExport(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.trdate 'Date',b.transtype 'Type',b.transno 'Doc No',b.branchname 'Branch',b.ref_detail 'Ref No',b.description 'Description',b.currency 'Currency',b.rate 'Rate',b.dr 'Debit',b.cr 'Credit',b.debit 'Base Debit',b.credit 'Base Credit',"
						+ "coalesce(round(@i:=@i+nettotal,2),0) 'Balance' from (select a.trdate,a.transtype,a.ref_detail,"+casestatement+"b.branchname,a.description,a.currency,a.rate,a.dr,a.cr,a.debit,a.credit,round((a.debit+(a.credit)*-1),2) nettotal from ("
						+ "select t.brhid,transno,transtype,date(t.trdate) trdate,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+"  group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+"  order by trdate,TRANSNO) b,(select @i:=0) as i";
				
				ResultSet resultSet = stmtAccountStatement1.executeQuery(sql);
				RESULTDATA=objcommon.convertToEXCEL(resultSet);
				
				//stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	

	public JSONArray directAccountsStatement(String branch,String fromdate,String todate,String accdocno,String check,String acctype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
			
			
			conn = objconn.getMyConnection();
			Statement stmtAccountStatement2 = conn.createStatement();
			String sql = "";String joins="";String casestatement="";
			String condition1="";
			String sq1="";
			String db1="";
			String selct="";
    	    
                
			if(acctype.equalsIgnoreCase("AR")){
				condition1=" and io.clacno ="+accdocno;
				selct=" if(t.transtype='opn','',mh.account) account, if(t.transtype='opn','',mh.description) accountname";
				db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) debit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) credit ";
				
			}
			else if(acctype.equalsIgnoreCase("AP")){
				condition1="and io.vndacno ="+accdocno;
				selct=" if(t.transtype='opn','',h.account) account, if(t.transtype='opn','',h.description) accountname";
				db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) credit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) debit ";
			}
			
			
			
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql =   "select b.chqno,convert(b.chqdate,char(50)) chqdate,cast(b.transno as char) transno, trdate, transtype, docno, branchname, description, account, accountname, debit, credit, cntrno, grpno, alevel, brhid, nettotal,coalesce(round(@i:=@i+nettotal,2),0) balance from (select a.account,a.accountname,a.chqno,a.chqdate,a.trdate, "
						+ "a.transtype, a.transno docno,b.branchname, a.tr_des description,"
						+ "a.debit, a.credit,a.cntrno, a.grpno, a.alevel,"
						+ " a.brhid,round((a.debit+(a.credit)*-1),2) nettotal,CASE WHEN a.transtype in ('VSI') THEN "
						+ "vs.voc_no ELSE a.transno END AS 'transno' from (select t.chqno,t.chqdate,date(trdate) trdate,"
						+ "h.brhid,coalesce(transno,0) transno,t.transtype, t.tr_des, t.cntrno, amount, "
						+ " "+db1+","+selct+","
						+ "h.grpno,h.alevel,h.doc_no acno from my_head h inner join	"					
						+ "(select '' chqno,''chqdate,io.clacno,io.vndacno,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'Opening Bal.' tr_des, "
						+ "1 srno,0 cntrno, sum(io.amount) amount,sum(io.outamount) outamount, 0 transNo,'OPN' transtype from in_opaccountd io "
						+ "where io.status=3 "+condition1+" and ((io.cndate >= '"+sqlFromDate+"' and io.dtype='OPN') or (io.cndate< '"+sqlFromDate+"')) union all "
						+ "select dir.chqno,dir.chqdate,io.clacno,io.vndacno,io.cndate trdate,io.remarks tr_des, 2 srno,io.cntrno,io.amount ,io.outamount,io.cno transNo,io.dtype transtype " 
						+ "from in_opaccountd io left join in_opdirpayment dir on (io.cno=dir.doc_no and io.dtype='DIPN') where io.status=3 "+condition1+" and cndate between '"+sqlFromDate+"' and  '"+sqlToDate+"' and io.dtype!='opn') t "
						+ " on h.doc_no=t.clacno left join my_head mh on t.vndacno=mh.doc_no left join my_curr c on c.doc_no=t.transno) a "
						+ " left join my_brch b on b.doc_no=a.brhid "
						+ "left join gl_vsalem vs on (a.transno=vs.doc_no and a.brhid=vs.brhid and "
						+ "a.transtype in ('VSI')) order by trdate,TRANSNO) b ,(select @i:=0) as i";
				
//				System.out.println("AccSatatement---876543-->"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray directaccountsStatementExcelExport(String branch,String fromdate,String todate,String accdocno,String check,String acctype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement1 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				String condition1="";
				String sq1="";
				String db1="";
				String selct="";
				String selctdipn="left join in_opdirpayment dir on dir.doc_no=d.cno";
				
				if(acctype.equalsIgnoreCase("AR")){
					condition1=" and io.clacno ="+accdocno;
					selct=" if(t.transtype='opn','',mh.account) account, if(t.transtype='opn','',mh.description) accountname";
					db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) debit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) credit ";
					
				}
				else if(acctype.equalsIgnoreCase("AP")){
					condition1="and io.vndacno ="+accdocno;
					selct=" if(t.transtype='opn','',h.account) account, if(t.transtype='opn','',h.description) accountname";
					db1="CONVERT(if(amount>0,round((amount*1),2),''),CHAR(50)) credit, CONVERT(if(amount<0,round((amount*-1),2),''),CHAR(50)) debit ";
				}
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql = "select trdate date, transtype type, cast(b.transno as char) docno,b.chqno,convert(b.chqdate,char(50))chqdate,description,account,accountname, debit, credit "
						+ "from (select a.account,a.accountname,a.chqno,a.chqdate,a.trdate, a.transtype, a.transno docno,b.branchname, a.tr_des description,"
						+ "a.debit, a.credit,a.cntrno, a.grpno, a.alevel, a.brhid,round((a.debit+(a.credit)*-1),2) nettotal,CASE WHEN a.transtype in ('VSI') THEN "
						+ "vs.voc_no ELSE a.transno END AS 'transno' from (select t.chqno,t.chqdate,date(trdate) trdate,"
						+ "h.brhid,coalesce(transno,0) transno,t.transtype, t.tr_des, t.cntrno, amount, "
						+ " "+db1+","+selct+","
						+ "h.grpno,h.alevel,h.doc_no acno from my_head h inner join	"					
						+ "(select '' chqno,'' chqdate,io.clacno,io.vndacno,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,'Opening Bal.' tr_des, "
						+ "1 srno,0 cntrno, sum(io.amount) amount,sum(io.outamount) outamount, 0 transNo,'OPN' transtype from in_opaccountd io "
						+ "where io.status=3 "+condition1+" and ((io.cndate >= '"+sqlFromDate+"' and io.dtype='OPN') or (io.cndate< '"+sqlFromDate+"')) union all "
						+ "select dir.chqno,dir.chqdate,io.clacno,io.vndacno,io.cndate trdate,io.remarks tr_des, 2 srno,io.cntrno,io.amount ,io.outamount,io.cno transNo,io.dtype transtype " 
						+ "from in_opaccountd io left join in_opdirpayment dir on (io.cno=dir.doc_no and io.dtype='DIPN') where io.status=3 "+condition1+" and cndate between '"+sqlFromDate+"' and  '"+sqlToDate+"' and io.dtype!='opn') t "
						+ " on h.doc_no=t.clacno left join my_head mh on t.vndacno=mh.doc_no left join my_curr c on c.doc_no=t.transno) a "
						+ " left join my_brch b on b.doc_no=a.brhid "
						+ "left join gl_vsalem vs on (a.transno=vs.doc_no and a.brhid=vs.brhid and "
						+ "a.transtype in ('VSI')) order by trdate,TRANSNO) b ,(select @i:=0) as i";
				
//				System.out.println("EXCEL EXPORT----->"+sql);
				ResultSet resultSet = stmtAccountStatement1.executeQuery(sql);
				RESULTDATA=objcommon.convertToEXCEL(resultSet);
				
				//stmtAccountStatement1.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getContractData(String cldocno,Connection conn){
		JSONArray contractarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			int serial=1;
			/*String strmaster="select m.doc_no docno,m.voc_no vocno,date_format(m.date,'%d.%m.%Y') date,m.reftype,if(m.reftype='DIR',0,enq.voc_no) "+
			" refvocno,coalesce(contact.cperson,'') contactperson,coalesce(m.insurer,'') insured from in_contract m left join in_enqm enq on"+
			" (m.reftype='ENQ' and m.refno=enq.doc_no) left join my_crmcontact contact on (m.contactpid=contact.row_no and"+
			" m.cldocno=contact.cldocno) where m.status<>7 and m.cldocno="+cldocno+" order by m.doc_no desc";
			*/
			String strmaster="select * from ("+
			" select m.doc_no docno,m.voc_no vocno,date_format(m.date,'%d.%m.%Y') date,m.reftype,if(m.reftype='DIR',0,enq.voc_no)"+
			" refvocno,insurtype.name insurtype,d.policyno,date_format(d.enddt,'%d.%m.%Y') expirydate,concat(coalesce(motor.regno,''),' - ',coalesce(brd.brand_name,''),' ',"+
			" coalesce(model.vtype,'')) vehdetails from in_contract m left join in_enqm enq on"+
			" (m.reftype='ENQ' and m.refno=enq.doc_no) left join in_contractd d on (m.doc_no=d.rdocno) left join in_insurtype insurtype on"+
			" (d.instype=insurtype.doc_no) left join in_contractmotor motor on (m.doc_no=motor.rdocno) left join gl_vehbrand brd on"+
			" (motor.brandid=brd.doc_no) left join gl_vehmodel model on (motor.modelid=model.doc_no) where m.status<>7 and m.cldocno="+cldocno+" group by m.doc_no) aa"+
			" order by docno desc";
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("serial", serial);
				objsub.put("vocno", rsmaster.getString("vocno"));
				objsub.put("date", rsmaster.getString("date"));
				objsub.put("reftype", rsmaster.getString("reftype"));
				objsub.put("refvocno", rsmaster.getString("refvocno"));
				/*objsub.put("contactperson", rsmaster.getString("contactperson"));
				objsub.put("insured", rsmaster.getString("insured"));*/
				objsub.put("insurtype", rsmaster.getString("insurtype"));
				objsub.put("policyno", rsmaster.getString("policyno"));
				objsub.put("expirydate", rsmaster.getString("expirydate"));
				objsub.put("vehdetails", rsmaster.getString("vehdetails"));
				JSONArray attacharray=getContractAttachData(rsmaster.getInt("vocno"),"INS",conn);
				objsub.put("attachdata", attacharray);
				serial++;
				contractarray.add(objsub);
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return contractarray;
	}


	private JSONArray getContractAttachData(int refdocno, String reftype,Connection conn) {
		// TODO Auto-generated method stub
		JSONArray attacharray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			
			/*String strattach="select sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.clientview=1 and a.doc_no="+refdocno+" and a.dtype='"+reftype+"' order by sr_no";
			//System.out.println(strattach);
			ResultSet rsattach=stmt.executeQuery(strattach);*/
			
			Statement cpstmt = conn.createStatement();
		       
		       int i=0;
		       String sqls="",sqltst="",docnoss="",dtypess="",sqltest="";  
		       String dtype="INS",docno="0";
		       String  cpsql="";
		       ResultSet rsattach=null;
		       /*String sqlsss="select * from gl_attachtypechk where dtype='"+dtype+"' and status=3";
		       ResultSet rs=cpstmt.executeQuery(sqlsss);
		       if(rs.next())
		       {
		    	   i=1;
		       }*/
		       String enddocno="",insdocno="",qotdocno="",enqdocno="",crmdocno="",ppcdocno="";
		     
		    	  
		    	   
		    	  /* if(i==0)
			       {
			    	   sqls= " and a.brhid='"+contractarray.get(j).split("::")[1]+"' " ;     
			       }*/
		    	   docno=refdocno+"";
		    	   ResultSet rs44=null;
			       sqltst="select en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,if(eq.clientid=2,pm.doc_no,eq.cldocno) cldocno,0 crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_contract cm left join in_enqm eq on cm.refno=eq.doc_no left join cm_prosclientm pm on (pm.tr_no=eq.cldocno and eq.clientid=2) left join in_srvqotm qm on qm.refdocno=eq.doc_no left join in_endorsement en on cm.doc_no=en.cntrno where 1=1 and cm.voc_no="+docno+"";
				//   System.out.println("sqltst--4->>>"+sqltst);  
				   rs44=cpstmt.executeQuery(sqltst); 
				    while(rs44.next()){    
			    			
				    	
				    	
				       docnoss+=rs44.getString("endno")+",";
		    		   if(!enddocno.contains(rs44.getString("endno"))){
		    			   if(!cpsql.equalsIgnoreCase("")){
				    		   cpsql=cpsql+" union all \n ";
				    	   }
		    			   cpsql=cpsql+" select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" and a.clientview=1 ";   
		    		   }
		    		   enddocno+=rs44.getString("endno")+",";
		    		   docnoss+=rs44.getString("insno")+",";
		    		   if(!insdocno.contains(rs44.getString("insno")+",")){
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" and a.clientview=1 ";
					   }
		    		   insdocno+=rs44.getString("insno")+",";
				       //System.out.println("Ddddd"+docnoss);
				       
					   
		    		   docnoss+=rs44.getString("qotno")+",";
		    		   if(!qotdocno.contains(rs44.getString("qotno")+",")){
		    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+"  and a.clientview=1 ";   
		    		   }
		    		   qotdocno+=rs44.getString("qotno")+",";
					   
		    		   docnoss+=rs44.getString("enqno")+",";
		    		   if(!enqdocno.contains(rs44.getString("enqno")+",")){
		    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+"  and a.clientview=1 ";   
		    		   }
		    		   enqdocno+=rs44.getString("enqno")+",";
					   
	                if(rs44.getString("clientid").equalsIgnoreCase("1")){
		    			   dtypess+="'CRM'";
		    			   if(!crmdocno.contains(rs44.getString("clientid")+",")){
		    				   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  and a.clientview=1  ";  
		    			   }
		    			   crmdocno+=rs44.getString("clientid")+",";
	                }else{
		    			   dtypess+="'PPC'";   
		    			   if(ppcdocno.contains(rs44.getString("clientid")+",")){
		    				   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  and a.clientview=1  ";   
		    			   }
		    			   ppcdocno+=rs44.getString("clientid")+",";
		    		   }
					    dtypess+="'END'"+",";  
		    		   dtypess+="'INS'"+",";  
					   dtypess+="'SQOT'"+",";
		    		   dtypess+="'ENQ'"+",";
		    		   dtypess+="'CRM'"+",";
		    	     }
		       
		       
		       if(!(docnoss.equalsIgnoreCase("") || dtypess.equalsIgnoreCase(""))){  
		    	  // cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+docnoss+") and a.dtype in ("+dtypess+") "+sqls+" order by sr_no desc"; 
//		    	   System.out.println("cpsql--123->>>"+cpsql);
			       rsattach = cpstmt.executeQuery(cpsql);
		//	       data=objcommon.convertToJSON(resultSet);             
		       }
	    
			int serial=1;
			while(rsattach.next()){
				JSONObject objattach=new JSONObject();
				objattach.put("serial", serial);
				objattach.put("sr_no",rsattach.getString("sr_no"));
				objattach.put("extension", rsattach.getString("extension"));
				objattach.put("description", rsattach.getString("description"));
				objattach.put("filename", rsattach.getString("filename"));
				objattach.put("filepath", rsattach.getString("path"));
				objattach.put("type", rsattach.getString("type"));
				attacharray.add(objattach);
				serial++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return attacharray;
	}
	
	public JSONArray invoicelist(String fromdate,String todate,String acno,String id,String ownerdocno) throws SQLException {
        JSONArray data=new JSONArray();
        if(!id.equalsIgnoreCase("1")){
        	return data;
        }
        Connection conn=null;
        try{
        	java.sql.Date sqlfromdate = null,sqltodate = null;
        	String sqltest="";
        	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
        	{
        		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
        		sqltest+=" and m.date>='"+sqlfromdate+"'";
        	}
        	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
        	{
        		sqltodate=objcommon.changeStringtoSqlDate(todate);
        		sqltest+=" and m.date<='"+sqltodate+"'";
        	}
        	
        	if(!(acno.equalsIgnoreCase("")|| acno.equalsIgnoreCase("NA"))){
        		sqltest=sqltest+" and m.acno='"+acno+"'";
        	}
        	/*if(!(ownerdocno.equalsIgnoreCase("")|| ownerdocno.equalsIgnoreCase("NA"))){
        		sqltest=sqltest+" and prop.owid='"+ownerdocno+"'";
        	}*/
        	conn = objconn.getMyConnection();
			Statement stmt= conn.createStatement ();
			
			String sql="select m.doc_no docno,m.voc_no vocno,date_format(m.date,'%d.%m.%Y') date,m.reftype,m.refno,m.desc1,br.branchname,m.property,m.owner,"+
			" usr.user_name,round(coalesce(d.nettotal,0),2) nettotal,round(coalesce(d.taxamount,0),2) taxamount,round(coalesce(d.taxtotal,0),2) taxtotal "+
			" from rl_prinvm m left join my_brch br on m.brhid=br.doc_no left join my_user usr on m.userid=usr.doc_no left join rl_tncm tnc on "+
			" (m.reftype='TNC' and m.refno=tnc.doc_no) left join rl_propertymaster prop on tnc.prtype=prop.doc_no left join (select rdocno,sum(nettotal) nettotal,"+
			" sum(tax) taxamount,sum(nettaxamount) taxtotal from rl_prinvd group by rdocno) d on m.doc_no=d.rdocno where m.status=3"+sqltest;
			System.out.println(""+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
            data=objcommon.convertToJSON(resultSet);
            stmt.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return data;
    }
	
	public JSONArray getTicketPivotData(String fromdate,String todate,String id,HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqltest+=" and tkt.bookdate>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and tkt.bookdate<='"+sqltodate+"'";
			}
			
			
			String strsql="select tkt.*,air.name from ti_ticketvoucherd tkt left join ti_airline air on tkt.airlineid=air.doc_no where 1=1"+sqltest;
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
			
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public JSONArray loadsummaryGrid(String ownid,String id,String todate) throws SQLException {              
		JSONArray RESULTDATA=new JSONArray();     
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		java.sql.Date sqlToDate = null;
		try {
			 conn = objconn.getMyConnection(); 
			 Statement stmt = conn.createStatement();
			 if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
			 }
			 //String strsql="select accname,mrfacno,acno,round(pcredit,2) pcredit,round(pdebit,2) pdebit,round(mcredit,2) mcredit,round(mdebit,2) mdebit,round((pcredit+pdebit+mcredit+mdebit),2) nettotal from(select  m.accname,coalesce(m.mrf_acno,0) mrfacno,coalesce(m.acno,0) acno,if(coalesce(jp1.credit,0)<0,coalesce(jp1.credit,0)*-1,0) pcredit,coalesce(jp2.debit,0) pdebit,if(coalesce(jm1.credit,0)<0,coalesce(jm1.credit,0)*-1,0) mcredit,coalesce(jm2.debit,0) mdebit from rl_propertymaster m left join (select sum(coalesce(dramount,0)) credit,acno from my_jvtran where dramount<0 group by acno) jp1 on jp1.acno=m.acno left join (select sum(coalesce(dramount,0)) debit,acno from my_jvtran where dramount>=0 group by acno) jp2 on jp2.acno=m.acno left join (select sum(coalesce(dramount,0)) credit,acno from my_jvtran where dramount<0 group by acno) jm1 on jm1.acno=m.mrf_acno left join (select sum(coalesce(dramount,0)) debit,acno from my_jvtran where dramount>=0 group by acno) jm2 on jm2.acno=m.mrf_acno  where m.owid='"+ownid+"')a"; 
			 String strsql="select a.doc_no propdocno,a.accname,a.acno,a.mrfacno,round(if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0)),2) pcredit,round(if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0)),2) pdebit,round(if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0)),2) mcredit,round(if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0)),2) mdebit,round((if(coalesce(a.pdebit,0)<0,coalesce(a.pdebit,0)*-1,coalesce(a.pdebit,0))-if(coalesce(a.pcredit,0)<0,coalesce(a.pcredit,0)*-1,coalesce(a.pcredit,0))+if(coalesce(b.mdebit,0)<0,coalesce(b.mdebit,0)*-1,coalesce(b.mdebit,0))-if(coalesce(b.mcredit,0)<0,coalesce(b.mcredit,0)*-1,coalesce(b.mcredit,0))),2) nettotal from (select  m.accname,m.mrf_acno mrfacno,m.acno,if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) pcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) pdebit,m.doc_no   from rl_propertymaster m left join my_jvtran j on j.acno=m.acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<'"+sqlToDate+"' group by m.acno) a left join (select  if(sum(coalesce(dramount,0))<0,sum(coalesce(dramount,0)),0) mcredit,if(sum(coalesce(dramount,0))>0,sum(coalesce(dramount,0)),0) mdebit,m.doc_no from rl_propertymaster m left join my_jvtran j on j.acno=m.mrf_acno where m.owid='"+ownid+"' and m.status=3 and j.status=3 and j.date<'"+sqlToDate+"' group by m.mrf_acno) b on a.doc_no=b.doc_no";
			 System.out.println("strsql---->>>"+strsql);            
			 ResultSet resultSet = stmt.executeQuery(strsql);            
			 RESULTDATA=objcommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray summaryASData(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
				System.out.println("============"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray getChartCountData(String cldocno,Connection conn){
		JSONArray chartarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strptype="select ptype from rl_propertymaster where owid="+cldocno+" group by ptype";
			ArrayList<String> ptypearray=new ArrayList();
			ResultSet rsgetptype=stmt.executeQuery(strptype);
			while(rsgetptype.next()){
				ptypearray.add(rsgetptype.getString("ptype"));
			}
			
			for(int i=0;i<ptypearray.size();i++){
				String strsql="select (select count(*) from rl_propertymaster where owid="+cldocno+" and ptype="+ptypearray.get(i)+" and status=3 group by ptype) totalcount,"+
				" (select count(*) from rl_propertymaster where owid="+cldocno+" and ptype="+ptypearray.get(i)+" and cnt_no=0  and status=3 group by ptype) availablecount,"+
				" (select count(*) from rl_propertymaster where owid="+cldocno+" and ptype="+ptypearray.get(i)+" and cnt_no>0  and status=3 group by ptype) oncontractcount,"+
				" (select code from rl_propertytype where doc_no="+ptypearray.get(i)+" and status=3) ptype";
				ResultSet rs=stmt.executeQuery(strsql);
				while(rs.next()){
					JSONObject objtemp=new JSONObject();
					objtemp.put("totalcount",rs.getInt("totalcount"));
					objtemp.put("availablecount",rs.getInt("availablecount"));
					objtemp.put("oncontractcount",rs.getInt("oncontractcount"));
					objtemp.put("ptype",rs.getString("ptype"));
					chartarray.add(objtemp);
				}
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return chartarray;
	}
}
