package com.common;

import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ClsVatInsert {

	public int vatinsert(int count,int iotype,Connection conn, int mastertr_no,int acno, int vocno, Date masterdate, String formdetailcode, String brhid, String invno,
			int cmbbilltype, ArrayList<String> arr,String mode) throws SQLException
	{
		
		try
		{      
			Statement statement=conn.createStatement();
				if(mode.equalsIgnoreCase("D")) 
			{
				
			String sqlss1=" update my_taxtran set status=7 where tr_no='"+mastertr_no+"'";
			statement.executeUpdate(sqlss1);
				return 1;
			}
			
			if(mode.equalsIgnoreCase("E") && count==1)
			{
				String sqlss="delete from my_taxtran where tr_no='"+mastertr_no+"'";
				statement.executeUpdate(sqlss);
			}
			for(int i=0;i< arr.size();i++){
			     String[] masterarry=arr.get(i).split("::");
			     String insertSql="INSERT INTO my_taxtran(sr_no, iotype, tr_no, acno, date,  dtype, voc_no,billtype, brhid, invno, totalamount, total1, total2, total3, total4, "
			    		 + " total5, total6, total7, total8, total9, total10, tax1, tax2, tax3, tax4, tax5, tax6, tax7, tax8, tax9, tax10,status)VALUES"
					       + " ("+(i+1)+","+iotype+","+mastertr_no+","+acno+",'"+masterdate+"','"+formdetailcode+"',"+vocno+",'"+cmbbilltype+"','"+brhid+"','"+invno+"',"
					       + "'"+(masterarry[0].trim().equalsIgnoreCase("undefined") || masterarry[0].trim().equalsIgnoreCase("NaN")|| masterarry[0].trim().equalsIgnoreCase("")|| masterarry[0].isEmpty()?0:masterarry[0].trim())+"',"
					       + "'"+(masterarry[1].trim().equalsIgnoreCase("undefined") || masterarry[1].trim().equalsIgnoreCase("NaN")|| masterarry[1].trim().equalsIgnoreCase("")|| masterarry[1].isEmpty()?0:masterarry[1].trim())+"',"
					       + "'"+(masterarry[2].trim().equalsIgnoreCase("undefined") || masterarry[2].trim().equalsIgnoreCase("NaN")|| masterarry[2].trim().equalsIgnoreCase("")|| masterarry[2].isEmpty()?0:masterarry[2].trim())+"',"
					       + "'"+(masterarry[3].trim().equalsIgnoreCase("undefined") || masterarry[3].trim().equalsIgnoreCase("NaN")||masterarry[3].trim().equalsIgnoreCase("")|| masterarry[3].isEmpty()?0:masterarry[3].trim())+"',"
					       + "'"+(masterarry[4].trim().equalsIgnoreCase("undefined") || masterarry[4].trim().equalsIgnoreCase("NaN")||masterarry[4].trim().equalsIgnoreCase("")|| masterarry[4].isEmpty()?0:masterarry[4].trim())+"',"
					       + "'"+(masterarry[5].trim().equalsIgnoreCase("undefined") || masterarry[5].trim().equalsIgnoreCase("NaN")||masterarry[5].trim().equalsIgnoreCase("")|| masterarry[5].isEmpty()?0:masterarry[5].trim())+"',"
					       + "'"+(masterarry[6].trim().equalsIgnoreCase("undefined") || masterarry[6].trim().equalsIgnoreCase("NaN")||masterarry[6].trim().equalsIgnoreCase("")|| masterarry[6].isEmpty()?0:masterarry[6].trim())+"',"
					       + "'"+(masterarry[7].trim().equalsIgnoreCase("undefined") || masterarry[7].trim().equalsIgnoreCase("NaN")||masterarry[7].trim().equalsIgnoreCase("")|| masterarry[7].isEmpty()?0:masterarry[7].trim())+"',"
					       + "'"+(masterarry[8].trim().equalsIgnoreCase("undefined") || masterarry[8].trim().equalsIgnoreCase("NaN")||masterarry[8].trim().equalsIgnoreCase("")|| masterarry[8].isEmpty()?0:masterarry[8].trim())+"',"
					       + "'"+(masterarry[9].trim().equalsIgnoreCase("undefined") || masterarry[9].trim().equalsIgnoreCase("NaN")||masterarry[9].trim().equalsIgnoreCase("")|| masterarry[9].isEmpty()?0:masterarry[9].trim())+"',"					       					     
					       + "'"+(masterarry[10].trim().equalsIgnoreCase("undefined") || masterarry[10].trim().equalsIgnoreCase("NaN")||masterarry[10].trim().equalsIgnoreCase("")|| masterarry[10].isEmpty()?0:masterarry[10].trim())+"',"
					       + "'"+(masterarry[11].trim().equalsIgnoreCase("undefined") || masterarry[11].trim().equalsIgnoreCase("NaN")||masterarry[11].trim().equalsIgnoreCase("")|| masterarry[11].isEmpty()?0:masterarry[11].trim())+"',"
					       + "'"+(masterarry[12].trim().equalsIgnoreCase("undefined") || masterarry[12].trim().equalsIgnoreCase("NaN")||masterarry[12].trim().equalsIgnoreCase("")|| masterarry[12].isEmpty()?0:masterarry[12].trim())+"',"
					       + "'"+(masterarry[13].trim().equalsIgnoreCase("undefined") || masterarry[13].trim().equalsIgnoreCase("NaN")||masterarry[13].trim().equalsIgnoreCase("")|| masterarry[13].isEmpty()?0:masterarry[13].trim())+"',"
					       + "'"+(masterarry[14].trim().equalsIgnoreCase("undefined") || masterarry[14].trim().equalsIgnoreCase("NaN")||masterarry[14].trim().equalsIgnoreCase("")|| masterarry[14].isEmpty()?0:masterarry[14].trim())+"',"
					       + "'"+(masterarry[15].trim().equalsIgnoreCase("undefined") || masterarry[15].trim().equalsIgnoreCase("NaN")||masterarry[15].trim().equalsIgnoreCase("")|| masterarry[15].isEmpty()?0:masterarry[15].trim())+"',"
					       + "'"+(masterarry[16].trim().equalsIgnoreCase("undefined") || masterarry[16].trim().equalsIgnoreCase("NaN")||masterarry[16].trim().equalsIgnoreCase("")|| masterarry[16].isEmpty()?0:masterarry[16].trim())+"',"
					       + "'"+(masterarry[17].trim().equalsIgnoreCase("undefined") || masterarry[17].trim().equalsIgnoreCase("NaN")||masterarry[17].trim().equalsIgnoreCase("")||  masterarry[17].isEmpty()?0:masterarry[17].trim())+"',"
					       + "'"+(masterarry[18].trim().equalsIgnoreCase("undefined") || masterarry[18].trim().equalsIgnoreCase("NaN")||masterarry[18].trim().equalsIgnoreCase("")||   masterarry[18].isEmpty()?0:masterarry[18].trim())+"',"
					       + "'"+(masterarry[19].trim().equalsIgnoreCase("undefined") || masterarry[19].trim().equalsIgnoreCase("NaN")||masterarry[19].trim().equalsIgnoreCase("")||   masterarry[19].isEmpty()?0:masterarry[19].trim())+"',"
					       + "'"+(masterarry[20].trim().equalsIgnoreCase("undefined") || masterarry[20].trim().equalsIgnoreCase("NaN")||masterarry[20].trim().equalsIgnoreCase("")||   masterarry[20].isEmpty()?0:masterarry[20].trim())+"' ,3)";
				     int resultSet2 = statement.executeUpdate(insertSql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
				 
			     }	    
				     
			if(formdetailcode.equalsIgnoreCase("INR") || formdetailcode.equalsIgnoreCase("PIR") || formdetailcode.equalsIgnoreCase("SRR") || formdetailcode.equalsIgnoreCase("CPR") || formdetailcode.equalsIgnoreCase("PJIR"))
			{
				String sqlsss="update my_taxtran set  totalamount=totalamount*-1,total1=total1*-1, total2=total2*-1, total3=total3*-1, total4=total4*-1, "
						 + " total5=total5*-1, total6=total6*-1, total7=total7*-1, total8=total8*-1, total9=total9*-1, "
						 + " total10=total10*-1, tax1=tax1*-1, tax2=tax2*-1, tax3=tax3*-1, tax4=tax4*-1, tax5=tax5*-1, tax6=tax6*-1, tax7=tax7*-1, "
						 + " tax8=tax8*-1,"
						 + " tax9=tax9*-1, tax10=tax10*-1 where tr_no='"+mastertr_no+"' and iotype="+iotype+" and dtype in ('INR','PIR','SRR','CPR','PJIR') ";
			statement.executeUpdate(sqlsss);
			}
			
			if(formdetailcode.equalsIgnoreCase("CPU"))
			{
				 String sqlss="update  my_srvpurm m left join my_taxtran t on t.tr_no=m.tr_no  set t.invdate=m.invdate where t.tr_no='"+mastertr_no+"' " ;
				 statement.executeUpdate(sqlss);
			}
			
			if(formdetailcode.equalsIgnoreCase("CPR"))
			{
				 String sqlss="update  my_srvpurretm m left join my_taxtran t on t.tr_no=m.tr_no  set t.invdate=m.invdate where t.tr_no='"+mastertr_no+"' " ;
				 statement.executeUpdate(sqlss);
			}
			
			
			if(formdetailcode.equalsIgnoreCase("PIV"))
			{
				 String sqlss="update  my_srvm m left join my_taxtran t on t.tr_no=m.tr_no  set t.invdate=m.refinvdate where t.tr_no='"+mastertr_no+"' " ;
				 
				 
				 statement.executeUpdate(sqlss);
				
			}
			
			return 1;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			conn.close();
			
		}
		
		return 0;
		
	}
	
	
}
