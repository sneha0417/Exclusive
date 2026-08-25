package com.humanresource.transactions.deductionschedule;

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
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.humanresource.transactions.deductionschedule.ClsDeductionScheduleBean;

public class ClsDeductionScheduleDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsDeductionScheduleBean deductionScheduleBean = new ClsDeductionScheduleBean();
	
	public int insert(String formdetailcode, Date deductionsScheduleDate,String txtemployeerefno, int txtemployeedocno, double txtamount,int txtinstnos, Date startingDate, 
			double txtinstamt,String txtdescription, ArrayList<String> deductionschedulearray,HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		
		Connection conn = null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			
			CallableStatement stmtDSC = conn.prepareCall("{CALL HR_deductionSchedulemDML(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtDSC.registerOutParameter(12, java.sql.Types.INTEGER);
			
			stmtDSC.setDate(1,deductionsScheduleDate);
			stmtDSC.setInt(2,txtemployeedocno);
			stmtDSC.setString(3,txtemployeerefno);
			stmtDSC.setString(4,txtdescription);
			stmtDSC.setDouble(5,txtamount);
			stmtDSC.setInt(6,txtinstnos);
			stmtDSC.setDate(7,startingDate);
			stmtDSC.setString(8,formdetailcode);
			stmtDSC.setString(9,company);
			stmtDSC.setString(10,branch);
			stmtDSC.setString(11,userid);
			stmtDSC.setString(13,mode);
			int datas=stmtDSC.executeUpdate();
			if(datas<=0){
				stmtDSC.close();
				conn.close();
				return 0;
			}
			int docno=stmtDSC.getInt("docNo");
			deductionScheduleBean.setTxtdeductionscheduledocno(docno);
			if (docno > 0) {
				
				/*Insertion to hr_addschd*/
				int insertData=insertion(conn, docno, deductionschedulearray, session,mode);
				if(insertData<=0){
					stmtDSC.close();
					conn.close();
					return 0;
				}
				/*Insertion to hr_addschd Ends*/
				
				conn.commit();
				stmtDSC.close();
				conn.close();
				return docno;
		      }
				
			stmtDSC.close();
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
	
	public boolean edit(int txtdeductionscheduledocno,String formdetailcode, Date deductionsScheduleDate,String txtemployeerefno, int txtemployeedocno, 
			double txtamount, int txtinstnos, Date startingDate, double txtinstamt,String txtdescription, ArrayList<String> deductionschedulearray,
			HttpSession session, HttpServletRequest request, String mode) throws SQLException {
		Connection conn = null;
	 	
		 try{
			    conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
			
				Statement stmtDSC = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				String company=session.getAttribute("COMPANYID").toString().trim();
				
				/*Updating hr_addschm*/
               String sql=("update hr_addschm set  date='"+deductionsScheduleDate+"',refNo='"+txtemployeerefno+"', empid='"+txtemployeedocno+"', description='"+txtdescription+"', amount="+txtamount+", instno='"+txtinstnos+"', stdate='"+startingDate+"', dTYPE='"+formdetailcode+"',cmpId='"+company+"',brhId='"+branch+"',userId='"+userid+"' where doc_no="+txtdeductionscheduledocno);
               int data = stmtDSC.executeUpdate(sql);
				if(data<=0){
					conn.close();
					return false;
				}
				/*Updating hr_addschm Ends*/
				
				/*Inserting into datalog*/
				String sql1=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtdeductionscheduledocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','E')");
				int data1 = stmtDSC.executeUpdate(sql1);
				/*Inserting into datalog Ends*/
			    
			    String sql2=("DELETE FROM hr_addschd WHERE rdocno="+txtdeductionscheduledocno);
			    int data2 = stmtDSC.executeUpdate(sql2);
			    
			    int docno=txtdeductionscheduledocno;
			    deductionScheduleBean.setTxtdeductionscheduledocno(docno);
				if (docno > 0) {
				
					/*Insertion to hr_addschd*/
					int insertData=insertion(conn, docno, deductionschedulearray, session,mode);
					if(insertData<=0){
						stmtDSC.close();
						conn.close();
						return false;
					}
					/*Insertion to hr_addschd Ends*/
						
						conn.commit();
						stmtDSC.close();
						conn.close();
						return true;
				}
				stmtDSC.close();
			    conn.close();
		 }catch(Exception e){
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
		return false;
	}
	
	public boolean delete(int txtdeductionscheduledocno, String formdetailcode, HttpSession session) throws SQLException {
		Connection conn = null; 
		
		try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				Statement stmtDSC = conn.createStatement();
				
				String branch=session.getAttribute("BRANCHID").toString().trim();
				String userid=session.getAttribute("USERID").toString().trim();
				
				 /*Status change in my_jvtran*/
				 String sql=("update hr_addschm set STATUS=7 where doc_no="+txtdeductionscheduledocno+"");
				 int data = stmtDSC.executeUpdate(sql);
				/*Status change in my_jvtran Ends*/
				 
				 /*Inserting into datalog*/
				 String sqls=("insert into datalog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+txtdeductionscheduledocno+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','D')");
				 int datas = stmtDSC.executeUpdate(sqls);
				 /*Inserting into datalog Ends*/
				 
				 int docno=txtdeductionscheduledocno;
				 deductionScheduleBean.setTxtdeductionscheduledocno(docno);
				 
				if (docno > 0) {
					conn.commit();
					stmtDSC.close();
				    conn.close();
					return true;
				}	
				stmtDSC.close();
			    conn.close();
		 }catch(Exception e){	
			 	e.printStackTrace();
			 	conn.close();
			 	return false;
		 }finally{
			 conn.close();
		 }
		return false;
	}
	
	public JSONArray deductionScheduleGridReloading(String docNo) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDSC = conn.createStatement();
			
				String sqlnew=("select rowno sr_no,date,amount,posted,postedtrno,srno rowno from hr_addschd where rdocno="+docNo+"");
				ResultSet resultSet = stmtDSC.executeQuery (sqlnew);
                
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmtDSC.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
	
	public JSONArray deductionScheduleGrid(String date,String txtamount, String txtinstnos,String txtinstamt) throws SQLException {
        JSONArray jsonArray = new JSONArray();
        
        Connection conn = null; 
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDSC = conn.createStatement();
			
				java.sql.Date xdate=null;
				java.sql.Date fdate=null;
				
				double xtotal=0.0;
				double amount=0.0;
				int xsrno=0;
		        
		        date.trim();
		        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		        	xdate = ClsCommon.changeStringtoSqlDate(date);
		        	fdate = ClsCommon.changeStringtoSqlDate(date);
		        }
		        
		        String xsql="";
		        String cmbfrequency="2";
		        String txtdueafter="1";
		        
				xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
				
				do							
				{	
					++xsrno;
					if (Integer.parseInt(txtinstnos)>0 && xsrno>Integer.parseInt(txtinstnos))
					break;
					
					int sr_no= xsrno;							
					int actualNoOfInst=xsrno;
					
					amount=((xtotal+Double.parseDouble(txtinstamt))>Double.parseDouble(txtamount)?(Double.parseDouble(txtamount)-xtotal):Double.parseDouble(txtinstamt));
					xtotal+=amount;
					
					//setting values to grid
					JSONObject obj = new JSONObject();
					obj.put("sr_no",String.valueOf(sr_no));

					if(!(xdate==null)){
						obj.put("date",xdate.toString());
					}
					obj.put("amount",String.valueOf(amount));
					obj.put("posted",0);
					obj.put("postedtrno",0);
					
					jsonArray.add(obj);
					
					if(xtotal>=Double.parseDouble(txtamount)) break;
					//if (Integer.parseInt(txtinstnos)>0 && xsrno==Integer.parseInt(txtinstnos) && MyLib.getSum(txtamount, xtotal*-1, 2)>0)
					//{
						//preBrowse.cache.setData("Amount",MyLib.getSum(preBrowse.cache.getDouble("Amount"),
							//	MyLib.getSum(txtamount, xtotal*-1, 2),2));
								
                    //	xtotal+=MyLib.getSum(txtamount, xtotal*-1, 2);
					//}
					
					ResultSet rs = stmtDSC.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+fdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+fdate+"')))) fdate ");
					if(rs.next()) xdate=rs.getDate("fdate");
					
					rs.close();
			}while(true);
				
			
				stmtDSC.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return jsonArray;
    }
	
	public JSONArray employeeDetailsSearch(HttpSession session,String empname,String mob,String employeedesignation,String employeedepartment,String empid,String dob) throws SQLException {

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
             
           String brid=session.getAttribute("BRANCHID").toString();
       
        java.sql.Date sqlDateofBirth=null;
       
        dob.trim();
        if(!(dob.equalsIgnoreCase("undefined"))&&!(dob.equalsIgnoreCase(""))&&!(dob.equalsIgnoreCase("0")))
        {
        	sqlDateofBirth = ClsCommon.changeStringtoSqlDate(dob);
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
        	sqltest=sqltest+" and m.emp_id like '%"+empid+"%'";
        }
        if(!(sqlDateofBirth==null)){
        	sqltest=sqltest+" and m.dob='"+sqlDateofBirth+"'";
        } 
           
     try {
    	   conn = ClsConnection.getMyConnection();
    	   Statement stmtEMP = conn.createStatement();
       
	       ResultSet resultSet = stmtEMP.executeQuery("select m.name,if(m.prmob is null,m.pmmob,if(m.prmob=' ',m.pmmob,m.prmob)) mob,dg.desc1 designation,dp.desc1 department,"  
	       	  + "m.dob,m.emp_id,m.doc_no,convert(concat(' Employee : ',coalesce(m.emp_id),' - ',coalesce(m.name), ' * ','Mobile  : ',coalesce(if(m.prmob is null,m.pmmob,"
	    	  + "if(m.prmob=' ',m.pmmob,m.prmob))),' * ','Designation : ' ,coalesce(dg.desc1),' * ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_empm m "
	       	  + "left join hr_setdesig dg on m.desc_id=dg.doc_no left join hr_setdept dp on m.dept_id=dp.doc_no where m.status=3 and m.dtype='EMP'" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtEMP.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
    	 conn.close();
     }
       return RESULTDATA;
   }
	
	public JSONArray dscMainSearch(HttpSession session,String empname,String docNo,String date,String amount) throws SQLException {

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
        if(!(amount.equalsIgnoreCase(""))){
        	sqltest=sqltest+" and m.amount like '%"+amount+"%'";
        }
        if(!(sqlDate==null)){
        	sqltest=sqltest+" and m.date='"+sqlDate+"'";
	    } 
           
     try {
	       conn = ClsConnection.getMyConnection();
	       Statement stmtDSC = conn.createStatement();
	       
	       ResultSet resultSet = stmtDSC.executeQuery("select m.date,m.doc_no,m.amount,e.name from hr_addschm m left join hr_empm e on m.empid=e.doc_no where m.brhid="+branch+" and m.dtype='DSC' "  
	       	+ "and m.status<>7" +sqltest);
	
	       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	       
	       stmtDSC.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	 public  ClsDeductionScheduleBean getViewDetails(HttpSession session,int docNo) throws SQLException {
		    ClsDeductionScheduleBean deductionScheduleBean = new ClsDeductionScheduleBean();
			
			Connection conn = null;
			
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtDSC = conn.createStatement();
			
				String branch = session.getAttribute("BRANCHID").toString();
				
				ResultSet resultSet = stmtDSC.executeQuery ("select m.date,m.refno,round(m.amount,2) amount,m.instno,m.stdate,m.description,e.doc_no empdocno,convert(concat(' Employee : ',"
					+ "coalesce(e.emp_id),' - ',coalesce(e.name), '   ','Mobile  : ',coalesce(if(e.prmob is null,e.pmmob,if(e.prmob=' ',e.pmmob,e.prmob))),'   ',"
					+ "'Designation : ' ,coalesce(dg.desc1),'   ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_addschm m left join hr_empm e "
					+ "on m.empid=e.doc_no left join hr_setdesig dg on e.desc_id=dg.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no where m.dtype='DSC' and "
					+ "m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo);
				
				while (resultSet.next()) {
						deductionScheduleBean.setTxtdeductionscheduledocno(docNo);
						deductionScheduleBean.setDeductionScheduleDate(resultSet.getDate("date").toString());
						deductionScheduleBean.setTxtemployeerefno(resultSet.getString("refno"));
						deductionScheduleBean.setTxtemployeedetails(resultSet.getString("empinfo"));
						deductionScheduleBean.setTxtemployeedocno(resultSet.getInt("empdocno"));
					
						deductionScheduleBean.setTxtamount(resultSet.getDouble("amount"));
						deductionScheduleBean.setTxtinstnos(resultSet.getInt("instno"));
						deductionScheduleBean.setTxtinstamt(resultSet.getDouble("amount"));
						deductionScheduleBean.setStartDate(resultSet.getString("stdate").toString());
						deductionScheduleBean.setTxtdescription(resultSet.getString("description"));

				}
			  stmtDSC.close();
			  conn.close();
			} catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			return deductionScheduleBean;
			}
	 
	 
	 public ClsDeductionScheduleBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsDeductionScheduleBean bean = new ClsDeductionScheduleBean();
		 Connection conn = null;
		 
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtDSC = conn.createStatement();
			
			int trno=0,empid=0;
			
			String headersql="select if(m.dtype='DSC','Deduction Schedule','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_addschm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='DSC' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtDSC.executeQuery(headersql);
			//System.out.println("print header--->"+headersql);
			while(resultSetHead.next()){
				
				bean.setLblcompname(resultSetHead.getString("company"));
				bean.setLblcompaddress(resultSetHead.getString("address"));
				bean.setLblprintname(resultSetHead.getString("vouchername"));
				bean.setLblcomptel(resultSetHead.getString("tel"));
				bean.setLblcompfax(resultSetHead.getString("fax"));
				bean.setLblbranch(resultSetHead.getString("branchname"));
				bean.setLbllocation(resultSetHead.getString("location"));
				bean.setLblcstno(resultSetHead.getString("cstno"));
				bean.setLblpan(resultSetHead.getString("pbno"));
				bean.setLblservicetax(resultSetHead.getString("stcno"));
				bean.setLblpobox(resultSetHead.getString("pbno"));
			}
			
			String sqls="select DATE_FORMAT(m.date ,'%d-%m-%Y') date,m.refno,round(m.amount,2) amount,m.instno,m.doc_no,DATE_FORMAT(m.stdate ,'%d-%m-%Y') stdate,m.description,e.doc_no empdocno,convert(concat(' Employee : ',"
					+ "coalesce(e.emp_id),' - ',coalesce(e.name), '   ','Mobile  : ',coalesce(if(e.prmob is null,e.pmmob,if(e.prmob=' ',e.pmmob,e.prmob))),'   ',"
					+ "'Designation : ' ,coalesce(dg.desc1),'   ','Department : ', coalesce(dp.desc1)),char(1000)) empinfo from hr_addschm m left join hr_empm e "
					+ "on m.empid=e.doc_no left join hr_setdesig dg on e.desc_id=dg.doc_no left join hr_setdept dp on e.dept_id=dp.doc_no where m.dtype='DSC' and "
					+ "m.status<>7 and m.brhId='"+branch+"' and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtDSC.executeQuery(sqls);
			//System.out.println("print body1--->"+sqls);
			while(resultSets.next()){
				
				/*bean.setLblvoucherno(resultSets.getString("empdocno"));*/
				
				bean.setDeductionScheduleDate(resultSets.getString("date"));
				bean.setTxtemployeedetails(resultSets.getString("empinfo"));
				bean.setTxtdeductionscheduledocno(resultSets.getInt("doc_no"));
				bean.setTxtemployeerefno(resultSets.getString("refno"));
				bean.setTxtamount(resultSets.getInt("amount"));
				bean.setTxtinstnos(resultSets.getInt("instno"));
				bean.setStartDate(resultSets.getString("stdate"));
				bean.setTxtdescription(resultSets.getString("description"));
				
				/*bean.setLbldesignation(resultSets.getString("designation"));
				bean.setLbldepartment(resultSets.getString("department"));
				bean.setLblcategory(resultSets.getString("category"));
				bean.setLbldateofjoin(resultSets.getString("dtjoin"));
				bean.setLblappraisaldt(resultSets.getString("appraisal"));
				bean.setLblnotifydate(resultSets.getString("notify"));
				bean.setLbldebittotal(resultSets.getString("totalAmount"));
				bean.setLblcredittotal(resultSets.getString("totalAmount"));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");
				empid=resultSets.getInt("empid");*/
			}
			
			String sqtab="select rowno as srno,date,amount from hr_addschd where rdocno="+docNo+"";
				
			ResultSet resultsettab = stmtDSC.executeQuery(sqtab);
			//System.out.println("print tab--->"+sqtab);
			while(resultsettab.next()){
				
				/*bean.setLblvoucherno(resultSets.getString("empdocno"));*/
				bean.setSrno(resultsettab.getInt("srno"));
				bean.setDate(resultsettab.getString("date"));
				bean.setAmount(resultsettab.getInt("amount"));
				
				/*bean.setLbldesignation(resultSets.getString("designation"));
				bean.setLbldepartment(resultSets.getString("department"));
				bean.setLblcategory(resultSets.getString("category"));
				bean.setLbldateofjoin(resultSets.getString("dtjoin"));
				bean.setLblappraisaldt(resultSets.getString("appraisal"));
				bean.setLblnotifydate(resultSets.getString("notify"));
				bean.setLbldebittotal(resultSets.getString("totalAmount"));
				bean.setLblcredittotal(resultSets.getString("totalAmount"));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");*/
			}
			
			bean.setTxtheader(header);
			
			String sql1 = "";

			sql1 = "select a.acno,if(a.debit=0,'  ',round(a.debit,2)) debit,if(a.credit=0,'  ',round(a.credit,2)) credit,t.account,t.description codeno from hr_terminationaccountd a left join my_head t "
				    + "on a.acno=t.doc_no where a.empid="+empid+" and a.tr_no="+trno+" and a.rdocno="+docNo+"";
			
			ResultSet resultSet1 = stmtDSC.executeQuery(sql1);
			
			ArrayList<String> printaccounting= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("codeno")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				printaccounting.add(temp);
			}
			
			request.setAttribute("printaccounting", printaccounting);

			String sql2 = "";
			 
			sql2 = "select description terminations,round(gratuity,2) gratuity,round(leavesalary,2) leavesalary,round(travels,2) travel from hr_terminationd where empid="+empid+" and tr_no="+trno+" and rdocno="+docNo+"";
				 
			ResultSet resultSet2 = stmtDSC.executeQuery(sql2);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet2.getString("terminations")+"::"+resultSet2.getString("gratuity")+"::"+resultSet2.getString("leavesalary")+"::"+resultSet2.getString("travel");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from hr_terminationm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='HTRE' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtDSC.executeQuery(sql3);
			
			while(resultSet3.next()){
				/*bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));*/
			}
		
			stmtDSC.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	 
	 
	 
	
	 public int insertion(Connection conn,int docno,ArrayList<String> deductionschedulearray,HttpSession session,String mode) throws SQLException{
		     
		  try{
			  Statement stmtDSC1 = conn.createStatement();
			  
			  /*Deduction Schedule Grid Saving*/
				int data=0;
				for(int i=0;i< deductionschedulearray.size();i++){
				String[] deductionschedule=deductionschedulearray.get(i).toString().split("::");
				
				if(!deductionschedule[2].equalsIgnoreCase("undefined") && !deductionschedule[2].equalsIgnoreCase("NaN")){
					
					java.sql.Date distributionDate=null;
					
					if(!((deductionschedule[1].toString()) == null)){
						distributionDate = ClsCommon.changetstmptoSqlDate((deductionschedule[1].equalsIgnoreCase("undefined") || deductionschedule[1].equalsIgnoreCase("NaN") || deductionschedule[1].isEmpty()?0:deductionschedule[1]).toString());
					}
				
					String sql="insert into hr_addschd(rdocno, rowno, date, amount, posted ,postedtrno) values ("+docno+","+(i+1)+",'"+distributionDate+"','"+(deductionschedule[2].trim().equalsIgnoreCase("undefined") || deductionschedule[2].trim().equalsIgnoreCase("NaN") || deductionschedule[2].trim().equalsIgnoreCase("") || deductionschedule[2].trim().isEmpty()?0:deductionschedule[2].trim())+"','"+(deductionschedule[3].trim().equalsIgnoreCase("undefined") || deductionschedule[3].trim().equalsIgnoreCase("NaN") || deductionschedule[3].trim().equalsIgnoreCase("") || deductionschedule[3].trim().isEmpty()?0:deductionschedule[3].trim())+"','"+(deductionschedule[3].trim().equalsIgnoreCase("undefined") || deductionschedule[5].trim().equalsIgnoreCase("NaN") || deductionschedule[5].trim().equalsIgnoreCase("") || deductionschedule[5].trim().isEmpty()?0:deductionschedule[5].trim())+"')";

				    data = stmtDSC1.executeUpdate(sql);
				 }
					if(data<=0){
						stmtDSC1.close();
						conn.close();
						return 0;
					}
				}
				/*Deduction Schedule Grid Saving Ends*/
				
	   }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}

	public ArrayList<String> getPrintdetails(int docno, HttpSession session) {
		
		ArrayList<String> arr=new ArrayList<String>();
		Connection conn = null;
		// String brhid=session.getAttribute("BRANCHID").toString();
		try {
			 conn = ClsConnection.getMyConnection();
			Statement stmtinv = conn.createStatement ();
			String strSqldetail="";
		strSqldetail="select rowno as srno,DATE_FORMAT(date ,'%d-%m-%Y') date,amount from hr_addschd where rdocno="+docno+" ";
		

		ResultSet rsdetail=stmtinv.executeQuery(strSqldetail);
		
		int rowcount=1;

		while(rsdetail.next()){

				String temp="";
				
				temp=rsdetail.getString("srno")+"::"+rsdetail.getString("date")+"::"+rsdetail.getString("amount");

				arr.add(temp);
				rowcount++;

		
			
	}
		stmtinv.close();
		conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return arr;

	}

}
