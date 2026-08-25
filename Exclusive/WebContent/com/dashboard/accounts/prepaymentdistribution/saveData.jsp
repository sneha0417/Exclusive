<%@page import="com.common.ClsCommon"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();


	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt=conn.createStatement();
		Statement stmt1=conn.createStatement();
		
		String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
		String fromDate=request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
		String toDate=request.getParameter("todate")==null?"0":request.getParameter("todate");
		String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
		String formdetailcode="PREP";
		
		String sql=null;
		int val = 0, docNo = 0;
		java.sql.Date sqlFromDate=null;
		java.sql.Date sqlToDate=null;
		
		fromDate.trim();
        if(!(fromDate.equalsIgnoreCase("undefined"))&&!(fromDate.equalsIgnoreCase(""))&&!(fromDate.equalsIgnoreCase("0")))
        {
        	sqlFromDate = ClsCommon.changeStringtoSqlDate(fromDate);
        }
        
        toDate.trim();
        if(!(toDate.equalsIgnoreCase("undefined"))&&!(toDate.equalsIgnoreCase(""))&&!(toDate.equalsIgnoreCase("0")))
        {
        	sqlToDate = ClsCommon.changeStringtoSqlDate(toDate);
        }
        	
		ArrayList<String> prepaymentmasterarray=new ArrayList<String>();
		ArrayList<String> prepaymentdetailedarray=new ArrayList<String>();
		
		String xsql="";
		
		if(!(sqlFromDate==null)){
        	xsql+=" and date>='"+sqlFromDate+"'";
	    }
        
        if(!(sqlToDate==null)){
        	xsql+=" and date<='"+sqlToDate+"'";
	    }
        
        if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
        	xsql+=" and doc_no='"+docno+"'";
        }
        
		String sql1="select tranid,acno,postacno,stdate,enddate,costtype,costcode,amount,brhid,tr_no,TIMESTAMPDIFF(MONTH, stdate, enddate) monthdiff from gl_bpd where status=3 and prep=0"+xsql+"";
		ResultSet resultset = stmt.executeQuery(sql1);
		System.out.println("sql1===="+sql1);
		 while(resultset.next()) {
			 
			 prepaymentmasterarray.add(resultset.getString("tranid")+"::"+resultset.getString("acno")+"::"+resultset.getString("postacno")+"::"+resultset.getString("stdate")+"::"+resultset.getString("enddate")+"::"+resultset.getString("costtype")+"::"+resultset.getString("costcode")+"::"+resultset.getString("amount")+"::"+resultset.getString("brhid")+"::"+resultset.getString("tr_no")+"::"+resultset.getString("monthdiff"));
			 
			 ArrayList<String> distributeDetails = new ArrayList<String>();
			 distributeDetails=getDistributedDetails(conn, resultset.getDate("stdate"), resultset.getDate("enddate"), "2", resultset.getString("amount"), resultset.getString("monthdiff"), "0", "0",resultset.getString("tranid"),resultset.getString("postacno")); 
				
			 prepaymentdetailedarray.addAll(distributeDetails);
		 } 
		 System.out.println("prepaymentdetailedarray===="+prepaymentdetailedarray);
		for(int i=0;i< prepaymentmasterarray.size();i++){
			CallableStatement stmtPREP=null;
			String[] prepaymentmaster=prepaymentmasterarray.get(i).toString().split("::");
			
			long millis=System.currentTimeMillis();  
	        java.sql.Date prePaymentDate=new java.sql.Date(millis);  
	        
			stmtPREP = conn.prepareCall("{CALL prepaymentmDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtPREP.registerOutParameter(18, java.sql.Types.INTEGER);
			
			stmtPREP.setDate(1,prePaymentDate); //date
			stmtPREP.setInt(2,Integer.parseInt(prepaymentmaster[1].trim())); //acno
			stmtPREP.setInt(3,Integer.parseInt(prepaymentmaster[2].trim())); //Post acno
			stmtPREP.setString(4,prepaymentmaster[3]); //start date
			stmtPREP.setInt(5, 0); //due after
			stmtPREP.setInt(6, Integer.parseInt(prepaymentmaster[5].trim())); //cost type
			stmtPREP.setInt(7, Integer.parseInt(prepaymentmaster[6].trim())); //cost code
			stmtPREP.setString(8, "2"); //frequency type
			stmtPREP.setInt(9, Integer.parseInt(prepaymentmaster[10].trim())); //no of installments
			stmtPREP.setDouble(10, Double.parseDouble(prepaymentmaster[7].trim())); //amount
			
			stmtPREP.setDouble(11, 0); //installment amount
			stmtPREP.setInt(12, 0); //installment type
			
			stmtPREP.setString(13, "PREPAYMENT DISTRIBUTED"); //description
			stmtPREP.setInt(14, Integer.parseInt(prepaymentmaster[0].trim())); //tranid of acno
			
			stmtPREP.setString(15,formdetailcode);
			
			stmtPREP.setString(16,session.getAttribute("BRANCHID").toString().trim());
			stmtPREP.setString(17,session.getAttribute("USERID").toString().trim());
			stmtPREP.setInt(19, Integer.parseInt(prepaymentmaster[9].trim()));
			stmtPREP.setString(20,"A");
			val=stmtPREP.executeUpdate();
			System.out.println("===="+val+"====="+stmtPREP);
			if(val<=0){
				stmtPREP.close();
				conn.close();
			 }
			int prepdocno=stmtPREP.getInt("docNo");
			System.out.println("===="+prepdocno);	
			String sql2=("update my_jvtran set prep=1 where tr_no="+prepaymentmaster[9].trim()+" and tranid="+prepaymentmaster[0].trim());
            val = stmt1.executeUpdate(sql2);
            System.out.println(val+"===="+sql2);
			if(val<=0){
				stmt1.close();
				conn.close();
			}
			
			String sql3=("update gl_bpd set prep="+prepdocno+" where status=3 and prep=0 and tr_no="+prepaymentmaster[9].trim()+" and tranid="+prepaymentmaster[0].trim());
			val = stmt1.executeUpdate(sql3);
			System.out.println(val+"===="+sql3);
			if(val<=0){
				stmt1.close();
				conn.close();
			}
			
		}
		
		for(int j=0;j< prepaymentdetailedarray.size();j++){
		CallableStatement stmtPREP1=null;
		String[] distribution=prepaymentdetailedarray.get(j).toString().split("::");
		
			stmtPREP1 = conn.prepareCall("insert into my_prepd(tranId, sr_no, date, posted, postacno, jobid, amount) values(?,?,?,?,?,?,?)");
			
			stmtPREP1.setInt(1,Integer.parseInt(distribution[4]));
			stmtPREP1.setInt(2,Integer.parseInt(distribution[0]));
			stmtPREP1.setString(3,distribution[1]);
			stmtPREP1.setString(4,"0");
			stmtPREP1.setString(5,distribution[5]);
			stmtPREP1.setInt(6,0);
			stmtPREP1.setString(7,distribution[2]);
			val = stmtPREP1.executeUpdate();
			if(val<=0){
				stmtPREP1.close();
				conn.close();
			}
			System.out.println(val+"===="+stmtPREP1);
		}
		
	    response.getWriter().print(val);
	
	 	stmt.close();
	 	stmt1.close();
	 	conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
%>

<%!

	public ArrayList<String> getDistributedDetails(Connection conn,Date date,Date enddate,String cmbfrequency,String txtamount, String txtinstnos,String txtinstamt,String txtdueafter,String tranid,String postacno) throws SQLException {
		ArrayList<String> distributedDetails = new ArrayList<String>();
        
		try {
			    ClsCommon ClsCommon=new ClsCommon();
				Statement stmt1 = conn.createStatement();
			
				java.sql.Date xdate=null;
				java.sql.Date fdate=null;
				java.sql.Date newdate=null;
				java.sql.Date endsdate=null;
				
				double xtotal=0.0;
				double amount=0.0;
				int xsrno=0;
		        
				if(!(date==null)){
		        	xdate = date;
		        	fdate = date;
		        	newdate = date;
		        }
		        
				if(!(enddate==null)){
		        	endsdate = enddate;
		        }
		        
		        String xsql="";
		        
				xsql=Integer.parseInt(txtdueafter) + (cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
				
				if(!(txtdueafter.equalsIgnoreCase("0"))){
					
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
					distributedDetails.add(String.valueOf(sr_no)+"::"+xdate.toString()+"::"+String.valueOf(amount)+"::0::"+tranid+"::"+postacno);
					
					if(xtotal>=Double.parseDouble(txtamount)) break;
					//if (Integer.parseInt(txtinstnos)>0 && xsrno==Integer.parseInt(txtinstnos) && MyLib.getSum(txtamount, xtotal*-1, 2)>0)
					//{
						//preBrowse.cache.setData("Amount",MyLib.getSum(preBrowse.cache.getDouble("Amount"),
							//	MyLib.getSum(txtamount, xtotal*-1, 2),2));
								
                    //	xtotal+=MyLib.getSum(txtamount, xtotal*-1, 2);
					//}
					
					ResultSet rs = stmt1.executeQuery("Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+fdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(txtdueafter)+",'-',day('"+fdate+"')))) fdate ");
					
					if(rs.next()) xdate=rs.getDate("fdate");
					
					rs.close();
			} while(true);
				
			} else {
				
				int totalDays=0,noOfDays=0,srno=1;
				double perDay=0.00,instamt=0.00,total=0.00;
				
				if(endsdate==null){
					conn.close();
					return distributedDetails; 
				}
				
				if(xdate==null){
					conn.close();
					return distributedDetails; 
				}
				
				String sql1 = "SELECT DATEDIFF(coalesce('"+endsdate+"',null),coalesce('"+xdate+"',null)) totalDays";
				ResultSet rs1 = stmt1.executeQuery(sql1);
				
				while(rs1.next()) {
					totalDays=rs1.getInt("totalDays");
				} 
				
				String sql2 = "SELECT ("+txtamount+"/(("+totalDays+")+1)) perDay";
				ResultSet rs2 = stmt1.executeQuery(sql2);
				
				while(rs2.next()) {
					perDay=rs2.getDouble("perDay");
				} 

				int i=0;fdate = xdate;newdate = xdate;
				while(!(newdate.after(endsdate) || newdate.equals(endsdate))){
				   
				   if(newdate.after(endsdate) || newdate.equals(endsdate)){
				    	 break;
				   }
					
				   if(i==0){
					   
					   if(cmbfrequency.equalsIgnoreCase("2")){
						   
						   String sql4= "SELECT DATEDIFF(LAST_DAY('"+fdate+"'),'"+fdate+"') noOfDays";
						   ResultSet rs3 = stmt1.executeQuery(sql4);
						   
						   while(rs3.next()){
							   noOfDays=rs3.getInt("noOfDays");
						    }
						   
						   String sql5= "SELECT LAST_DAY('"+fdate+"') fdate,LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 1 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+")) newdate,(round("+perDay+",2)*(("+noOfDays+")+1)) installments";
						   ResultSet rs4 = stmt1.executeQuery(sql5);
						   
						   while(rs4.next()){
							   	 fdate=rs4.getDate("fdate");
							   	 newdate=rs4.getDate("newdate");
							   	 instamt=rs4.getDouble("installments");
						     }
						   
					   }
					   
					   if(cmbfrequency.equalsIgnoreCase("3")){
						   
						   String sql4= "SELECT DATEDIFF(CONCAT(YEAR('"+fdate+"'),'-12-31'),'"+fdate+"') noOfDays";
						   ResultSet rs3 = stmt1.executeQuery(sql4);
						   
						   while(rs3.next()){
							   noOfDays=rs3.getInt("noOfDays");
						    }
						   
						   String sql5= "SELECT CONCAT(YEAR('"+fdate+"'),'-12-31') fdate,DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 1  Year ) newdate,(round("+perDay+",2)*(("+noOfDays+")+1)) installments";
						   ResultSet rs4 = stmt1.executeQuery(sql5);
						   
						   while(rs4.next()){
							   	 fdate=rs4.getDate("fdate");
							   	 newdate=rs4.getDate("newdate");
							   	 instamt=rs4.getDouble("installments");
						     }
						   
					   }
					   
					    total+=instamt;
					   
						distributedDetails.add(String.valueOf(srno)+"::"+fdate.toString()+"::"+String.valueOf(instamt)+"::0::"+tranid+"::"+postacno);
					   
						srno++;
					   
					} else {
						
						   if(newdate.after(endsdate) || newdate.equals(endsdate)){
							   break;
					       }
						
						   if(cmbfrequency.equalsIgnoreCase("2")){
							   
							   String sql4= "SELECT EXTRACT(DAY FROM LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 1 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+"))) noOfDays";
							   ResultSet rs3 = stmt1.executeQuery(sql4);
							   
							   while(rs3.next()){
								   noOfDays=rs3.getInt("noOfDays");
							    }
							   
							   String sql5= "SELECT LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 1 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+")) fdate,LAST_DAY(DATE_ADD('"+fdate+"', INTERVAL 2 "+(cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ")+")) newdate,(round("+perDay+",2)*"+noOfDays+") installments";
							   ResultSet rs4 = stmt1.executeQuery(sql5);
							   
							   while(rs4.next()){
								   	 fdate=rs4.getDate("fdate");
								   	 newdate=rs4.getDate("newdate");
								   	 instamt=rs4.getDouble("installments");
							     }
						   }
						   
						   if(cmbfrequency.equalsIgnoreCase("3")){
							   
							   if(newdate.after(endsdate) || newdate.equals(endsdate)){
							    	 break;
							      }
							   
							   String sql4= "SELECT DATEDIFF(DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 1  Year ),CONCAT(YEAR('"+fdate+"'),'-12-31')) noOfDays";
							   ResultSet rs3 = stmt1.executeQuery(sql4);
							   
							   while(rs3.next()){
								   noOfDays=rs3.getInt("noOfDays");
							    }
							   
							   String sql5= "SELECT DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 1  Year ) fdate,DATE_ADD(CONCAT(YEAR('"+fdate+"'),'-12-31'), INTERVAL 2  Year ) newdate,(round("+perDay+",2)*"+noOfDays+") installments";
							   ResultSet rs4 = stmt1.executeQuery(sql5);
							   
							   while(rs4.next()){
								   	 fdate=rs4.getDate("fdate");
								   	 newdate=rs4.getDate("newdate");
								   	 instamt=rs4.getDouble("installments");
							     }
						   }
						   
						    total+=instamt;
						   
							distributedDetails.add(String.valueOf(srno)+"::"+fdate.toString()+"::"+String.valueOf(instamt)+"::0::"+tranid+"::"+postacno);
							     
						    srno++;
				   }
				   i++;
				}
				
					   String sql6= "SELECT round("+txtamount+"-"+total+",2) installments";
					   ResultSet rs5 = stmt1.executeQuery(sql6);
					   
					   while(rs5.next()){
						   	 instamt=rs5.getDouble("installments");
					     }
					   
						distributedDetails.add(String.valueOf(srno)+"::"+endsdate.toString()+"::"+String.valueOf(instamt)+"::0::"+tranid+"::"+postacno);
				
			}
				stmt1.close();
				
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} 
		return distributedDetails;
    }

%>
  
