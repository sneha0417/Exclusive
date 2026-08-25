package com.dashboard.humanresource.organogram;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.connection.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class CopyOfClsorganogramDAO {
	ClsConnection ClsConnection=new ClsConnection();
	public JSONArray Loading() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();  
		 Connection conn =  null;
		 try {  
			 conn = ClsConnection.getMyConnection(); 
			 Statement stmt = conn.createStatement();
			     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
				 /* String sql="select * from (select @i:=@i+1 val, rep_to,grade,designation,dd.desc1,noof_pos,m.doc_no from hr_designprem m "
				 		+ " left join hr_setdesig dd on dd.doc_no=m.designation ,(select   @i:=0) a where m.status=3 order by grade,rep_to) a order  by val desc "; */
				 String sql="SELECT @i:=@i+1 val,B.* FROM (select @i:=@i+1 val, rep_to,grade,designation,dd.desc1,noof_pos,m.doc_no from hr_designprem m "
				 		+ " left join hr_setdesig dd on dd.doc_no=m.designation  where m.status=3 order by rep_to,grade) b ,(select   @i:=0) a order  by val desc ";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				if(rs.getInt("rep_to")==0) {  
					analysiscolumnarray.add(rs.getString("desc1")+"::CEO::"+rs.getString("desc1")+"::"+0); 	}
				if(rs.getInt("rep_to")>0) {
							analysiscolumnarray.add(rs.getString("desc1")+"::"+rs.getString("doc_no")+"::"+rs.getString("desc1")+"::"+rs.getInt("noof_pos")); }
			}
			System.out.println("==analysiscolumnarray == "+analysiscolumnarray);
			RESULTDATA= convertArrayToJSON(analysiscolumnarray);
			System.out.println("=== RESULTDATA == "+RESULTDATA);
		 } catch(Exception e) {  
			    e.printStackTrace();
			    conn.close();
		  }
		 return RESULTDATA; }
	
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
			 }}
		    fobj.put("children",jsonArray1);
		    faaray.add(fobj);
		    return faaray;		
	}
	 
}
