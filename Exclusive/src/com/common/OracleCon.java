package com.common;

import java.sql.*;
import java.util.ArrayList;
import com.connection.*;
public class OracleCon{

	/*public static void main(String args[]){
try{
Class.forName("oracle.jdbc.driver.OracleDriver");

Connection con=DriverManager.getConnection(
"jdbc:oracle:thin:@10.10.11.100:1521:xe","taajeer","taajeer123");

Statement stmt=con.createStatement();

ResultSet rs=stmt.executeQuery("select * from AUTOLINE_TRANS ");
while(rs.next())
System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));

con.close();

}catch(Exception e){ System.out.println(e);}

}
*/
public String oracleTest(Date fromdt,Date todt){
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");

		// Connection con=DriverManager.getConnection("jdbc:oracle:thin:@10.10.11.100:1521/AFGBRDG","taajeer","taajeer123");
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@10.10.11.100:1521/AFGBRDG.AFG.COM","taajeer","taajeer123");
		
ArrayList<String> oracleData=new ArrayList<String>();
		Statement stmt=con.createStatement();

		 // ResultSet rs=stmt.executeQuery("select * from AUTOLINE_TRANS order by INVOICE_NUMBER desc fetch first 5 rows with ties;");
		 // ResultSet rs=stmt.executeQuery("select CHASSIS_NUMBER, VIN_NUMBER, REG_NUMBER, TRANS_DATE, INVOICE_NUMBER, WIP_NUMBER, LINE_NUMBER, LINE_TYPE, LINE_DESCRIPTION, SELLING_PRICE, DISCOUNT_AMOUNT, NET_PRICE, POS_COMPANY, MKMAGIC, CUSTOMERNAME, ACCOUNTNO, VEHICLEMAGIC from AUTOLINE_TRANS where TRANS_DATE>=TO_DATE('2017/01/01','yyyy/mm/dd')");
		
		 ResultSet rs=stmt.executeQuery("select CHASSIS_NUMBER, VIN_NUMBER, REG_NUMBER, TRANS_DATE, INVOICE_NUMBER, WIP_NUMBER, LINE_NUMBER, LINE_TYPE, LINE_DESCRIPTION, SELLING_PRICE, DISCOUNT_AMOUNT, NET_PRICE, POS_COMPANY, MKMAGIC, CUSTOMERNAME, ACCOUNTNO, VEHICLEMAGIC from AUTOLINE_TRANS where TRANS_DATE>=TO_DATE('"+fromdt+"','yyyy-mm-dd') and TRANS_DATE<=TO_DATE('"+todt+"','yyyy-mm-dd')");
		
		while(rs.next()){
			oracleData.add(rs.getString(1)+"-::::-"+rs.getString(2)+"-::::-"+rs.getString(3)+"-::::-"+rs.getDate(4)+"-::::-"+rs.getInt(5)+"-::::-"+rs.getInt(6)+"-::::-"+rs.getInt(7)+"-::::-"+rs.getString(8)+"-::::-"+rs.getString(9)+"-::::-"+rs.getInt(10)+"-::::-"+rs.getInt(11)+"-::::-"+rs.getInt(12)+"-::::-"+rs.getString(13)+"-::::-"+rs.getInt(14)+"-::::-"+rs.getString(15)+"-::::-"+rs.getString(16)+"-::::-"+rs.getString(17));
		// System.out.println(rs.getString(1)+"  "+rs.getString(2)+"  "+rs.getString(3));
			
		}
		// System.out.println("=== array "+oracleData);
		con.close();

		ClsConnection clsConnection=new ClsConnection();
		Connection conn=clsConnection.getMyConnection();
		Statement statement=conn.createStatement();
		int val=0;
		for (int i = 0; i < oracleData.size(); i++) {
			int rows=0;
			String[] array_element = oracleData.get(i).split("-::::-");
			ResultSet rsview=statement.executeQuery("select * from gl_autoline where INVOICE_NUMBER="+array_element[4]+" and LINE_NUMBER="+array_element[6]+" and LINE_type='"+array_element[7]+"' ");
			// System.out.println("============= select * from gl_autoline where INVOICE_NUMBER="+array_element[4]+" and LINE_NUMBER="+array_element[6]+" and LINE_type='"+array_element[7]+"' ");
			while(rsview.next()){
//				System.out.println("invoice no"+rsview.getInt("INVOICE_NUMBER"));
				rows=rsview.getInt("INVOICE_NUMBER");
			}
//			System.out.println("====== "+rows);
			if(rows==0){
	//			System.out.println("====== "+rows);
				val=statement.executeUpdate("insert into gl_autoline(CHASSIS_NUMBER, VIN_NUMBER, REG_NUMBER, TRANS_DATE, INVOICE_NUMBER, WIP_NUMBER, LINE_NUMBER, LINE_TYPE, LINE_DESCRIPTION, SELLING_PRICE, DISCOUNT_AMOUNT, NET_PRICE, POS_COMPANY, MKMAGIC, CUSTOMERNAME, ACCOUNTNO, VEHICLEMAGIC ) "
						+ "values ('"+array_element[0]+"', '"+array_element[1]+"', '"+array_element[2]+"','"+array_element[3]+"',"+array_element[4]+","+array_element[5]+","+array_element[6]+",'"+array_element[7]+"','"+array_element[8]+"',"+array_element[9]+","+array_element[10]+","+array_element[11]+",'"+array_element[12]+"',"+array_element[13]+",'"+array_element[14]+"','"+array_element[15]+"','"+array_element[16]+"')");
			 }
		}
		// System.out.println("=== val === "+val);
		conn.close();
		}catch(Exception e){ 
			System.out.println(e);
			e.printStackTrace();
		return "fail";	
		}

	return "success";
		}
}
