package com.humanresource.transactions.leavetraveldisbursement;

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

public class ClsLeaveTravelDisbursementDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	ClsLeaveTravelDisbursementBean leaveTravelDisbursementBean = new ClsLeaveTravelDisbursementBean();
	
	public int insert(String formdetailcode, String brchName, Date leaveTravelDisbursementsDate, Date notifyingDate, int txtemployeedocno, double txtalreadyprovisioneligibledays,
			double txtcurrentprovisioneligibledays, double txttotaleligibledays, double txtleavesalarycalculated, double txtleavesalaryalreadyprovided, double txtleavesalarynettobeprovided,
			int chckpartialpayment, double txtleavesalarytobepaid, double txtleavesalarypaideligibledays, double txttravelticketvalue, double txttravelalreadyposted, double txttravelcurrentexpenses, 
			double txtdrtotal, ArrayList<String> accountsarray,HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtLTD = conn.prepareCall("{CALL HRLeaveTravelDisbursementmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtLTD.registerOutParameter(21, java.sql.Types.INTEGER);
			stmtLTD.registerOutParameter(22, java.sql.Types.INTEGER);
			
			stmtLTD.setDate(1,leaveTravelDisbursementsDate);
			stmtLTD.setInt(2,txtemployeedocno);
			stmtLTD.setDate(3,notifyingDate);
			stmtLTD.setDouble(4,txtalreadyprovisioneligibledays);
			stmtLTD.setDouble(5,txtcurrentprovisioneligibledays);
			stmtLTD.setDouble(6,txttotaleligibledays);
			stmtLTD.setDouble(7,txtleavesalarycalculated);
			stmtLTD.setDouble(8,txtleavesalaryalreadyprovided);
			stmtLTD.setDouble(9,txtleavesalarynettobeprovided);
			stmtLTD.setInt(10,chckpartialpayment);
			stmtLTD.setDouble(11,txtleavesalarytobepaid);
			stmtLTD.setDouble(12,txtleavesalarypaideligibledays);
			stmtLTD.setDouble(13,txttravelticketvalue);
			stmtLTD.setDouble(14,txttravelalreadyposted);
			stmtLTD.setDouble(15,txttravelcurrentexpenses);
			stmtLTD.setDouble(16,txtdrtotal);
			stmtLTD.setString(17,formdetailcode);
			stmtLTD.setString(18,brchName);
			stmtLTD.setString(19,company);
			stmtLTD.setString(20,userid);
			stmtLTD.setString(23,mode);
			int datas=stmtLTD.executeUpdate();
			if(datas<=0){
				stmtLTD.close();
				conn.close();
				return 0;
			}
			int docno=stmtLTD.getInt("docNo");
			int trno=stmtLTD.getInt("itranNo");
			request.setAttribute("tranno", trno);
			leaveTravelDisbursementBean.setTxtleavetraveldisbursementdocno(docno);
			
			if (docno > 0) {
				
				/*Insertion to hr_emptran,my_jvtran*/
				int insertData=insertion(conn, docno, trno, leaveTravelDisbursementsDate, notifyingDate, brchName, txtemployeedocno, formdetailcode, txtcurrentprovisioneligibledays, txttotaleligibledays, txtleavesalarycalculated, txtleavesalaryalreadyprovided, txtleavesalarynettobeprovided, chckpartialpayment, txtleavesalarytobepaid, txtleavesalarypaideligibledays, txttravelticketvalue, txttravelalreadyposted, txttravelcurrentexpenses,accountsarray, session, mode);
				if(insertData<=0){
					stmtLTD.close();
					conn.close();
					return 0;
				}
				/*Insertion to hr_emptran,my_jvtran Ends*/
				
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtLTD.executeQuery(sql1);
			    
				 while (resultSet.next()) {
					 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0) {
					conn.commit();
					stmtLTD.close();
					conn.close();
					return docno;
				 } else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
				        stmtLTD.close();
					    return 0;
				 }
		      }
				
			stmtLTD.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
		return 0;
	}
	
	public JSONArray accountDetailsGridReloading(String trNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtLTD = conn.createStatement();
			
				String sql="select j.acno,if(j.dramount>0,j.dramount,0) debit,if(j.dramount<0,j.dramount*-1,0) credit,t.account,t.description codeno from my_jvtran j left join my_head t on j.acno=t.doc_no where j.tr_no="+trNo+"";
				ResultSet resultSet = stmtLTD.executeQuery(sql);
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtLTD.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }

	public JSONArray employeeDetailsSearch(HttpSession session,String empname,String mob,String employeedesignation,String employeedepartment,String empid,String doj,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;
        }
        
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
             
           String brid=session.getAttribute("BRANCHID").toString();
       
           java.sql.Date sqlDateofJoin=null;
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtHTRE = conn.createStatement();
       
    	   doj.trim();
           if(!(doj.equalsIgnoreCase("undefined"))&&!(doj.equalsIgnoreCase(""))&&!(doj.equalsIgnoreCase("0")))
           {
           	sqlDateofJoin = ClsCommon.changeStringtoSqlDate(doj);
           }
           
           String sqltest="";
           
           if(!(empname.equalsIgnoreCase(""))){
               sqltest=sqltest+" and m.name like '%"+empname+"%'";
           }
           if(!(mob.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) like '%"+mob+"%'";
           }
           if(!(employeedesignation.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and m.desc_id like '%"+employeedesignation+"%'";
           }
           if(!(employeedepartment.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and m.dept_id like '%"+employeedepartment+"%'";
           }
           if(!(empid.equalsIgnoreCase(""))){
           	sqltest=sqltest+" and m.codeno like '%"+empid+"%'";
           }
           if(!(sqlDateofJoin==null)){
           	sqltest=sqltest+" and m.dtjoin='"+sqlDateofJoin+"'";
           } 
           
	       ResultSet resultSet = stmtHTRE.executeQuery("select m.name,m.codeno empid,if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) mob,dg.desc1 designation,dp.desc1 department,"  
	       	  + "ct.desc1 category,m.dtjoin,m.doc_no,max(ap.date) appriasal from hr_empm m left join hr_setdesig dg on m.desc_id=dg.doc_no left join hr_setdept dp on m.dept_id=dp.doc_no "
	    	  + "left join hr_setpaycat ct on m.pay_catid=ct.doc_no left join hr_incrm ap on m.doc_no=ap.empid where m.status=3 and m.active=1 and m.dtype='EMP'" +sqltest+" group by m.doc_no");
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtHTRE.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }
	
	public JSONArray ltdMainSearch(HttpSession session,String empname,String docNo,String date,String totalAmount) throws SQLException {

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
        
         String branch=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlDate=null;
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtLTD = conn.createStatement();
	       
	       date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        sqlDate = ClsCommon.changeStringtoSqlDate(date);
	        }

	       String sqltest="";
	        
	       if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and m.doc_no like '%"+docNo+"%'";
	       }
	       if(!(empname.equalsIgnoreCase(""))){
	        	sqltest=sqltest+" and e.name like '%"+empname+"%'";
	       }
	       if(!(totalAmount.equalsIgnoreCase(""))){
	        	sqltest=sqltest+" and m.totalAmount like '%"+totalAmount+"%'";
	       }
	       if(!(sqlDate==null)){
	        	sqltest=sqltest+" and m.date='"+sqlDate+"'";
		   } 
	        
	       ResultSet resultSet = stmtLTD.executeQuery("select m.doc_no,m.date,m.totalAmount amount,m.tr_no,e.name FROM hr_leavetraveldisbursementm m left join hr_empm e on (m.empid=e.doc_no and e.dtype='EMP') where m.brhid="+branch+" "  
	       	+ "and m.status<>7" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtLTD.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public  ClsLeaveTravelDisbursementBean getViewDetails(HttpSession session,int docNo,int trNo) throws SQLException {
		    ClsLeaveTravelDisbursementBean leaveTravelDisbursementBean = new ClsLeaveTravelDisbursementBean();
			
			Connection conn = null;
			
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtLTD = conn.createStatement();
			
				String branch = session.getAttribute("BRANCHID").toString();
				
				ResultSet resultSet = stmtLTD.executeQuery ("select m.tr_no,m.date,m.notifydate,round(m.leavesalarydays_already,2) leavesalarydays_already,round(m.leavesalarydays_current,2) leavesalarydays_current,"
						+ "round(m.leavesalarydays_total,2) leavesalarydays_total,round(m.leavesalaryamount_current,2) leavesalaryamount_current,round(m.leavesalaryamount_already,2) leavesalaryamount_already,"
						+ "round(m.leavesalaryamount_net,2) leavesalaryamount_net,m.leavesalary_partial,round(m.leavesalaryamount_tobepaid,2) leavesalaryamount_tobepaid,round(m.leavesalarydays_tobepaid,2) leavesalarydays_tobepaid,"
						+ "round(m.travel_ticketamount,2) travel_ticketamount,round(m.travelamount_already,2) travelamount_already,round(m.travel_currentexpense,2) travel_currentexpense,round(m.totalAmount,2) totalAmount,m.empid,e.codeno,e.name from "
						+ "hr_leavetraveldisbursementm m left join hr_empm e on m.empid=e.doc_no where m.status=3 and m.doc_no="+docNo+" and m.tr_no="+trNo+"");
				
				while (resultSet.next()) {
					    leaveTravelDisbursementBean.setTxtleavetraveldisbursementdocno(docNo);
					    leaveTravelDisbursementBean.setLeaveTravelDisbursementDate(resultSet.getDate("date").toString());
					    leaveTravelDisbursementBean.setNotifyDate(resultSet.getDate("notifydate").toString());
					    leaveTravelDisbursementBean.setTxtemployeedocno(resultSet.getInt("empid"));
					    leaveTravelDisbursementBean.setTxtemployeeid(resultSet.getString("codeno"));
					    leaveTravelDisbursementBean.setTxtemployeename(resultSet.getString("name"));
					    
					    leaveTravelDisbursementBean.setTxtalreadyprovisioneligibledays(resultSet.getDouble("leavesalarydays_already"));
					    leaveTravelDisbursementBean.setTxtcurrentprovisioneligibledays(resultSet.getDouble("leavesalarydays_current"));
					    leaveTravelDisbursementBean.setTxttotaleligibledays(resultSet.getDouble("leavesalarydays_total"));
					    leaveTravelDisbursementBean.setTxtleavesalarycalculated(resultSet.getDouble("leavesalaryamount_current"));
					    leaveTravelDisbursementBean.setTxtleavesalaryalreadyprovided(resultSet.getDouble("leavesalaryamount_already"));
					    leaveTravelDisbursementBean.setTxtleavesalarynettobeprovided(resultSet.getDouble("leavesalaryamount_net"));
					    leaveTravelDisbursementBean.setChckpartialpayment(resultSet.getInt("leavesalary_partial"));
					    leaveTravelDisbursementBean.setTxtleavesalarytobepaid(resultSet.getDouble("leavesalaryamount_tobepaid"));
					    leaveTravelDisbursementBean.setTxtleavesalarypaideligibledays(resultSet.getDouble("leavesalarydays_tobepaid"));
					    leaveTravelDisbursementBean.setTxttravelticketvalue(resultSet.getDouble("travel_ticketamount"));
					    leaveTravelDisbursementBean.setTxttravelalreadyposted(resultSet.getDouble("travelamount_already"));
					    leaveTravelDisbursementBean.setTxttravelcurrentexpenses(resultSet.getDouble("travel_currentexpense"));
						
					    leaveTravelDisbursementBean.setTxtdrtotal(resultSet.getDouble("totalAmount"));
					    leaveTravelDisbursementBean.setTxtcrtotal(resultSet.getDouble("totalAmount"));
					    leaveTravelDisbursementBean.setTxttrno(resultSet.getInt("tr_no"));
				}
			  stmtLTD.close();
			  conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return leaveTravelDisbursementBean;
			}
	 
	 public  ClsLeaveTravelDisbursementBean getPrint(HttpServletRequest request,int trno,Connection conn) throws SQLException {
		     ClsLeaveTravelDisbursementBean bean = new ClsLeaveTravelDisbursementBean();
			
		try {
			
			Statement stmtLTD = conn.createStatement();
			
			String headersql="select 'Leave/Travel Disbursement' vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_leavetraveldisbursementm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.tr_no="+trno+"";
			
			ResultSet resultSet = stmtLTD.executeQuery(headersql);
			
			while(resultSet.next()){
				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblprintname(resultSet.getString("vouchername"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLbllocation(resultSet.getString("location"));
			}
			
			String sqls="select e.codeno, e.name, m.doc_no, m.tr_no, DATE_FORMAT(m.date,'%d-%m-%Y') date, DATE_FORMAT(m.notifydate,'%d-%m-%Y') notifydate,\r\n" + 
					"round(m.leavesalarydays_already,2) leavesalarydays_already, round(m.leavesalarydays_current,2) leavesalarydays_current,\r\n" + 
					"round(m.leavesalarydays_total,2) leavesalarydays_total, round(m.leavesalaryamount_current,2) leavesalaryamount_current,\r\n" + 
					"round(m.leavesalaryamount_already,2) leavesalaryamount_already, round(m.leavesalaryamount_net,2) leavesalaryamount_net,\r\n" + 
					"round(m.leavesalaryamount_tobepaid,2) leavesalaryamount_tobepaid, round(m.travel_ticketamount,2) travel_ticketamount,\r\n" + 
					"round(m.travelamount_already,2) travelamount_already, round(m.travel_currentexpense,2) travel_currentexpense,\r\n" + 
					"round(m.totalAmount,2) totalAmount from hr_leavetraveldisbursementm m left join hr_empm e on (m.empid=e.doc_no and e.dtype='EMP')\r\n" + 
					"where m.tr_no="+trno+"";
			ResultSet resultSets = stmtLTD.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLbldate(resultSets.getString("date"));
				bean.setLblcalculatedupto(resultSets.getString("notifydate"));
				bean.setLbldocno(resultSets.getString("doc_no"));
				bean.setLblemployeename(resultSets.getString("codeno")+" - "+resultSets.getString("name"));
				
				bean.setLblalreadyprovisioneligibledays(resultSets.getString("leavesalarydays_already"));
				bean.setLblcurrentprovisioneligibledays(resultSets.getString("leavesalarydays_current"));
				bean.setLbltotaleligibledays(resultSets.getString("leavesalarydays_total"));
				bean.setLblleavesalarycalculated(resultSets.getString("leavesalaryamount_current"));
				bean.setLblleavesalaryalreadyprovided(resultSets.getString("leavesalaryamount_already"));
				bean.setLblleavesalarynettobeprovided(resultSets.getString("leavesalaryamount_net"));
				bean.setLblleavesalarytobepaid(resultSets.getString("leavesalaryamount_tobepaid"));
				
				bean.setLbltravelticketvalue(resultSets.getString("travel_ticketamount"));
				bean.setLbltravelalreadyposted(resultSets.getString("travelamount_already"));
				bean.setLbltravelcurrentexpenses(resultSets.getString("travel_currentexpense"));
				
				bean.setLbldrtotal(resultSets.getString("totalAmount"));
				bean.setLblcrtotal(resultSets.getString("totalAmount"));
				bean.setLbltrno(resultSets.getString("tr_no"));
			}
			
			stmtLTD.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return bean;
	  }

	 public int insertion(Connection conn,int docno, int trno,  Date leaveTravelDisbursementsDate, Date notifyingDate, String branch, int txtemployeedocno, String formdetailcode, 
				double txtcurrentprovisioneligibledays, double txttotaleligibledays, double txtleavesalarycalculated, double txtleavesalaryalreadyprovided, double txtleavesalarynettobeprovided, 
				int chckpartialpayment, double txtleavesalarytobepaid, double txtleavesalarypaideligibledays, double txttravelticketvalue, double txttravelalreadyposted, double txttravelcurrentexpenses, 
				ArrayList<String> accountsarray, HttpSession session,String mode) throws SQLException{
		     
			  try{
				    conn.setAutoCommit(false);
					CallableStatement stmtLTD;
					CallableStatement stmtLTD1;
					Statement stmtLTD2 = conn.createStatement();
					
					String userid=session.getAttribute("USERID").toString().trim();
					
					for(int i=0;i< accountsarray.size();i++){
					String[] journal=accountsarray.get(i).split("::");
					if(!journal[0].trim().equalsIgnoreCase("undefined") && !journal[0].trim().equalsIgnoreCase("NaN")){
					
					stmtLTD = conn.prepareCall("{CALL HRLeaveTravelDisbursementJournaldDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtLTD.setInt(10,docno);
					stmtLTD.setInt(11,trno);
					
					stmtLTD.setDate(1,leaveTravelDisbursementsDate); //Date
					stmtLTD.setString(2,"LTD - "+docno);
					stmtLTD.setInt(3,(i+1)); //SR_No
					stmtLTD.setString(4,(journal[0].trim().equalsIgnoreCase("undefined") || journal[0].trim().equalsIgnoreCase("NaN") || journal[0].trim().isEmpty()?0:journal[0].trim()).toString());  //doc_no of my_head
					stmtLTD.setString(5,(journal[1].trim().equalsIgnoreCase("undefined") || journal[1].trim().equalsIgnoreCase("NaN") || journal[1].trim().isEmpty()?0:journal[1].trim()).toString()); //amount
					stmtLTD.setString(6,(journal[2].trim().equalsIgnoreCase("undefined") || journal[2].trim().equalsIgnoreCase("NaN") || journal[2].trim().isEmpty()?0:journal[2].trim()).toString()); //credit -1 & debit 1
					stmtLTD.setString(7,formdetailcode);
					stmtLTD.setString(8,branch);
					stmtLTD.setString(9,userid);
					stmtLTD.setString(12,mode);
					stmtLTD.execute();
					if(stmtLTD.getInt("docNo")<=0){
						stmtLTD.close();
						conn.close();
						return 0;
					}
					/*my_jvtran Grid Saving Ends*/
						
					  stmtLTD.close();
					 }
					}	
					
					/*Disbursement Details Saving*/
					stmtLTD1 = conn.prepareCall("{CALL HRLeaveTravelDisbursementdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to hr_emptran*/
					stmtLTD1.setInt(16,trno); 
					stmtLTD1.setInt(17,docno);
					stmtLTD1.registerOutParameter(18, java.sql.Types.INTEGER);
					
					stmtLTD1.setDate(1,notifyingDate); //Date
					stmtLTD1.setInt(2,txtemployeedocno); //Employee ID
					stmtLTD1.setDouble(3,txtcurrentprovisioneligibledays); //Leave Salary Eligible Days
					stmtLTD1.setDouble(4,txttotaleligibledays); //Leave Salary Total Eligible Days 
					stmtLTD1.setDouble(5,txtleavesalarycalculated); //Leave Salary Calculated
					stmtLTD1.setDouble(6,txtleavesalaryalreadyprovided); //Leave Salary Already Posted
					stmtLTD1.setDouble(7,txtleavesalarynettobeprovided); //Leave Salary Net To Be Posted
					stmtLTD1.setDouble(8,chckpartialpayment); //Leave Salary Partial
					stmtLTD1.setDouble(9,txtleavesalarytobepaid); //Leave Salary Paid
					stmtLTD1.setDouble(10,txtleavesalarypaideligibledays); //Leave Salary Paid Eligible Days
					stmtLTD1.setDouble(11,txttravelticketvalue); //Ticket Value
					stmtLTD1.setDouble(12,txttravelalreadyposted); //Travels Already Posted
					stmtLTD1.setDouble(13,txttravelcurrentexpenses); //Travels To Be Posted
					stmtLTD1.setString(14,formdetailcode);
					stmtLTD1.setString(15,branch);
					stmtLTD1.setString(19,mode);
					int detail1=stmtLTD1.executeUpdate();
					if(detail1<=0){
						stmtLTD1.close();
						conn.close();
						return 0;
					}
						
					stmtLTD1.close();
					/*Disbursement Details Saving Ends*/
						
					/*Deleting amount of value zero*/
					String sql2=("DELETE FROM hr_emptran where TR_NO="+trno+" and terminalbenefits_tobeposted=0 and leavesalary_tobeposted=0 and travels_tobeposted=0");
				    int data = stmtLTD2.executeUpdate(sql2);
				    /*Deleting amount of value zero ends*/
				    
				    /*Deleting account of value zero*/
					String sql3=("DELETE FROM my_jvtran where TR_NO="+trno+" and acno=0");
					int data1 = stmtLTD2.executeUpdate(sql3);
					/*Deleting account of value zero ends*/
					
					/*Deleting amount of value zero*/
					String sql4=("DELETE FROM my_jvtran where TR_NO="+trno+" and dramount=0");
					int data3 = stmtLTD2.executeUpdate(sql4);
					/*Deleting amount of value zero ends*/
				    
					stmtLTD2.close();
					
		   }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return 0;
		 }
			return 1;
		}
	 
}
