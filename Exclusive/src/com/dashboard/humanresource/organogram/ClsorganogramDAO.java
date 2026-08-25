package com.dashboard.humanresource.organogram;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.common.ClsCommon;
import com.connection.*;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsorganogramDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getGoogleOrgChartData()throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String strsql="select * from ("+
			" select m1.desc1 tooltipname,m1desig.desc1 name,coalesce(m2desig.desc1,'') parentname,m1.id,coalesce(m2.id,0) parent from hr_designprem m1 left join hr_setdesig m1desig on"+
			" m1.designation=m1desig.doc_no left join hr_designprem m2 on"+
			" (m1.rep_to=m2.designation and m1.status=3) left join hr_setdesig m2desig on"+
			" m2.designation=m2desig.doc_no where m1.status=3 group by m1.id order by m1.grade ) a order by a.parent,a.id";
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
	
	public JSONArray Loading() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();  
		 Connection conn =  null;
		 try {  
			 conn = objconn.getMyConnection(); 
			 Statement stmt = conn.createStatement();
			String strsql="select * from ("+
			" select m1.id,m1.desc1 name,coalesce(m2.id,0) parent from hr_designprem m1 left join hr_designprem m2 on"+
			" (m1.rep_to=m2.designation and m1.status=3) where m1.status=3 group by m1.id order by m1.grade ) a order by a.parent,a.id";
			ResultSet rs=stmt.executeQuery(strsql);
			RESULTDATA=objcommon.convertToJSON(rs);
			 /*
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
				  String sql="select * from (select @i:=@i+1 val, rep_to,grade,designation,dd.desc1,noof_pos,m.doc_no from hr_designprem m "
				 		+ " left join hr_setdesig dd on dd.doc_no=m.designation ,(select   @i:=0) a where m.status=3 order by grade,rep_to) a order  by val desc "; 
				 String sql="SELECT @i:=@i+1 val,B.* FROM (select @i:=@i+1 val, rep_to,grade,designation,dd.desc1,noof_pos,m.doc_no from hr_designprem m "
				 		+ " left join hr_setdesig dd on dd.doc_no=m.designation  where m.status=3 order by rep_to,grade) b ,(select   @i:=0) a order  by val desc ";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				if(rs.getInt("rep_to")==0) {  
					analysiscolumnarray.add(rs.getString("desc1")+"::CEO::"+rs.getString("desc1")+"::"+0); 	}
				if(rs.getInt("rep_to")>0) {
							analysiscolumnarray.add(rs.getString("desc1")+"::"+rs.getString("rep_to")+"::"+rs.getString("desc1")+"::"+rs.getInt("noof_pos")); }
			}
			System.out.println("==analysiscolumnarray == "+analysiscolumnarray);
			RESULTDATA= convertArrayToJSON(analysiscolumnarray);
	System.out.println("=== RESULTDATA == "+RESULTDATA);
			
			    int cnt=0 , design=0;
				JSONArray faaray = new JSONArray();
				JSONArray jsonArray1 = new JSONArray();
				JSONArray jsonArray2 = new JSONArray();
				JSONObject fobj = new JSONObject();
				JSONObject obj2 = new JSONObject();
			    String sql="SELECT count(*) cnt from hr_designprem m where m.status=3 ";
				ResultSet rs = stmt.executeQuery(sql);
				while(rs.next())
				{  
					cnt=rs.getInt("cnt");
				}
				while(cnt!=0){
					
					String sql1="select desc1,designation,rep_to from hr_designprem where status=3 and rep_to=0;";
					ResultSet rs1 = stmt.executeQuery(sql1);
					while(rs1.next())
					{  
						 obj2.put("head",rs1.getString("desc1"));
						  obj2.put("id",rs1.getString("desc1"));
						  obj2.put("contents",rs1.getString("desc1"));
						  jsonArray1.add(obj2);
						  design=rs1.getInt("designation");
					}
				
					String sql2="select desc1,designation,rep_to from hr_designprem where status=3 and rep_to="+design;
					ResultSet rs2 = stmt.executeQuery(sql2);
					while(rs2.next())
					{  
						 obj2.put("head",rs.getString("desc1"));
						  obj2.put("id",rs.getString("desc1"));
						  obj2.put("contents",rs.getString("desc1"));
						  jsonArray1.add(obj2);
					}
					
				}*/
		 } catch(Exception e) {  
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA; 
	}
	
	public  static  JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
		
		JSONArray faaray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		JSONArray jsonArray2 = new JSONArray();
		JSONObject fobj = new JSONObject();
		JSONObject obj2 = new JSONObject();
		for (int i = 0; i < arrayList.size(); i++) {
			String[] stldarray=arrayList.get(i).split("::");
			if(i==0){
				  for(int k=0;k<Integer.parseInt(stldarray[3]);k++)
				   {
					  obj2.put("head",stldarray[0]);
					  obj2.put("id",stldarray[1]);
					  obj2.put("contents",stldarray[2]);
					  jsonArray1.add(obj2); }
				  	  obj2.clear();	
				  }
			if(i>=1 &&Integer.parseInt(stldarray[3])>0)
			{ for(int k=0;k<Integer.parseInt(stldarray[3]);k++){
			   obj2.put("head",stldarray[0]);
			   obj2.put("id",stldarray[1]);
			   obj2.put("contents",stldarray[2]);
			  if(k==(Integer.parseInt(stldarray[3])-1)) 
			  {
				
			   obj2.put("children", jsonArray1);
			   jsonArray2.add(obj2);
			   jsonArray1.clear();
			   jsonArray1.addAll(jsonArray2);
			   jsonArray2.clear();
			  }
			  else
			  {
				  jsonArray2.add(obj2);
			  } } }
			 if(Integer.parseInt(stldarray[3])==0)	
			 {
			fobj.put("head",stldarray[0]);
			fobj.put("id",stldarray[1]);
			fobj.put("contents",stldarray[2]);
			 }
			 }
		    fobj.put("children",jsonArray1);
		    faaray.add(fobj);
		    return faaray;		
	}

	public  JSONArray convertToJSON(ResultSet resultSet)
			throws Exception {
			JSONArray jsonArray = new JSONArray();
			while (resultSet.next()) {
			int total_rows = resultSet.getMetaData().getColumnCount();
			JSONObject obj = new JSONObject();
			for (int i = 0; i < total_rows; i++) {
				 /*obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), (resultSet.getObject(i + 1)==null) ? "NA" : ((resultSet.getObject(i + 1).equals("0.0000")) ? " " : (resultSet.getObject(i + 1).toString()).replaceAll("[^a-zA-Z0-9_-_._; ]", " ")));*/
				//  obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ")));
				  obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? ""
						 : resultSet.getObject(i + 1).toString().replaceAll("[^a-zA-Z0-9/.+\\s+\\s-\\s:\\s*\\s@\\s\\&\\s%\\s(\\s)\\s;]", " ")));
			//	obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "" : resultSet.getObject(i + 1).toString().replaceAll("[^\\w\\s\\-_]", "")));
				
			}
			jsonArray.add(obj);
			}
			//System.out.println("ConvertTOJson:   "+jsonArray);
			return jsonArray;
			}
}
