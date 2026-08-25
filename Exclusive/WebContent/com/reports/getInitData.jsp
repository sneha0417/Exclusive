<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select a.description,a.acno,round(sum(a.month1),2) month1,round(sum(a.month2),2) month2,round(sum(a.month3),2) month3,"+
	" round(sum(a.month4),2) month4,round(sum(a.month5),2) month5,round(sum(a.month6),2) month6,"+
	" round(sum(a.month7),2) month7,round(sum(a.month8),2) month8,round(sum(a.month9),2) month9,"+
	" round(sum(a.month10),2) month10,round(sum(a.month11),2) month11,round(sum(a.month12),2) month12,"+
	" round(sum(a.month13),2) month13 from ("+
	" select head.description,jv.acno,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 12 month)) and year(jv.date)=year(date_sub(curdate(),interval 12 month))"+
	" then jv.dramount*jv.id else 0.0 end month1,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 11 month)) and year(jv.date)=year(date_sub(curdate(),interval 11 month))"+
	" then jv.dramount*jv.id else 0.0 end month2,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 10 month)) and year(jv.date)=year(date_sub(curdate(),interval 10 month))"+
	" then jv.dramount*jv.id else 0.0 end month3,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 9 month)) and year(jv.date)=year(date_sub(curdate(),interval 9 month))"+
	" then jv.dramount*jv.id else 0.0 end month4,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 8 month)) and year(jv.date)=year(date_sub(curdate(),interval 8 month))"+
	" then jv.dramount*jv.id else 0.0 end month5,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 7 month)) and year(jv.date)=year(date_sub(curdate(),interval 7 month))"+
	" then jv.dramount*jv.id else 0.0 end month6,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 6 month)) and year(jv.date)=year(date_sub(curdate(),interval 6 month))"+
	" then jv.dramount*jv.id else 0.0 end month7,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 5 month)) and year(jv.date)=year(date_sub(curdate(),interval 5 month))"+
	" then jv.dramount*jv.id else 0.0 end month8,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 4 month)) and year(jv.date)=year(date_sub(curdate(),interval 4 month))"+
	" then jv.dramount*jv.id else 0.0 end month9,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 3 month)) and year(jv.date)=year(date_sub(curdate(),interval 3 month))"+
	" then jv.dramount*jv.id else 0.0 end month10,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 2 month)) and year(jv.date)=year(date_sub(curdate(),interval 2 month))"+
	" then jv.dramount*jv.id else 0.0 end month11,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 1 month)) and year(jv.date)=year(date_sub(curdate(),interval 1 month))"+
	" then jv.dramount*jv.id else 0.0 end month12,"+
	" case when month(jv.date)=month(date_sub(curdate(),interval 0 month)) and year(jv.date)=year(date_sub(curdate(),interval 0 month))"+
	" then jv.dramount*jv.id else 0.0 end month13 from my_head head left join my_jvtran jv on (head.doc_no=jv.acno and jv.status=3) where head.den=110 and head.m_s=0 and"+
	" jv.date>=date_sub(curdate(),interval 12 month) and jv.date<=date_sub(curdate(),interval 0 month)) a group by a.acno";
	ResultSet rs=stmt.executeQuery(strsql);
	JSONArray incomearray=new JSONArray();
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("description",rs.getString("description"));
		objtemp.put("month1",rs.getString("month1"));
		objtemp.put("month2",rs.getString("month2"));
		objtemp.put("month3",rs.getString("month3"));
		objtemp.put("month4",rs.getString("month4"));
		objtemp.put("month5",rs.getString("month5"));
		objtemp.put("month6",rs.getString("month6"));
		objtemp.put("month7",rs.getString("month7"));
		objtemp.put("month8",rs.getString("month8"));
		objtemp.put("month9",rs.getString("month9"));
		objtemp.put("month10",rs.getString("month10"));
		objtemp.put("month11",rs.getString("month11"));
		objtemp.put("month12",rs.getString("month12"));
		objtemp.put("month13",rs.getString("month13"));
		incomearray.add(objtemp);
	}
	ArrayList<String> monthnamearray=new ArrayList();
	for(int i=0,j=12;i<=12;i++,j--){
		String strgetmonthnames="select date_format(date_sub(curdate(),interval "+j+" month),'%b %Y') monthname";	
		ResultSet rsgetmonthname=stmt.executeQuery(strgetmonthnames);
		while(rsgetmonthname.next()){
			monthnamearray.add(rsgetmonthname.getString("monthname"));
		}
	}
	objdata.put("incomedata",incomearray);
	objdata.put("monthnames", monthnamearray);
	System.out.println(objdata);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>
