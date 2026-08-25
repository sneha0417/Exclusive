<%@page import="propertyinsplogin.ClsPropertyInspLoginDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String propdocno=request.getParameter("propdocno")==null?"":request.getParameter("propdocno");
String insptype=request.getParameter("insptype")==null?"":request.getParameter("insptype");
String inspdocno=request.getParameter("inspdocno")==null?"0":request.getParameter("inspdocno");
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	ClsPropertyInspLoginDAO dao=new ClsPropertyInspLoginDAO();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	if(inspdocno.trim().equalsIgnoreCase("") || inspdocno.equalsIgnoreCase("undefined") || inspdocno==null){
		inspdocno="0";
	}
	String strsql="select coalesce(insp.comments,'') comments,coalesce(insp.inspstatus,'') inspstatus,room.imagename,room.doc_no roomdocno,room.rdesc1 roomdesc,furn.doc_no furndocno,furn.fdesc1 furndesc from re_proomfurnfix m left join "+
	" re_mfurnfix furn on (m.furnfixdoc_no=furn.doc_no) left join re_mroom room on(furn.rdoc_no=room.doc_no) "+
	" left join rl_propinspd insp on (insp.rdocno="+inspdocno+" and insp.roomdocno=room.doc_no and insp.furndocno=furn.doc_no) where m.pdoc_no="+propdocno+" order by room.doc_no,furn.sr_no";
	System.out.println(strsql);
	ResultSet rs=stmt.executeQuery(strsql);
	JSONArray furnarray=new JSONArray();
	int roomdocno=0;
	String roomdesc="";
	String roomimg="";
	JSONArray roomarray=new JSONArray();
	JSONObject objtemp=new JSONObject();
	while(rs.next()){
		if(roomdocno!=0 && roomdocno!=rs.getInt("roomdocno")){
			objtemp.put("roomdocno",roomdocno);
			objtemp.put("roomdesc",roomdesc);
			objtemp.put("roomimg",roomimg);
			objtemp.put("furnarray",furnarray);
			
			roomarray.add(objtemp);
			objtemp=new JSONObject();
			furnarray=new JSONArray();
		}
		JSONObject objfurn=new JSONObject();
		objfurn.put("furndocno",rs.getString("furndocno"));
		objfurn.put("furndesc",rs.getString("furndesc"));
		objfurn.put("comments",rs.getString("comments"));
		objfurn.put("inspstatus",rs.getString("inspstatus"));
		String handoverdesc="";
		if(insptype.equalsIgnoreCase("Hand Back")){
			handoverdesc=dao.getHandOverData(rs.getInt("furndocno"),rs.getInt("roomdocno"),Integer.parseInt(propdocno),conn);
		}
		objfurn.put("handoverdata", handoverdesc);
		furnarray.add(objfurn);
		roomdocno=rs.getInt("roomdocno");
		roomdesc=rs.getString("roomdesc");
		roomimg=rs.getString("imagename");
	}
	if(roomdocno>0){
		objtemp.put("roomdocno",roomdocno);
		objtemp.put("roomdesc",roomdesc);
		objtemp.put("roomimg",roomimg);
		objtemp.put("furnarray",furnarray);
		roomarray.add(objtemp);	
	}
	
	System.out.println(roomarray);
	
	String strgetinsptype="select doc_no,name from rl_insptype where status=3";
	ResultSet rsinsptype=stmt.executeQuery(strgetinsptype);
	JSONArray insparray=new JSONArray();
	while(rsinsptype.next()){
		JSONObject objinsp=new JSONObject();
		objinsp.put("docno",rsinsptype.getString("doc_no"));
		objinsp.put("name",rsinsptype.getString("name"));
		insparray.add(objinsp);
	}
	JSONArray keyarray=new JSONArray();
	if(insptype.equalsIgnoreCase("Hand Back") || insptype.equalsIgnoreCase("Hand Over")){
		String strgetkeys="select coalesce(k1.comments,'') comments,concat(coalesce(k.acsutility,''),' - ',coalesce(k.acsno,'')) keydesc,k.aqty keyqty,k.acid keydocno from re_access k left join rl_propkeys k1 on (k1.rdocno="+inspdocno+" and k.acid=k1.keydocno) where k.doc_no="+propdocno;
		System.out.println(strgetkeys);
		ResultSet rsgetkeys=stmt.executeQuery(strgetkeys);
		while(rsgetkeys.next()){
			JSONObject objkey=new JSONObject();
			objkey.put("keydocno",rsgetkeys.getInt("keydocno"));
			objkey.put("keyqty",rsgetkeys.getString("keyqty"));
			objkey.put("keydesc",rsgetkeys.getString("keydesc"));
			String handoverdesc="";
			if(insptype.equalsIgnoreCase("Hand Back")){
				handoverdesc=dao.getKeyHandOverData(rsgetkeys.getInt("keydocno"),Integer.parseInt(propdocno),conn);
			}
			objkey.put("handoverdata",handoverdesc);
			objkey.put("comments",rsgetkeys.getString("comments"));
			keyarray.add(objkey);
		}
	}
	
	objdata.put("roomdata",roomarray);
	objdata.put("insptypedata",insparray);
	objdata.put("keydata",keyarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>