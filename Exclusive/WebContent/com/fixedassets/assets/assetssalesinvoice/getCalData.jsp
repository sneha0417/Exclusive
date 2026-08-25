<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>

<%
Connection conn=null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

try{
	//Notations used in calculation
	/* 
	Sales Price 	-salesprice
	Dep Posted		-deprdate
	Purchase Value	-purcost
	Acc.Dep			-sumassetamt
	Current Dep		-days
	Net P(L)		-netamt */
	
	
 	conn=ClsConnection.getMyConnection();
	String asset=request.getParameter("asset")==null?"0":request.getParameter("asset");
	String date=request.getParameter("date")==null?"":request.getParameter("date");
	double salesprice=Double.parseDouble(request.getParameter("salesprice")==null?"0":request.getParameter("salesprice"));
	

	Statement stmtfleet=conn.createStatement();
	java.sql.Date deprdate=null,docdate=null;
	if(!(date.equalsIgnoreCase(""))){
		docdate=ClsCommon.changeStringtoSqlDate(date);
	}
	
	
	double purcost=0.0;
	String strfleet="select depr_date from my_fixm where sr_no="+asset;
	ResultSet rsfleet=stmtfleet.executeQuery(strfleet);
	if(rsfleet.next()){
		deprdate=rsfleet.getDate("depr_date");
		//purcost=rsfleet.getDouble("tval");
	}
	
	Statement stmtpurch=conn.createStatement();
	/* String strpurch="select coalesce(sum(dramount),0) purchasevalue from my_fatran asset left join my_account ac on (asset.acno=ac.acno and"+
					" ac.codeno='VEH') where ac.codeno='VEH' and asset_no="+asset; */
					String strpurch="select coalesce(sum(dramount),0) purchasevalue from my_fatran asset left join my_fixm fix on asset.asset_no=fix.sr_no inner"+
									" join my_head head on fix.fixastacno=head.doc_no where asset.asset_no="+asset+" and asset.acno=fix.fixastacno";
	ResultSet rspurch=stmtpurch.executeQuery(strpurch);
	while(rspurch.next()){
		purcost=rspurch.getDouble("purchasevalue");
		}
	stmtpurch.close();
	
	double sumassetamt=0.0;
	Statement stmtaccdepr=conn.createStatement();
	String straccdepr="select coalesce(sum(dramount),0) accdeprvalue from my_fatran asset left join my_fixm fix on asset.asset_no=fix.sr_no inner"+
			" join my_head head on fix.accdepacno=head.doc_no where asset.asset_no="+asset+" and asset.acno=fix.accdepacno";
	Statement stmtasset=conn.createStatement();
	ResultSet rsaccdepr=stmtaccdepr.executeQuery(straccdepr);
	while(rsaccdepr.next()){
	sumassetamt=rsaccdepr.getDouble("accdeprvalue")*-1;
	}
	/* String strasset="select (select sum(dramount) from gc_assettran where fleet_no="+fleet+") sumamount,datediff('"+docdate+"','"+deprdate+"') daysdiff"; */
	/* String strasset="select datediff('"+docdate+"','"+deprdate+"') datediff,round((("+purcost+" * "+sumassetamt+"/100)/365)*(select datediff) ,2) currentdepr"; */
	/* String strasset="select coalesce(sum(dramount),0) depr from my_fatran asset left join my_fixm fix on asset.asset_no=fix.sr_no inner"+
					" join my_head head on fix.depacno=head.doc_no where asset.asset_no="+asset+" and asset.acno=fix.depacno"; */
	String strasset="select datediff('"+docdate+"','"+deprdate+"') datediff,round((("+purcost+" * deprper/100)/365)*(select datediff) ,2) currentdepr from my_fixm where sr_no="+asset; 
					
	System.out.println("Current Depr Query: "+strasset);
	String strcheckcurdepr="select sum(dramount) amt from my_fatran asset where asset.asset_no="+asset;
	ResultSet rscheck=stmtasset.executeQuery(strcheckcurdepr);
	double checkcuramt=0.0;
	while(rscheck.next()){
		checkcuramt=rscheck.getDouble("amt");
	}
	double currentdepr=0.0;
	
	ResultSet rsasset=stmtasset.executeQuery(strasset);
	if(rsasset.next()){
		//sumassetamt=rsasset.getDouble("sumamount");
		currentdepr=rsasset.getDouble("currentdepr");
	}
	if(checkcuramt<=currentdepr){
		currentdepr=checkcuramt;
	}
	System.out.println(purcost+"::"+sumassetamt+"::"+currentdepr);
	double netbook=purcost-sumassetamt-currentdepr;
	
	double netamt=salesprice-netbook;
	
	stmtasset.close();
	stmtfleet.close();
	conn.close();
	
	response.getWriter().write(deprdate+"::"+purcost+"::"+sumassetamt+"::"+currentdepr+"::"+netamt+"::"+netbook);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
  %>