package com.common;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ClsCommonHR1 {

	public String getHRBASIC(Connection conn,String empID,String empCategoryID,Date sqlDate,Double basicSalary,String valueDaysToPay) throws SQLException {
    	String BASICAmount="0";
    	
		try{
			Statement stmtHRBASIC=conn.createStatement();
			Statement stmtHRBASIC1=conn.createStatement();
			Statement stmtHRBASIC2=conn.createStatement();
			Statement stmtHRBASIC3=conn.createStatement();
			Statement stmtHRBASIC4=conn.createStatement();
			
			String dailyRateFormula="",valueDAYS="0",valueYEARS="1",valueHRS="0",valueNH="0",valueBASIC="0",valueGROSS="0";
			
			String sqlBASIC = "select dailyRate,if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1)))) whrs from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
			ResultSet resultSetBASIC = stmtHRBASIC.executeQuery(sqlBASIC);		
			
			while(resultSetBASIC.next()){
				dailyRateFormula=resultSetBASIC.getString("dailyRate");
				valueHRS=resultSetBASIC.getString("whrs");
			}
			
			valueBASIC = String.valueOf(basicSalary);
			valueGROSS = String.valueOf(basicSalary);
			
			/*Select Current Month Days*/
			if(dailyRateFormula.contains("[DAYS]")) {
				
				String sqlBASIC1="select DAY(Last_DAY('"+sqlDate+"')) daysofmnth";
				ResultSet resultSetBASIC1 = stmtHRBASIC1.executeQuery(sqlBASIC1);
				
				while(resultSetBASIC1.next()){
					valueDAYS=resultSetBASIC1.getString("daysofmnth");
				}
			}
			/*Select Current Month Days Ends*/
			
			/*Select Current Years*/
			if(dailyRateFormula.contains("[YEARS]")) {
				
				String sqlBASIC2="select YEAR('"+sqlDate+"') mnthyear";
				ResultSet resultSetBASIC2 = stmtHRBASIC2.executeQuery(sqlBASIC2);
				
				while(resultSetBASIC2.next()){
					valueYEARS=resultSetBASIC2.getString("mnthyear");
				}
			}
			/*Select Current Years Ends*/
			
			/*Daily Rate Formula*/
			dailyRateFormula=dailyRateFormula.replaceAll("DAYS", valueDAYS);
			dailyRateFormula=dailyRateFormula.replaceAll("YEARS", valueYEARS);
			dailyRateFormula=dailyRateFormula.replaceAll("HRS", valueHRS);
			dailyRateFormula=dailyRateFormula.replaceAll("NH", valueNH);
			dailyRateFormula=dailyRateFormula.replaceAll("BASIC", valueBASIC);
			dailyRateFormula=dailyRateFormula.replaceAll("GROSS", valueGROSS);
			/*Daily Rate Formula Ends*/
			
			String sqlBASIC3="select REPLACE( REPLACE ('"+dailyRateFormula+"','[',''),']','') dailyRateValue";
			ResultSet resultSetBASIC3 = stmtHRBASIC3.executeQuery(sqlBASIC3);		
			
			while(resultSetBASIC3.next()){
				dailyRateFormula=resultSetBASIC3.getString("dailyRateValue");
			}
			
			String sqlBASIC4="select round("+valueDaysToPay+"*("+dailyRateFormula+"),0) BASIC";
			ResultSet resultSetBASIC4 = stmtHRBASIC4.executeQuery(sqlBASIC4);		
			
			while(resultSetBASIC4.next()){
				BASICAmount=resultSetBASIC4.getString("BASIC");
			}
			
		stmtHRBASIC.close();
		stmtHRBASIC1.close();
		stmtHRBASIC2.close();
		stmtHRBASIC3.close();
		stmtHRBASIC4.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return BASICAmount;
		}
		return BASICAmount;
	}
	
	public String getHRALLOWANCES(Connection conn,String empID,String empCategoryID,Date sqlDate,Double allowance,String valueDaysToPay) throws SQLException {
    	String AllowanceAmount="0";
    	
		try{
			Statement stmtHRALC=conn.createStatement();
			Statement stmtHRALC1=conn.createStatement();
			Statement stmtHRALC2=conn.createStatement();
			Statement stmtHRALC3=conn.createStatement();
			Statement stmtHRALC4=conn.createStatement();
			
			String dailyRateFormula="",valueDAYS="0",valueYEARS="1",valueHRS="0",valueNH="0",valueBASIC="0",valueGROSS="0";
			
			String sqlALC = "select dailyRate,if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1)))) whrs from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
			ResultSet resultSetALC = stmtHRALC.executeQuery(sqlALC);		
			
			while(resultSetALC.next()){
				dailyRateFormula=resultSetALC.getString("dailyRate");
				valueHRS=resultSetALC.getString("whrs");
			}
			
			valueBASIC = String.valueOf(allowance);
			valueGROSS = String.valueOf(allowance);
			
			/*Select Current Month Days*/
			if(dailyRateFormula.contains("[DAYS]")) {
				
				String sqlALC1="select DAY(Last_DAY('"+sqlDate+"')) daysofmnth";
				ResultSet resultSetALC1 = stmtHRALC1.executeQuery(sqlALC1);
				
				while(resultSetALC1.next()){
					valueDAYS=resultSetALC1.getString("daysofmnth");
				}
			}
			/*Select Current Month Days Ends*/
			
			/*Select Current Years*/
			if(dailyRateFormula.contains("[YEARS]")) {
				
				String sqlALC2="select YEAR('"+sqlDate+"') mnthyear";
				ResultSet resultSetALC2 = stmtHRALC2.executeQuery(sqlALC2);
				
				while(resultSetALC2.next()){
					valueYEARS=resultSetALC2.getString("mnthyear");
				}
			}
			/*Select Current Years Ends*/
			
			/*Daily Rate Formula*/
			dailyRateFormula=dailyRateFormula.replaceAll("DAYS", valueDAYS);
			dailyRateFormula=dailyRateFormula.replaceAll("YEARS", valueYEARS);
			dailyRateFormula=dailyRateFormula.replaceAll("HRS", valueHRS);
			dailyRateFormula=dailyRateFormula.replaceAll("NH", valueNH);
			dailyRateFormula=dailyRateFormula.replaceAll("BASIC", valueBASIC);
			dailyRateFormula=dailyRateFormula.replaceAll("GROSS", valueGROSS);
			/*Daily Rate Formula Ends*/
			
			String sqlALC3="select REPLACE( REPLACE ('"+dailyRateFormula+"','[',''),']','') dailyRateValue";
			ResultSet resultSetALC3 = stmtHRALC3.executeQuery(sqlALC3);		
			
			while(resultSetALC3.next()){
				dailyRateFormula=resultSetALC3.getString("dailyRateValue");
			}
			
			String sqlALC4="select round("+valueDaysToPay+"*("+dailyRateFormula+"),0) ALLOWANCE";
			ResultSet resultSetALC4 = stmtHRALC3.executeQuery(sqlALC4);		
			
			while(resultSetALC4.next()){
				AllowanceAmount=resultSetALC4.getString("ALLOWANCE");
			}
		
		stmtHRALC.close();
		stmtHRALC1.close();
		stmtHRALC2.close();
		stmtHRALC3.close();
		stmtHRALC4.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return AllowanceAmount;
		}
		return AllowanceAmount;
	}
	
	 public String getHREARNEDBASIC(Connection conn,String empID,String empCategoryID,Date sqlDate,Double basicSalary,String valueDaysToPay) throws SQLException {
	    	String EARNEDBASICAmount="0";
	    	
			try{
				Statement stmtEARNEDBASIC=conn.createStatement();
				Statement stmtEARNEDBASIC1=conn.createStatement();
				Statement stmtEARNEDBASIC3=conn.createStatement();
				
				ArrayList<String> leaveDetails = new ArrayList<String>();
				ArrayList<String> leavesTakenDetails = new ArrayList<String>();
				int totalleaveTypes=0;
				
				/*Leave Types*/
				String sqlEARNEDBASIC = "select doc_no leaveid,desc1 leavename from hr_setleave where status=3";
				ResultSet resultSetEARNEDBASIC = stmtEARNEDBASIC.executeQuery(sqlEARNEDBASIC);		
				
				while(resultSetEARNEDBASIC.next()){
					leaveDetails.add(resultSetEARNEDBASIC.getString("leaveid")+" ::"+resultSetEARNEDBASIC.getString("leavename"));
				}
				totalleaveTypes = leaveDetails.size();
				/*Leave Types Ends*/
				
				int loop=0;
				for(int i=1;i<=totalleaveTypes;i++){
					int carryForward=0,leaveDeduction=0;
					ArrayList<String> openingLeavesDetails = new ArrayList<String>();
					
					/*Checking Carry Forward*/
					String sqlEARNEDBASIC1 = "select cf,ded from hr_payleavem where rdocno="+empCategoryID+" and levid="+i+"";
					ResultSet resultSetEARNEDBASIC1 = stmtEARNEDBASIC1.executeQuery(sqlEARNEDBASIC1);		
				
					while(resultSetEARNEDBASIC1.next()){
						carryForward=resultSetEARNEDBASIC1.getInt("cf");
						leaveDeduction=resultSetEARNEDBASIC1.getInt("ded");
					}
					/*Checking Carry Forward Ends*/
					
					if(carryForward==1){
						Statement stmtEARNEDBASIC2=conn.createStatement();
						
						/*Opening leaves*/
						String sqlEARNEDBASIC2 = "select leaveid,sum(opnleaves) opnleaves from hr_setopeningleave where status=3 and Year(date)=YEAR('"+sqlDate+"') and leaveid="+i+" "  
								+ "and empid="+empID+" group by leaveid";
						ResultSet resultSetEARNEDBASIC2 = stmtEARNEDBASIC2.executeQuery(sqlEARNEDBASIC2);		
					
						while(resultSetEARNEDBASIC2.next()){
							openingLeavesDetails.add(resultSetEARNEDBASIC2.getString("leaveid")+" ::"+resultSetEARNEDBASIC2.getDouble("opnleaves"));
						}
						/*Opening leaves Ends*/
						
						stmtEARNEDBASIC2.close();
					}
					
					/*Leaves Taken*/
					String sqlEARNEDBASIC3 = "select '"+i+"' leaveid,if(mod(round(sum(t.tot_leave"+i+"),1),1)=0,round(sum(t.tot_leave"+i+"),0),round(sum(t.tot_leave"+i+"),1)) leavestaken from hr_timesheet t "
							+ "left join hr_empm m on t.empid=m.doc_no where m.active=1 and m.status=3 and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') "
							+ "and t.empid="+empID+" group by t.empid";
					ResultSet resultSetEARNEDBASIC3 = stmtEARNEDBASIC3.executeQuery(sqlEARNEDBASIC3);		
				
					while(resultSetEARNEDBASIC3.next()){
						leavesTakenDetails.add(resultSetEARNEDBASIC3.getString("leaveid")+" ::"+resultSetEARNEDBASIC3.getDouble("leavestaken"));
					}
					/*Leaves Taken Ends*/
					
					if(leaveDeduction==1){
						
						Statement stmtEARNEDBASIC4=conn.createStatement();
						Statement stmtEARNEDBASIC5=conn.createStatement();
						Double leavesOpn = 0.00,leavesTaken = 0.00;
						
						if(openingLeavesDetails.size()>0){
							String[] opnLeaves=openingLeavesDetails.get((i-1)).split("::");
							leavesOpn = ((opnLeaves[1].isEmpty()?0.0:Double.parseDouble(opnLeaves[1])));
						}
						
						if(leavesTakenDetails.size()>0){
							String[] takenLeaves=leavesTakenDetails.get((i-1)).split("::");
							leavesTaken = ((takenLeaves[1].isEmpty()?0.0:Double.parseDouble(takenLeaves[1])));
						}
						
						/*Deduction Percentage*/
						ArrayList<String> deductionPercDetails = new ArrayList<String>();
						ArrayList<String> deductionEffectDetails = new ArrayList<String>();
						
						String sqlEARNEDBASIC4 = "select levid leaveid,("+leavesOpn+"+"+leavesTaken+") totalLeaves,CASE WHEN (l3=0 and l2=0) then  l1ded WHEN  ("+leavesOpn+"+"+leavesTaken+")  between 0 and l1  then l1ded WHEN  ("+leavesOpn+"+"+leavesTaken+") between 0 and l2 then l2ded "
								+ "WHEN ("+leavesOpn+"+"+leavesTaken+") between 0 and l3  then if(l3=0,l2ded,l3ded) WHEN   11>=l3  then if(l3=0,l2ded,l3ded) END AS deductionPerc from hr_payleavem where rdocno="+empCategoryID+" and levid="+i+"";
						ResultSet resultSetEARNEDBASIC4 = stmtEARNEDBASIC4.executeQuery(sqlEARNEDBASIC4);		
					
						while(resultSetEARNEDBASIC4.next()){
							deductionPercDetails.add(resultSetEARNEDBASIC4.getString("leaveid")+" ::"+resultSetEARNEDBASIC4.getDouble("deductionPerc")+" :: "+resultSetEARNEDBASIC4.getString("totalLeaves"));
						}
						/*Deduction Percentage Ends*/
						
						/*Deduction Percentage Effects*/
						/*String sqlEARNEDBASIC5 = "select levid leaveid,alwid from hr_payleaved where status=3 and alwid=0 and rdocno="+empCategoryID+" and levid="+i+"";*/
						String sqlEARNEDBASIC5 = "select d.levid leaveid,d.alwid from hr_paycode m left join hr_payleaved d on m.doc_no=d.rdocno where d.status=3 and d.alwid=0 and m.catid="+empCategoryID+" and d.levid="+i+"";
						ResultSet resultSetEARNEDBASIC5 = stmtEARNEDBASIC5.executeQuery(sqlEARNEDBASIC5);		
					
						while(resultSetEARNEDBASIC5.next()){
							deductionEffectDetails.add(resultSetEARNEDBASIC5.getString("leaveid")+" ::"+resultSetEARNEDBASIC5.getString("alwid"));
						}
						/*Deduction Percentage Effects Ends*/
						
						/*Leave Deduction Calculation*/

						if(deductionEffectDetails.size()>0) {
							
							for(int l=0;l<deductionEffectDetails.size();l++){
								
								Statement stmtHRConfigDays=conn.createStatement();
								Statement stmtEARNEDBASIC6=conn.createStatement();
								Statement stmtEARNEDBASIC7=conn.createStatement();
								Statement stmtEARNEDBASIC8=conn.createStatement();
								Statement stmtEARNEDBASIC9=conn.createStatement();
								Statement stmtEARNEDBASIC10=conn.createStatement();
								Statement stmtEARNEDBASIC11=conn.createStatement();
								
								String[] deductionEffectsDetails=deductionEffectDetails.get(l).split("::");
								
								if(deductionEffectsDetails[1].trim().equalsIgnoreCase("0")) {
									
									String[] deductionPercentageDetails=deductionPercDetails.get(0).split("::");	
									
								    String dailyRateFormula="",valueDAYS="0",valueYEARS="1",valueHRS="0",valueNH="0",valueBASIC="0",valueGROSS="0",valueOfConfig="0",valueRound="0";
								    double value1Round=100.00;
								    
									String sqlDailyRateFormula = "select dailyRate,if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1)))) whrs from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
									ResultSet resultSetDailyRateFormula = stmtEARNEDBASIC6.executeQuery(sqlDailyRateFormula);		
									
									while(resultSetDailyRateFormula.next()){
										dailyRateFormula=resultSetDailyRateFormula.getString("dailyRate");
										valueHRS=resultSetDailyRateFormula.getString("whrs");
									}
									
									valueBASIC = String.valueOf(basicSalary);
									valueGROSS = String.valueOf(basicSalary);
									
									/*Select Current Month Days*/
									if(dailyRateFormula.contains("[DAYS]")) {
										
										String sqlEARNEDBASIC9="select DAY(Last_DAY('"+sqlDate+"')) daysofmnth";
										ResultSet resultSetEARNEDBASIC9 = stmtEARNEDBASIC9.executeQuery(sqlEARNEDBASIC9);
										
										while(resultSetEARNEDBASIC9.next()){
											valueDAYS=resultSetEARNEDBASIC9.getString("daysofmnth");
										}
									}
									/*Select Current Month Days Ends*/
									
									/*Select Current Years*/
									if(dailyRateFormula.contains("[YEARS]")) {
										
										String sqlEARNEDBASIC10="select YEAR('"+sqlDate+"') mnthyear";
										ResultSet resultSetEARNEDBASIC10 = stmtEARNEDBASIC10.executeQuery(sqlEARNEDBASIC10);
										
										while(resultSetEARNEDBASIC10.next()){
											valueYEARS=resultSetEARNEDBASIC10.getString("mnthyear");
										}
									}
									/*Select Current Years Ends*/
									
								    /*Daily Rate Formula*/
									dailyRateFormula=dailyRateFormula.replaceAll("DAYS", valueDAYS);
									dailyRateFormula=dailyRateFormula.replaceAll("YEARS", valueYEARS);
									dailyRateFormula=dailyRateFormula.replaceAll("HRS", valueHRS);
									dailyRateFormula=dailyRateFormula.replaceAll("NH", valueNH);
									dailyRateFormula=dailyRateFormula.replaceAll("BASIC", valueBASIC);
									dailyRateFormula=dailyRateFormula.replaceAll("GROSS", valueGROSS);
									/*Daily Rate Formula Ends*/
									
									String sqlDailyRateFormula1="select REPLACE( REPLACE ('"+dailyRateFormula+"','[',''),']','') dailyRateValue";
									ResultSet resultSetDailyRateFormula1 = stmtEARNEDBASIC7.executeQuery(sqlDailyRateFormula1);		
									
									while(resultSetDailyRateFormula1.next()){
										dailyRateFormula=resultSetDailyRateFormula1.getString("dailyRateValue");
									}
									
									String configDays = "select method from gl_config where field_nme='HRMonthlyPayrollCalc'";
									ResultSet resultSetConfig = stmtHRConfigDays.executeQuery(configDays);
									
									while(resultSetConfig.next()){
										valueOfConfig=resultSetConfig.getString("method");
									}
									
									if(valueOfConfig.equalsIgnoreCase("1")){
										valueRound="2";
										value1Round=100.00;
									} else {
										valueRound="0";
									}
									
									String sqlDailyRateFormula2="select round("+dailyRateFormula+",2) DAYAMOUNT";
									ResultSet resultSetDailyRateFormula2 = stmtEARNEDBASIC8.executeQuery(sqlDailyRateFormula2);		
									
									while(resultSetDailyRateFormula2.next()){
										dailyRateFormula=resultSetDailyRateFormula2.getString("DAYAMOUNT");
									}	
									
									String sqlEARNEDBASIC11="select round("+valueDaysToPay+"*("+dailyRateFormula+"),"+valueRound+") BASIC";
							        ResultSet resultSetEARNEDBASIC11 = stmtEARNEDBASIC11.executeQuery(sqlEARNEDBASIC11);  
							         
							        while(resultSetEARNEDBASIC11.next()){
							          basicSalary=resultSetEARNEDBASIC11.getDouble("BASIC");
							        }
									
								    if(Double.parseDouble(EARNEDBASICAmount)==0 && loop==0){
								    		if(valueOfConfig.equalsIgnoreCase("1")){
								    			EARNEDBASICAmount=String.valueOf(Math.round((basicSalary-((Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100))))*value1Round)/value1Round);
								    		} else {
								    			EARNEDBASICAmount=String.valueOf(Math.round(basicSalary-((Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100)))));
								    		}
								    			loop=1;
								    } else {
								    		if(valueOfConfig.equalsIgnoreCase("1")){
								    			EARNEDBASICAmount=String.valueOf(Math.round((Double.parseDouble(EARNEDBASICAmount)-(Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100)))*value1Round)/value1Round);
								    		} else {
								    			EARNEDBASICAmount=String.valueOf(Math.round(Double.parseDouble(EARNEDBASICAmount)-(Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100))));
								    		}
								    }
							 }
							
							 stmtHRConfigDays.close();
							 stmtEARNEDBASIC6.close();
							 stmtEARNEDBASIC7.close();
							 stmtEARNEDBASIC8.close();
							 stmtEARNEDBASIC9.close();
							 stmtEARNEDBASIC10.close();
							 stmtEARNEDBASIC11.close();
						  }
						} else {
							if(i==1) {
								EARNEDBASICAmount=String.valueOf(basicSalary);
							}
					    }
					   /*Leave Deduction Calculation Ends*/
						
						stmtEARNEDBASIC4.close();
						stmtEARNEDBASIC5.close();
					} /*else {
						EARNEDBASICAmount=String.valueOf(basicSalary);
				    }*/
				} 
				
			stmtEARNEDBASIC.close();
			stmtEARNEDBASIC1.close();
			stmtEARNEDBASIC3.close();
			} catch(Exception e){
				conn.close();
				e.printStackTrace();
				return EARNEDBASICAmount;
			}
			return EARNEDBASICAmount;
		}
	
	public String getHREARNEDALLOWANCES(Connection conn,String empID,String empCategoryID,Date sqlDate,Double allowance,String valueDaysToPay,String allowanceID) throws SQLException {
	    	String EARNEDAllowanceAmount="0";
	    	
			try{
				Statement stmtEARNEDALC=conn.createStatement();
				Statement stmtEARNEDALC1=conn.createStatement();
				Statement stmtEARNEDALC3=conn.createStatement();
				
				ArrayList<String> leaveDetails = new ArrayList<String>();
				ArrayList<String> leavesTakenDetails = new ArrayList<String>();
				int totalleaveTypes=0;
				
				/*Leave Types*/
				String sqlEARNEDALC = "select doc_no leaveid,desc1 leavename from hr_setleave where status=3";
				ResultSet resultSetEARNEDALC = stmtEARNEDALC.executeQuery(sqlEARNEDALC);		
				
				while(resultSetEARNEDALC.next()){
					leaveDetails.add(resultSetEARNEDALC.getString("leaveid")+" ::"+resultSetEARNEDALC.getString("leavename"));
				}
				totalleaveTypes = leaveDetails.size();
				/*Leave Types Ends*/
				
				int loop=0;
				for(int i=1;i<=totalleaveTypes;i++){
					int carryForward=0,leaveDeduction=0;
					ArrayList<String> openingLeavesDetails = new ArrayList<String>();
					
					/*Checking Carry Forward*/
					String sqlEARNEDALC1 = "select cf,ded from hr_payleavem where rdocno="+empCategoryID+" and levid="+i+"";
					ResultSet resultSetEARNEDALC1 = stmtEARNEDALC1.executeQuery(sqlEARNEDALC1);		
				
					while(resultSetEARNEDALC1.next()){
						carryForward=resultSetEARNEDALC1.getInt("cf");
						leaveDeduction=resultSetEARNEDALC1.getInt("ded");
					}
					/*Checking Carry Forward Ends*/
					
					if(carryForward==1){
						Statement stmtEARNEDALC2=conn.createStatement();
						
						/*Opening leaves*/
						String sqlEARNEDALC2 = "select leaveid,sum(opnleaves) opnleaves from hr_setopeningleave where status=3 and Year(date)=YEAR('"+sqlDate+"') and leaveid="+i+" "  
								+ "and empid="+empID+" group by leaveid";
						ResultSet resultSetEARNEDALC2 = stmtEARNEDALC2.executeQuery(sqlEARNEDALC2);		
					
						while(resultSetEARNEDALC2.next()){
							openingLeavesDetails.add(resultSetEARNEDALC2.getString("leaveid")+" ::"+resultSetEARNEDALC2.getDouble("opnleaves"));
						}
						/*Opening leaves Ends*/
						
						stmtEARNEDALC2.close();
					}
					
					/*Leaves Taken*/
					String sqlEARNEDALC3 = "select '"+i+"' leaveid,if(mod(round(sum(t.tot_leave"+i+"),1),1)=0,round(sum(t.tot_leave"+i+"),0),round(sum(t.tot_leave"+i+"),1)) leavestaken from hr_timesheet t "
							+ "left join hr_empm m on t.empid=m.doc_no where m.active=1 and m.status=3 and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') "
							+ "and t.empid="+empID+" group by t.empid";
					ResultSet resultSetEARNEDALC3 = stmtEARNEDALC3.executeQuery(sqlEARNEDALC3);		
				
					while(resultSetEARNEDALC3.next()){
						leavesTakenDetails.add(resultSetEARNEDALC3.getString("leaveid")+" ::"+resultSetEARNEDALC3.getDouble("leavestaken"));
					}
					/*Leaves Taken Ends*/
					
					if(leaveDeduction==1){
						Statement stmtEARNEDALC4=conn.createStatement();
						Statement stmtEARNEDALC5=conn.createStatement();
						Double leavesOpn = 0.00,leavesTaken = 0.00;
						
						if(openingLeavesDetails.size()>0){
							String[] opnLeaves=openingLeavesDetails.get((i-1)).split("::");
							leavesOpn = ((opnLeaves[1].isEmpty()?0.0:Double.parseDouble(opnLeaves[1])));
						}
						
						if(leavesTakenDetails.size()>0){
							String[] takenLeaves=leavesTakenDetails.get((i-1)).split("::");
							leavesTaken = ((takenLeaves[1].isEmpty()?0.0:Double.parseDouble(takenLeaves[1])));
						}
						
						/*Deduction Percentage*/
						ArrayList<String> deductionPercDetails = new ArrayList<String>();
						ArrayList<String> deductionEffectDetails = new ArrayList<String>();
						
						String sqlEARNEDALC4 = "select levid leaveid,("+leavesOpn+"+"+leavesTaken+") totalLeaves,CASE WHEN (l3=0 and l2=0) then  l1ded WHEN  ("+leavesOpn+"+"+leavesTaken+")  between 0 and l1  then l1ded WHEN  ("+leavesOpn+"+"+leavesTaken+") between 0 and l2 then l2ded "
								+ "WHEN ("+leavesOpn+"+"+leavesTaken+") between 0 and l3  then if(l3=0,l2ded,l3ded) WHEN   11>=l3  then if(l3=0,l2ded,l3ded) END AS deductionPerc from hr_payleavem where rdocno="+empCategoryID+" and levid="+i+"";
						ResultSet resultSetEARNEDALC4 = stmtEARNEDALC4.executeQuery(sqlEARNEDALC4);		
					
						while(resultSetEARNEDALC4.next()){
							deductionPercDetails.add(resultSetEARNEDALC4.getString("leaveid")+" ::"+resultSetEARNEDALC4.getDouble("deductionPerc")+" :: "+resultSetEARNEDALC4.getString("totalLeaves"));
						}
						/*Deduction Percentage Ends*/
						
						/*Deduction Percentage Effects*/
						/*String sqlEARNEDALC5 = "select levid leaveid,alwid from hr_payleaved where status=3 and alwid="+allowanceID+" and rdocno="+empCategoryID+" and levid="+i+"";*/
						String sqlEARNEDALC5 = "select d.levid leaveid,d.alwid from hr_paycode m left join hr_payleaved d on m.doc_no=d.rdocno where d.status=3 and d.alwid="+allowanceID+" and m.catid="+empCategoryID+" and d.levid="+i+"";
						ResultSet resultSetEARNEDALC5 = stmtEARNEDALC5.executeQuery(sqlEARNEDALC5);		
					
						while(resultSetEARNEDALC5.next()){
							deductionEffectDetails.add(resultSetEARNEDALC5.getString("leaveid")+" ::"+resultSetEARNEDALC5.getString("alwid"));
						}
						/*Deduction Percentage Effects Ends*/
						
						/*Leave Deduction Calculation*/

						if(deductionEffectDetails.size()>0) {
							
							for(int l=0;l<deductionEffectDetails.size();l++){
								
								Statement stmtHRConfigDays=conn.createStatement();
								Statement stmtEARNEDALC6=conn.createStatement();
								Statement stmtEARNEDALC7=conn.createStatement();
								Statement stmtEARNEDALC8=conn.createStatement();
								Statement stmtEARNEDALC9=conn.createStatement();
								Statement stmtEARNEDALC10=conn.createStatement();
								Statement stmtEARNEDALC11=conn.createStatement();
								
								String[] deductionEffectsDetails=deductionEffectDetails.get(l).split("::");
								
								if(deductionEffectsDetails[1].trim().equalsIgnoreCase(allowanceID)) {
									
									String[] deductionPercentageDetails=deductionPercDetails.get(0).split("::");	
									
								    String dailyRateFormula="",valueDAYS="0",valueYEARS="1",valueHRS="0",valueNH="0",valueBASIC="0",valueGROSS="0",valueOfConfig="0",valueRound="0";
								    double value1Round=1.00;
								    
									String sqlDailyRateFormula = "select dailyRate,if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1)))) whrs from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
									ResultSet resultSetDailyRateFormula = stmtEARNEDALC6.executeQuery(sqlDailyRateFormula);		
									
									while(resultSetDailyRateFormula.next()){
										dailyRateFormula=resultSetDailyRateFormula.getString("dailyRate");
										valueHRS=resultSetDailyRateFormula.getString("whrs");
									}
									
									valueBASIC = String.valueOf(allowance);
									valueGROSS = String.valueOf(allowance);
									
									/*Select Current Month Days*/
									if(dailyRateFormula.contains("[DAYS]")) {
										
										String sqlEARNEDALC9="select DAY(Last_DAY('"+sqlDate+"')) daysofmnth";
										ResultSet resultSetEARNEDALC9 = stmtEARNEDALC9.executeQuery(sqlEARNEDALC9);
										
										while(resultSetEARNEDALC9.next()){
											valueDAYS=resultSetEARNEDALC9.getString("daysofmnth");
										}
									}
									/*Select Current Month Days Ends*/
									
									/*Select Current Years*/
									if(dailyRateFormula.contains("[YEARS]")) {
										
										String sqlEARNEDALC10="select YEAR('"+sqlDate+"') mnthyear";
										ResultSet resultSetEARNEDALC10 = stmtEARNEDALC10.executeQuery(sqlEARNEDALC10);
										
										while(resultSetEARNEDALC10.next()){
											valueYEARS=resultSetEARNEDALC10.getString("mnthyear");
										}
									}
									/*Select Current Years Ends*/
									
								    /*Daily Rate Formula*/
									dailyRateFormula=dailyRateFormula.replaceAll("DAYS", valueDAYS);
									dailyRateFormula=dailyRateFormula.replaceAll("YEARS", valueYEARS);
									dailyRateFormula=dailyRateFormula.replaceAll("HRS", valueHRS);
									dailyRateFormula=dailyRateFormula.replaceAll("NH", valueNH);
									dailyRateFormula=dailyRateFormula.replaceAll("BASIC", valueBASIC);
									dailyRateFormula=dailyRateFormula.replaceAll("GROSS", valueGROSS);
									/*Daily Rate Formula Ends*/
									
									String sqlDailyRateFormula1="select REPLACE( REPLACE ('"+dailyRateFormula+"','[',''),']','') dailyRateValue";
									ResultSet resultSetDailyRateFormula1 = stmtEARNEDALC7.executeQuery(sqlDailyRateFormula1);		
									
									while(resultSetDailyRateFormula1.next()){
										dailyRateFormula=resultSetDailyRateFormula1.getString("dailyRateValue");
									}
									
									String configDays = "select method from gl_config where field_nme='HRMonthlyPayrollCalc'";
									ResultSet resultSetConfig = stmtHRConfigDays.executeQuery(configDays);
									
									while(resultSetConfig.next()){
										valueOfConfig=resultSetConfig.getString("method");
									}
									
									if(valueOfConfig.equalsIgnoreCase("1")){
										valueRound="2";
										value1Round=100.00;
									} else {
										valueRound="0";
									}
									
									String sqlDailyRateFormula2="select round("+dailyRateFormula+",2) DAYAMOUNT";
									ResultSet resultSetDailyRateFormula2 = stmtEARNEDALC8.executeQuery(sqlDailyRateFormula2);		
									
									while(resultSetDailyRateFormula2.next()){
										dailyRateFormula=resultSetDailyRateFormula2.getString("DAYAMOUNT");
									}								
									
									String sqlEARNEDALC11="select round("+valueDaysToPay+"*("+dailyRateFormula+"),"+valueRound+") ALLOWANCE";
							        ResultSet resultSetALC11 = stmtEARNEDALC11.executeQuery(sqlEARNEDALC11);  
							         
							        while(resultSetALC11.next()){
							          allowance=resultSetALC11.getDouble("ALLOWANCE");
							        }
							        
								    if(Double.parseDouble(EARNEDAllowanceAmount)==0 && loop==0){
								    		if(valueOfConfig.equalsIgnoreCase("1")){
								    			EARNEDAllowanceAmount=String.valueOf(Math.round((allowance-((Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100))))*value1Round)/value1Round);
								    		} else {
								    			EARNEDAllowanceAmount=String.valueOf(Math.round(allowance-((Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100)))));
								    		}
								    		loop=1;
								    } else {
								    		if(valueOfConfig.equalsIgnoreCase("1")){
								    			EARNEDAllowanceAmount=String.valueOf(Math.round((Double.parseDouble(EARNEDAllowanceAmount)-(Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100)))*value1Round)/value1Round);
								    		} else {
								    			EARNEDAllowanceAmount=String.valueOf(Math.round((Double.parseDouble(EARNEDAllowanceAmount)-(Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100)))));
								    		}
								    }
							 }
								
							 stmtHRConfigDays.close();
							 stmtEARNEDALC6.close();
							 stmtEARNEDALC7.close();
							 stmtEARNEDALC8.close();
							 stmtEARNEDALC9.close();
							 stmtEARNEDALC10.close();
							 stmtEARNEDALC11.close();
						  }
						} else {
							if(i==1){
								EARNEDAllowanceAmount=String.valueOf(allowance);
							}
					    }
					   /*Leave Deduction Calculation Ends*/
						
						stmtEARNEDALC4.close();
						stmtEARNEDALC5.close();
					} /*else {
						   EARNEDAllowanceAmount=String.valueOf(allowance);
					}*/
					
				} 
				
			stmtEARNEDALC.close();
			stmtEARNEDALC1.close();
			stmtEARNEDALC3.close();
			} catch(Exception e){
				conn.close();
				e.printStackTrace();
				return EARNEDAllowanceAmount;
			}
			return EARNEDAllowanceAmount;
		}
	
	public String getHROT(Connection conn,String empID,String empCategoryID,Date sqlDate) throws SQLException {
    	String OTAmount="0";
    	
		try{
			Statement stmtHROT=conn.createStatement();
			Statement stmtHROT1=conn.createStatement();
			Statement stmtHROT2=conn.createStatement();
			
			ArrayList<String> empDetails = new ArrayList<String>();
			String nRateFormula="",otFormula="",valueDAYS="0",valueYEARS="1",valueHRS="0",valueNH="0",valueBASIC="0",valueGROSS="0",valueOTWorked="0";
			
			String sqlOT = "select nRate,OTRate,if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1)))) whrs from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
			ResultSet resultSetOT = stmtHROT.executeQuery(sqlOT);		
			
			while(resultSetOT.next()){
				nRateFormula=resultSetOT.getString("nRate");
				otFormula=resultSetOT.getString("OTRate");
				valueHRS=resultSetOT.getString("whrs");
			}
			
			empDetails=getEmployeePayrollDetails(conn,empID,empCategoryID,sqlDate); 
			String[] employeeDetails=empDetails.get(0).split("::");
			valueOTWorked = ((employeeDetails[0].isEmpty()?"0":employeeDetails[0]));
			valueBASIC = ((employeeDetails[3].isEmpty()?"0":employeeDetails[3]));
			valueGROSS = ((employeeDetails[4].isEmpty()?"0":employeeDetails[4]));
			
			if(otFormula.contains("NH")){
				otFormula=otFormula.replaceAll("NH", "(NH)");
				otFormula=otFormula.replaceAll("NH", nRateFormula);
			}
			
			/*Select Current Month Days*/
			if(nRateFormula.contains("[DAYS]")) {
				
				String sqlOT1="select DAY(Last_DAY('"+sqlDate+"')) daysofmnth";
				ResultSet resultSetOT1 = stmtHROT1.executeQuery(sqlOT1);
				
				while(resultSetOT1.next()){
					valueDAYS=resultSetOT1.getString("daysofmnth");
				}
			}
			/*Select Current Month Days Ends*/
			
			/*Select Current Years*/
			if(nRateFormula.contains("[YEARS]")) {
				
				String sqlOT2="select YEAR('"+sqlDate+"') mnthyear";
				ResultSet resultSetOT2 = stmtHROT2.executeQuery(sqlOT2);
				
				while(resultSetOT2.next()){
					valueYEARS=resultSetOT2.getString("mnthyear");
				}
			}
			/*Select Current Years Ends*/
			
			/*Normal Rate Per Hour Formula*/
			nRateFormula=nRateFormula.replaceAll("DAYS", valueDAYS);
			nRateFormula=nRateFormula.replaceAll("YEARS", valueYEARS);
			nRateFormula=nRateFormula.replaceAll("HRS", valueHRS);
			nRateFormula=nRateFormula.replaceAll("NH", valueNH);
			nRateFormula=nRateFormula.replaceAll("BASIC", valueBASIC);
			nRateFormula=nRateFormula.replaceAll("GROSS", valueGROSS);
			/*Normal Rate Per Hour Formula Ends*/
			
			/*Over Time Formula*/
			otFormula=otFormula.replaceAll("DAYS", valueDAYS);
			otFormula=otFormula.replaceAll("YEARS", valueYEARS);
			otFormula=otFormula.replaceAll("HRS", valueHRS);
			otFormula=otFormula.replaceAll("NH", valueNH);
			otFormula=otFormula.replaceAll("BASIC", valueBASIC);
			otFormula=otFormula.replaceAll("GROSS", valueGROSS);
			/*Over Time Formula Ends*/
			
			String sqlOT1="select REPLACE( REPLACE ('"+otFormula+"','[',''),']','') OTValue,REPLACE( REPLACE ('"+nRateFormula+"','[',''),']','') nRateValue";
			ResultSet resultSetOT1 = stmtHROT1.executeQuery(sqlOT1);		
			
			while(resultSetOT1.next()){
				nRateFormula=resultSetOT1.getString("nRateValue");
				otFormula=resultSetOT1.getString("OTValue");
			}
			
			String sqlOT2="select round("+valueOTWorked+"*("+otFormula+"),0) OT";
			ResultSet resultSetOT2 = stmtHROT2.executeQuery(sqlOT2);		
			
			while(resultSetOT2.next()){
				OTAmount=resultSetOT2.getString("OT");
			}
			
		stmtHROT.close();
		stmtHROT1.close();
		stmtHROT2.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return OTAmount;
		}
		return OTAmount;
	}
	
	public String getHRHOT(Connection conn,String empID,String empCategoryID,Date sqlDate) throws SQLException {
    	String HOTAmount="0";
    	
		try{
			Statement stmtHRHOT=conn.createStatement();
			Statement stmtHRHOT1=conn.createStatement();
			Statement stmtHRHOT2=conn.createStatement();
			
			ArrayList<String> empDetails = new ArrayList<String>();
			String nRateFormula="",hotFormula="",valueDAYS="0",valueYEARS="1",valueHRS="0",valueNH="0",valueBASIC="0",valueGROSS="0",valueHOTWorked="0";
			
			String sqlHOT = "select nRate,HOTRate,if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1)))) whrs from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
			ResultSet resultSetHOT = stmtHRHOT.executeQuery(sqlHOT);		
			
			while(resultSetHOT.next()){
				nRateFormula=resultSetHOT.getString("nRate");
				hotFormula=resultSetHOT.getString("HOTRate");
				valueHRS=resultSetHOT.getString("whrs");
			}
			
			empDetails=getEmployeePayrollDetails(conn,empID,empCategoryID,sqlDate); 
			String[] employeeDetails=empDetails.get(0).split("::");
			valueHOTWorked = ((employeeDetails[1].isEmpty()?"0":employeeDetails[1]));
			valueBASIC = ((employeeDetails[3].isEmpty()?"0":employeeDetails[3]));
			valueGROSS = ((employeeDetails[4].isEmpty()?"0":employeeDetails[4]));
			
			if(hotFormula.contains("NH")){
				hotFormula=hotFormula.replaceAll("NH", "(NH)");
				hotFormula=hotFormula.replaceAll("NH", nRateFormula);
			}
			
			/*Select Current Month Days*/
			if(nRateFormula.contains("[DAYS]")) {
				
				String sqlHOT1="select DAY(Last_DAY('"+sqlDate+"')) daysofmnth";
				ResultSet resultSetHOT1 = stmtHRHOT1.executeQuery(sqlHOT1);
				
				while(resultSetHOT1.next()){
					valueDAYS=resultSetHOT1.getString("daysofmnth");
				}
			}
			/*Select Current Month Days Ends*/
			
			/*Select Current Years*/
			if(nRateFormula.contains("[YEARS]")) {
				
				String sqlHOT2="select YEAR('"+sqlDate+"') mnthyear";
				ResultSet resultSetHOT2 = stmtHRHOT2.executeQuery(sqlHOT2);
				
				while(resultSetHOT2.next()){
					valueYEARS=resultSetHOT2.getString("mnthyear");
				}
			}
			/*Select Current Years Ends*/
			
			/*Normal Rate Per Hour Formula*/
			nRateFormula=nRateFormula.replaceAll("DAYS", valueDAYS);
			nRateFormula=nRateFormula.replaceAll("YEARS", valueYEARS);
			nRateFormula=nRateFormula.replaceAll("HRS", valueHRS);
			nRateFormula=nRateFormula.replaceAll("NH", valueNH);
			nRateFormula=nRateFormula.replaceAll("BASIC", valueBASIC);
			nRateFormula=nRateFormula.replaceAll("GROSS", valueGROSS);
			/*Normal Rate Per Hour Formula Ends*/
			
			/*Holiday Over Time Formula*/
			hotFormula=hotFormula.replaceAll("DAYS", valueDAYS);
			hotFormula=hotFormula.replaceAll("YEARS", valueYEARS);
			hotFormula=hotFormula.replaceAll("HRS", valueHRS);
			hotFormula=hotFormula.replaceAll("NH", valueNH);
			hotFormula=hotFormula.replaceAll("BASIC", valueBASIC);
			hotFormula=hotFormula.replaceAll("GROSS", valueGROSS);
			/*Holiday Over Time Formula Ends*/
			
			String sqlHOT1="select REPLACE( REPLACE ('"+hotFormula+"','[',''),']','') HOTValue,REPLACE( REPLACE ('"+nRateFormula+"','[',''),']','') nRateValue";
			ResultSet resultSetHOT1 = stmtHRHOT1.executeQuery(sqlHOT1);		
			
			while(resultSetHOT1.next()){
				nRateFormula=resultSetHOT1.getString("nRateValue");
				hotFormula=resultSetHOT1.getString("HOTValue");
			}
			
			String sqlHOT2="select round("+valueHOTWorked+"*("+hotFormula+"),0) HOT";
			ResultSet resultSetHOT2 = stmtHRHOT2.executeQuery(sqlHOT2);		
			
			while(resultSetHOT2.next()){
				HOTAmount=resultSetHOT2.getString("HOT");
			}
			
		stmtHRHOT.close();
		stmtHRHOT1.close();
		stmtHRHOT2.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return HOTAmount;
		}
		return HOTAmount;
	}
	
	public String getHRLeaveDeductions(Connection conn,String empID,String empCategoryID,Date sqlDate) throws SQLException {
    	String LDAmount="0";
    	
		try{
			Statement stmtHRLD=conn.createStatement();
			Statement stmtHRLD1=conn.createStatement();
			Statement stmtHRLD3=conn.createStatement();
			
			ArrayList<String> leaveDetails = new ArrayList<String>();
			ArrayList<String> openingLeavesDetails = new ArrayList<String>();
			ArrayList<String> leavesTakenDetails = new ArrayList<String>();
			ArrayList<String> empDetails = new ArrayList<String>();					
			int totalleaveTypes=0,empAllowanceIdsLength=0;
			
			/*Leave Types*/
			String sqlLD = "select doc_no leaveid,desc1 leavename from hr_setleave where status=3";
			ResultSet resultSetLD = stmtHRLD.executeQuery(sqlLD);		
			
			while(resultSetLD.next()){
				leaveDetails.add(resultSetLD.getString("leaveid")+" ::"+resultSetLD.getString("leavename"));
			}
			totalleaveTypes = leaveDetails.size();
			/*Leave Types Ends*/
			
			int loop=0;
			for(int i=1;i<=totalleaveTypes;i++){
				int carryForward=0,leaveDeduction=0;
				
				/*Checking Carry Forward*/
				String sqlLD1 = "select cf,ded from hr_payleavem where rdocno="+empCategoryID+" and levid="+i+"";
				ResultSet resultSetLD1 = stmtHRLD1.executeQuery(sqlLD1);		
			
				while(resultSetLD1.next()){
					carryForward=resultSetLD1.getInt("cf");
					leaveDeduction=resultSetLD1.getInt("ded");
				}
				/*Checking Carry Forward Ends*/
				
				if(carryForward==1){
					Statement stmtHRLD2=conn.createStatement();
					
					/*Opening leaves*/
					String sqlLD2 = "select leaveid,sum(opnleaves) opnleaves from hr_setopeningleave where status=3 and Year(date)=YEAR('"+sqlDate+"') and leaveid="+i+" "  
							+ "and empid="+empID+" group by leaveid";
					ResultSet resultSetLD2 = stmtHRLD2.executeQuery(sqlLD2);		
				
					while(resultSetLD2.next()){
						openingLeavesDetails.add(resultSetLD2.getString("leaveid")+" ::"+resultSetLD2.getDouble("opnleaves"));
					}
					/*Opening leaves Ends*/
					
					stmtHRLD2.close();
				}
				
				/*Leaves Taken*/
				String sqlLD3 = "select '"+i+"' leaveid,if(mod(round(sum(t.tot_leave"+i+"),1),1)=0,round(sum(t.tot_leave"+i+"),0),round(sum(t.tot_leave"+i+"),1)) leavestaken from hr_timesheet t "
						+ "left join hr_empm m on t.empid=m.doc_no where m.active=1 and m.status=3 and t.year=YEAR('"+sqlDate+"') and t.month=MONTH('"+sqlDate+"') "
						+ "and t.empid="+empID+" group by t.empid";
				ResultSet resultSetLD3 = stmtHRLD3.executeQuery(sqlLD3);		
			
				while(resultSetLD3.next()){
					leavesTakenDetails.add(resultSetLD3.getString("leaveid")+" ::"+resultSetLD3.getDouble("leavestaken"));
				}
				/*Leaves Taken Ends*/
				
				if(leaveDeduction==1){
					
					Statement stmtHRLD4=conn.createStatement();
					Statement stmtHRLD5=conn.createStatement();
					Double leavesOpn = 0.00,leavesTaken = 0.00;
					
					if(openingLeavesDetails.size()>0){
						String[] opnLeaves=openingLeavesDetails.get((i-1)).split("::");
						leavesOpn = ((opnLeaves[1].isEmpty()?0.0:Double.parseDouble(opnLeaves[1])));
					}
					
					if(leavesTakenDetails.size()>0){
						String[] takenLeaves=leavesTakenDetails.get((i-1)).split("::");
						leavesTaken = ((takenLeaves[1].isEmpty()?0.0:Double.parseDouble(takenLeaves[1])));
					}
					
					/*Deduction Percentage*/
					ArrayList<String> deductionPercDetails = new ArrayList<String>();
					ArrayList<String> deductionEffectDetails = new ArrayList<String>();
					
					String sqlLD4 = "select levid leaveid,("+leavesOpn+"+"+leavesTaken+") totalLeaves,CASE WHEN (l3=0 and l2=0) then  l1ded WHEN  ("+leavesOpn+"+"+leavesTaken+")  between 0 and l1  then l1ded WHEN  ("+leavesOpn+"+"+leavesTaken+") between 0 and l2 then l2ded "
							+ "WHEN ("+leavesOpn+"+"+leavesTaken+") between 0 and l3  then if(l3=0,l2ded,l3ded) WHEN   11>=l3  then if(l3=0,l2ded,l3ded) END AS deductionPerc from hr_payleavem where rdocno="+empCategoryID+" and levid="+i+"";
					ResultSet resultSetLD4 = stmtHRLD4.executeQuery(sqlLD4);		
				
					while(resultSetLD4.next()){
						deductionPercDetails.add(resultSetLD4.getString("leaveid")+" ::"+resultSetLD4.getDouble("deductionPerc")+" :: "+resultSetLD4.getString("totalLeaves"));
					}
					/*Deduction Percentage Ends*/
					
					/*Deduction Percentage Effects*/
					String sqlLD5 = "select levid leaveid,alwid from hr_payleaved where status=3 and rdocno="+empCategoryID+" and levid="+i+"";
					ResultSet resultSetLD5 = stmtHRLD5.executeQuery(sqlLD5);		
				
					while(resultSetLD5.next()){
						deductionEffectDetails.add(resultSetLD5.getString("leaveid")+" ::"+resultSetLD5.getString("alwid"));
					}
					/*Deduction Percentage Effects Ends*/
					
					/*Leave Deduction Calculation*/
					empDetails=getEmployeePayrollDetails(conn,empID,empCategoryID,sqlDate);
					String[] empAllowanceDetails=empDetails.get(0).split("::");
					String empAllowanceIds=empAllowanceDetails[5];
					String empAllowanceIds1=empAllowanceDetails[5];
					empAllowanceIds=empAllowanceIds.replace("[", "").replace("]", "").trim();
					empAllowanceIds1=empAllowanceIds1.replace("[", "").replace("]", "").replace(",", "").trim();
					String empAllowanceIds2 = empAllowanceIds1.replaceAll(" ", "");
					empAllowanceIds1=empAllowanceIds1.trim();
					empAllowanceIdsLength=empAllowanceIds2.length();
					String[] allowanceIds=empAllowanceIds.split(",");
					
					String[] empAllowanceAmountsDetails=empDetails.get(0).split("::");
					String empAllowanceAmounts=empAllowanceAmountsDetails[6];
					empAllowanceAmounts=empAllowanceAmounts.replace("[", "").replace("]", "").trim();
					String[] allowanceAmounts=empAllowanceAmounts.split(",");
					
					for(int m=0;m<empAllowanceIdsLength;m++){

						for(int l=0;l<deductionEffectDetails.size();l++){
							
							Statement stmtHRLD6=conn.createStatement();
							Statement stmtHRLD7=conn.createStatement();
							Statement stmtHRLD8=conn.createStatement();
							Statement stmtHRConfigDays=conn.createStatement();
							
							String[] deductionEffectsDetails=deductionEffectDetails.get(l).split("::");
							
							if(deductionEffectsDetails[1].trim().equalsIgnoreCase(allowanceIds[m].trim())) {
								
								String[] deductionPercentageDetails=deductionPercDetails.get(0).split("::");	
								
							    String dailyRateFormula="",valueDAYS="0",valueYEARS="1",valueHRS="0",valueNH="0",valueBASIC="0",valueGROSS="0",valueOfConfig="0";
							    
								String sqlDailyRateFormula = "select dailyRate,if(((((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(whrs,':',1))*60)+(SUBSTRING_INDEX(whrs,':',-1)))) whrs,aelg,awdays from hr_paycode where catid="+empCategoryID+" and doc_no=(select max(doc_no) from hr_paycode where catid="+empCategoryID+" and revdate<='"+sqlDate+"')";
								ResultSet resultSetDailyRateFormula = stmtHRLD6.executeQuery(sqlDailyRateFormula);		
								
								while(resultSetDailyRateFormula.next()){
									dailyRateFormula=resultSetDailyRateFormula.getString("dailyRate");
									valueHRS=resultSetDailyRateFormula.getString("whrs");
									valueDAYS=resultSetDailyRateFormula.getString("aelg");
									valueYEARS=resultSetDailyRateFormula.getString("awdays");
								}
								
								/*String configDays = "select method,value,DAY(Last_DAY('"+sqlDate+"')) daysofmnth from gl_config where field_nme='HRMonthlyPayrollCalc'";
								ResultSet resultSetconfigDays = stmtHRConfigDays.executeQuery(configDays);
								
								while(resultSetconfigDays.next()){
									valueOfConfig=resultSetconfigDays.getString("value");
									valueDAYS=resultSetconfigDays.getString("daysofmnth");
									valueDAYS=resultSetconfigDays.getString("method").trim().equalsIgnoreCase("1")?valueDAYS:valueOfConfig;
								}*/
								
							    valueBASIC = allowanceAmounts[m];
								valueGROSS = allowanceAmounts[m];
								
							    /*Daily Rate Formula*/
								dailyRateFormula=dailyRateFormula.replaceAll("DAYS", valueDAYS);
								dailyRateFormula=dailyRateFormula.replaceAll("YEARS", valueYEARS);
								dailyRateFormula=dailyRateFormula.replaceAll("HRS", valueHRS);
								dailyRateFormula=dailyRateFormula.replaceAll("NH", valueNH);
								dailyRateFormula=dailyRateFormula.replaceAll("BASIC", valueBASIC);
								dailyRateFormula=dailyRateFormula.replaceAll("GROSS", valueGROSS);
								/*Daily Rate Formula Ends*/
								
								String sqlDailyRateFormula1="select REPLACE( REPLACE ('"+dailyRateFormula+"','[',''),']','') dailyRateValue";
								ResultSet resultSetDailyRateFormula1 = stmtHRLD7.executeQuery(sqlDailyRateFormula1);		
								
								while(resultSetDailyRateFormula1.next()){
									dailyRateFormula=resultSetDailyRateFormula1.getString("dailyRateValue");
								}
								
								String sqlDailyRateFormula2="select round("+dailyRateFormula+",0) DAYAMOUNT";
								ResultSet resultSetDailyRateFormula2 = stmtHRLD8.executeQuery(sqlDailyRateFormula2);		
								
								while(resultSetDailyRateFormula2.next()){
									dailyRateFormula=resultSetDailyRateFormula2.getString("DAYAMOUNT");
								}								
								
							    if(Double.parseDouble(LDAmount)==0 && loop==0){
										LDAmount=String.valueOf((Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100)));
										loop=1;
							    } else {
							    		LDAmount=String.valueOf((Double.parseDouble(LDAmount)+(Double.parseDouble(deductionPercentageDetails[2])*Double.parseDouble(dailyRateFormula)*(Double.parseDouble(deductionPercentageDetails[1])/100))));
							    }
							    
						 }
							
  						 stmtHRLD6.close();
						 stmtHRLD7.close();
						 stmtHRLD8.close();
						 stmtHRConfigDays.close();
					  }
						
				   }
				   /*Leave Deduction Calculation Ends*/
					
					stmtHRLD4.close();
					stmtHRLD5.close();
					
				}
			}
			
		stmtHRLD.close();
		stmtHRLD1.close();
		stmtHRLD3.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return LDAmount;
		}
		return LDAmount;
	}
	
	public String getHRLoanAmount(Connection conn,String empID,Date sqlDate) throws SQLException {
    	String LoanAmount="0";
    	
		try{
			Statement stmtHRLA=conn.createStatement();
			
			String sqlLA = "select round(coalesce(sum(d.amount),0),0) loan from hr_addschm m left join hr_addschd d on m.doc_no=d.rdocno where m.status=3 and d.posted=0 "  
					+ "and d.date>=(DATE_ADD(DATE_ADD(LAST_DAY('"+sqlDate+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH)) and d.date<=(LAST_DAY('"+sqlDate+"')) and m.empid="+empID+"";
			ResultSet resultSetLA = stmtHRLA.executeQuery(sqlLA);		
			
			while(resultSetLA.next()){
				LoanAmount=resultSetLA.getString("loan");
			}
			
		stmtHRLA.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return LoanAmount;
		}
		return LoanAmount;
	}
	
	public ArrayList<String> getHRAdditionsDeductions(Connection conn,String empID,Date sqlDate) throws Exception {
    	ArrayList<String> AdditionsDeductionsAmount = new ArrayList<String>();
    	
		try{
			Statement stmtHRAD=conn.createStatement();
			
			String sqlAD = "select round(coalesce(sum(addition),0),0) addition,round(coalesce(sum(deduction),0),0) deduction from hr_adddedm m left join hr_adddedd d "
					+ "on m.doc_no=d.rdocno where m.status=3 and d.posted=0 and m.month=MONTH('"+sqlDate+"') and m.year=YEAR('"+sqlDate+"')  and d.empid="+empID+"";
			ResultSet resultSetAD = stmtHRAD.executeQuery(sqlAD);		
			
			while(resultSetAD.next()){
				AdditionsDeductionsAmount.add(resultSetAD.getString("addition")+" ::"+resultSetAD.getString("deduction"));
			}
			
		stmtHRAD.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return AdditionsDeductionsAmount;
		}
		return AdditionsDeductionsAmount;
	}
	
	public ArrayList<String> getEmployeePayrollDetails(Connection conn,String empID,String empCategoryID,Date sqlDate) throws Exception {
		ArrayList<String> employeeDetails = new ArrayList<String>();
    	
		try{
			
			Statement stmtHREPD=conn.createStatement();
			Statement stmtHREPD1=conn.createStatement();
			Statement stmtHREPD2=conn.createStatement();
			Statement stmtHREPD3=conn.createStatement();
			
			java.sql.Date sqlsalaryPaidDate=null;
			String otWorked="0",hotWorked="0";
			double basicSalary=0.00,allowanceCalc=0.00,grossSalary=0.00;
			int totalAllowance=0;
			ArrayList<String> allowanceAmount = new ArrayList<String>();
			ArrayList<String> allowanceId = new ArrayList<String>();
			
			String sqlEPD = "select tot_ot,tot_hot from hr_timesheet where year=YEAR('"+sqlDate+"') and month=MONTH('"+sqlDate+"') and empid="+empID+"";
			ResultSet resultSetEPD = stmtHREPD.executeQuery(sqlEPD);		
			
			while(resultSetEPD.next()){
				otWorked=resultSetEPD.getString("tot_ot");
				hotWorked=resultSetEPD.getString("tot_hot");
			}
			
			String sqlEPD1 = "select salary_paid,DATEDIFF('"+sqlDate+"',salary_paid) diff from hr_empm where active=1 and status=3 and doc_no="+empID+"";
			ResultSet resultSetEPD1 = stmtHREPD1.executeQuery(sqlEPD1);		
			
			while(resultSetEPD1.next()){
				sqlsalaryPaidDate=resultSetEPD1.getDate("salary_paid");
			}
						
			String sqlEPD2="select * from ( "  
					+ "select t.empid,id.awlid,id.refdtype,id.revadd,id.revded,id.revstatded from hr_timesheet t left join hr_incrm im on t.empid=im.empid "
					+ "left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' "
					+ "and t.empid="+empID+" union all "
					+ "select 0 empid,hrs.doc_no awlid,'ALC' refdtype,0 revadd,0 revded,0 revstatded from hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in "
					+ "(select id.awlid from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where "
					+ "im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+empID+")) as a where a.awlid>=0 "
					+ "group by empid,awlid,refdtype order by refdtype,awlid";

			ResultSet resultSetEPD2 = stmtHREPD2.executeQuery(sqlEPD2);		
			
			
			while(resultSetEPD2.next()){
				double allowance=0.00;
				
				if(resultSetEPD2.getString("awlid").equalsIgnoreCase("0") && resultSetEPD2.getString("refdtype").equalsIgnoreCase("0")){
					basicSalary=basicSalary+resultSetEPD2.getDouble("revadd");
					basicSalary=basicSalary-resultSetEPD2.getDouble("revded");
					grossSalary=grossSalary+basicSalary;
					allowanceId.add(resultSetEPD2.getString("awlid"));
					allowanceAmount.add(String.valueOf(basicSalary));
				}
				
				if(resultSetEPD2.getString("refdtype").equalsIgnoreCase("ALC")){
					allowanceCalc=allowanceCalc+resultSetEPD2.getDouble("revadd");
					allowanceCalc=allowanceCalc-resultSetEPD2.getDouble("revded");
					grossSalary=grossSalary+allowanceCalc;
					
					String sqlEPD3="select count(doc_no) totalc from hr_setallowance where status=3 and doc_no>=0";
					ResultSet resultSetEPD3 = stmtHREPD3.executeQuery(sqlEPD3);		
					
					while(resultSetEPD3.next()){
						totalAllowance=resultSetEPD3.getInt("totalc");
					}
					
					for(int j=1;j<=totalAllowance;j++){
						int alwid=resultSetEPD2.getInt("awlid");

						if(alwid==j){
							allowance=allowance+resultSetEPD2.getDouble("revadd");
							allowance=allowance-resultSetEPD2.getDouble("revded");
							
							allowanceId.add(String.valueOf(alwid));
							allowanceAmount.add(String.valueOf(allowance));	
						}
					}
					
				}
			}
			
			employeeDetails.add(otWorked+" ::"+hotWorked+" ::"+sqlsalaryPaidDate+" ::"+basicSalary+" ::"+grossSalary+" ::"+allowanceId+" ::"+allowanceAmount);
			
			stmtHREPD.close();
			stmtHREPD1.close();
			stmtHREPD2.close();
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return employeeDetails;
		}
		return employeeDetails;
	}
	
	public String getHRTerminationBenefitSalary(Connection conn,String empID,String empCategoryID) throws SQLException {
    	String TerminationBenefitSalaryAmount="0";
    	
		try{
			Statement stmtHRTerminationBenefitSalary=conn.createStatement();
			Statement stmtHRTerminationBenefitSalary1=conn.createStatement();
			String allowanceID="";
			
			String sqlTerminationBenefitSalary = "select alwid from hr_payeos where rdocno=(select MAX(doc_no) docno from hr_paycode where catid="+empCategoryID+")";
			ResultSet resultSetTerminationBenefitSalary = stmtHRTerminationBenefitSalary.executeQuery(sqlTerminationBenefitSalary);
			
			int k=0;
			while(resultSetTerminationBenefitSalary.next()) {
				if(k==0) {
					allowanceID+=resultSetTerminationBenefitSalary.getString("alwid");
					k=1;
				}else {
					allowanceID+=","+resultSetTerminationBenefitSalary.getString("alwid");
				}
			}
			
			if(!(allowanceID.equalsIgnoreCase(""))) {
				
				String sqlTerminationBenefitSalary1 = "select round(sum(amount),0) amount from ( select * from ( select t.empid,id.rdocno,id.awlid,(id.revadd-id.revded) amount from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where "  
					   + "im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+empID+" union all select 0 empid,0 rdocno,hrs.doc_no awlid,0 amount from hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid "
					   + "from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+empID+")) as a where a.awlid in ("+allowanceID+") "
					   + "group by empid,awlid order by awlid) as b";
				ResultSet resultSetTerminationBenefitSalary1 = stmtHRTerminationBenefitSalary1.executeQuery(sqlTerminationBenefitSalary1);		
				
				while(resultSetTerminationBenefitSalary1.next()){
					TerminationBenefitSalaryAmount=resultSetTerminationBenefitSalary1.getString("amount");
				}
				
				stmtHRTerminationBenefitSalary1.close();	
			}
			
			stmtHRTerminationBenefitSalary.close();
		
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return TerminationBenefitSalaryAmount;
		}
		return TerminationBenefitSalaryAmount;
	}
	
	public String getHRTerminationBenefitDepreciation(Connection conn,String empID,String empCategoryID) throws SQLException {
    	String TerminationBenefitDepreciationAmount="0";
    	
		try{
			Statement stmtHRTerminationBenefitDepreciation=conn.createStatement();
			Statement stmtHRTerminationBenefitDepreciation1=conn.createStatement();
			String allowanceID="";
			
			String sqlTerminationBenefitSalary = "select alwid from hr_payeos where rdocno=(select MAX(doc_no) docno from hr_paycode where catid="+empCategoryID+")";
			ResultSet resultSetTerminationBenefitSalary = stmtHRTerminationBenefitDepreciation.executeQuery(sqlTerminationBenefitSalary);
			
			int k=0;
			while(resultSetTerminationBenefitSalary.next()) {
				if(k==0) {
					allowanceID+=resultSetTerminationBenefitSalary.getString("alwid");
					k=1;
				}else {
					allowanceID+=","+resultSetTerminationBenefitSalary.getString("alwid");
				}
			}
			
			if(!(allowanceID.equalsIgnoreCase(""))) {
				
				String sqlTerminationBenefitSalary1 = "select round(sum(amount),0) amount from ( select * from ( select t.empid,id.rdocno,id.awlid,(id.revadd-id.revded) amount from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where "  
					   + "im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+empID+" union all select 0 empid,0 rdocno,hrs.doc_no awlid,0 amount from hr_setallowance hrs where hrs.status=3 and hrs.doc_no not in (select id.awlid "
					   + "from hr_timesheet t left join hr_incrm im on t.empid=im.empid left join hr_incrd id on im.doc_no=id.rdocno where im.doc_no=(select max(doc_no) from hr_incrm where t.empid=empid) and id.refdtype!='STD' and t.empid="+empID+")) as a where a.awlid in ("+allowanceID+") "
					   + "group by empid,awlid order by awlid) as b";
				ResultSet resultSetTerminationBenefitSalary1 = stmtHRTerminationBenefitDepreciation1.executeQuery(sqlTerminationBenefitSalary1);		
				
				while(resultSetTerminationBenefitSalary1.next()){
					TerminationBenefitDepreciationAmount=resultSetTerminationBenefitSalary1.getString("amount");
				}
				
				stmtHRTerminationBenefitDepreciation1.close();	
			}
			
			stmtHRTerminationBenefitDepreciation.close();
		
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return TerminationBenefitDepreciationAmount;
		}
		return TerminationBenefitDepreciationAmount;
	}
	
	public String getHRTerminationBenefitToBePostedDays(Connection conn,String empCategoryID,Double yearsWorked) throws SQLException {
    	String TerminationBenefitToBePostedDays="0";
    	
		try{
			Statement stmtHRTerminationBenefitToBePostedDays=conn.createStatement();
			Statement stmtHRTerminationBenefitToBePostedDays1=conn.createStatement();
			Statement stmtHRTerminationBenefitToBePostedDays2=conn.createStatement();
			int days=0;
			
			String sqlTerminationBenefitToBePostedDays = "select t.days from hr_paycode m left join hr_payeost t on m.doc_no=t.rdocno where m.status=3 and m.catid="+empCategoryID+" and t.years>="+yearsWorked+" order by t.years  limit 1";
			ResultSet resultSetTerminationBenefitToBePostedDays = stmtHRTerminationBenefitToBePostedDays.executeQuery(sqlTerminationBenefitToBePostedDays);
			
			int k=0;
			while(resultSetTerminationBenefitToBePostedDays.next()) {
					days=resultSetTerminationBenefitToBePostedDays.getInt("days");
					k=1;
			}
			
			if(k==0) {
				
				String sqlTerminationBenefitToBePostedDays1 = "select max(t.days) days from hr_paycode m left join hr_payeost t on m.doc_no=t.rdocno where m.status=3 and m.catid="+empCategoryID+"";
				ResultSet resultSetTerminationBenefitToBePostedDays1 = stmtHRTerminationBenefitToBePostedDays1.executeQuery(sqlTerminationBenefitToBePostedDays1);		
				
				while(resultSetTerminationBenefitToBePostedDays1.next()){
					days=resultSetTerminationBenefitToBePostedDays1.getInt("days");
				}
				
				stmtHRTerminationBenefitToBePostedDays1.close();	
			}
			
			String sqlTerminationBenefitToBePostedDays2 = "select ("+yearsWorked+"*"+days+") tobeprocesseddays";
			ResultSet resultSetTerminationBenefitToBePostedDays2 = stmtHRTerminationBenefitToBePostedDays2.executeQuery(sqlTerminationBenefitToBePostedDays2);		
			
			while(resultSetTerminationBenefitToBePostedDays2.next()){
				TerminationBenefitToBePostedDays=resultSetTerminationBenefitToBePostedDays2.getString("tobeprocesseddays");
			}
			
			stmtHRTerminationBenefitToBePostedDays2.close();
			stmtHRTerminationBenefitToBePostedDays.close();
		
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return TerminationBenefitToBePostedDays;
		}
		return TerminationBenefitToBePostedDays;
	}
	
	public String getHRTerminationBenefitCurrentDepriciation(Connection conn,String empToBeProcessed,String empAmount) throws SQLException {
    	String TerminationBenefitCurrentDepriciationAmount="0";
    	
		try{
			Statement stmtHRTerminationBenefitCurrentDepriciation=conn.createStatement();
			
			String sqlTerminationBenefitCurrentDepriciation = "select ("+empToBeProcessed+"*("+empAmount+"/30)) currentdepriciation";
			ResultSet resultSetTerminationBenefitCurrentDepriciation = stmtHRTerminationBenefitCurrentDepriciation.executeQuery(sqlTerminationBenefitCurrentDepriciation);
			
			while(resultSetTerminationBenefitCurrentDepriciation.next()) {
					TerminationBenefitCurrentDepriciationAmount=resultSetTerminationBenefitCurrentDepriciation.getString("currentdepriciation");
			}

			stmtHRTerminationBenefitCurrentDepriciation.close();
		
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return TerminationBenefitCurrentDepriciationAmount;
		}
		return TerminationBenefitCurrentDepriciationAmount;
	}
	
	public String getHRLeaveSalaryToBePostedDays(Connection conn,String empCategoryID,Date sqlDeprDate) throws SQLException {
    	String LeaveSalaryToBePostedDays="0";
    	
		try{
			Statement stmtHRLeaveSalaryToBePostedDays=conn.createStatement();
			Statement stmtHRLeaveSalaryToBePostedDays1=conn.createStatement();
			int days=0,years=0;
			
			String sqlLeaveSalaryToBePostedDays = "select m.aelg days,m.awdays years from hr_paycode m where m.status=3 and m.catid="+empCategoryID+"";
			
			ResultSet resultSetLeaveSalaryToBePostedDays = stmtHRLeaveSalaryToBePostedDays.executeQuery(sqlLeaveSalaryToBePostedDays);
			
			while(resultSetLeaveSalaryToBePostedDays.next()) {
					days=resultSetLeaveSalaryToBePostedDays.getInt("days");
					years=resultSetLeaveSalaryToBePostedDays.getInt("years");
			}
						
			String sqlLeaveSalaryToBePostedDays1 = "select (("+days+"/"+years+")*DAY('"+sqlDeprDate+"')) tobeprocesseddays";
			ResultSet resultSetLeaveSalaryToBePostedDays1 = stmtHRLeaveSalaryToBePostedDays1.executeQuery(sqlLeaveSalaryToBePostedDays1);		
			
			while(resultSetLeaveSalaryToBePostedDays1.next()){
				LeaveSalaryToBePostedDays=resultSetLeaveSalaryToBePostedDays1.getString("tobeprocesseddays");
			}
			
			stmtHRLeaveSalaryToBePostedDays1.close();
			stmtHRLeaveSalaryToBePostedDays.close();
		
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
			return LeaveSalaryToBePostedDays;
		}
		return LeaveSalaryToBePostedDays;
	}
}
