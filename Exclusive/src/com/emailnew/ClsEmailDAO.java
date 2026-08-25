package com.emailnew;

 import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

    import javax.servlet.http.HttpSession;

    import net.sf.json.JSONArray;

    import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsEmailDAO  { 
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();   
	
	public  JSONArray dtypeSearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        ResultSet resultSet =null;
        Connection conn =null;
    	Statement stmtVeh =null;
		try {
			    conn = ClsConnection.getMyConnection();      
				 stmtVeh = conn.createStatement ();
				String sql="select 'CRM' dtype ";
            	//System.out.println("----"+sql);
            		 resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            	

		}
		catch(Exception e){
			
		}finally {
	        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
	        if (stmtVeh != null) try { stmtVeh.close(); } catch (SQLException ignore) {}          //Written By sudhi  
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}             
	    }
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	 public  JSONArray reGridload(String docno,String dtype,String brchid) throws SQLException {  
	        JSONArray RESULTDATA=new JSONArray();
	        ClsCommon clcom=new ClsCommon();              
	        Connection conn = null;
			     try {
			         conn = ClsConnection.getMyConnection();
			       Statement cpstmt = conn.createStatement();
			       
			       int i=0;
			       String sqls="",sqltst="",docnoss="",dtypess="",sqltest="";  
			       String  cpsql="";
			       String sqlsss="select * from gl_attachtypechk where dtype='"+dtype+"' and status=3";
			       ResultSet rs=cpstmt.executeQuery(sqlsss);
			       if(rs.next())
			       {
			    	   i=1;
			       }
			       
			       if(i==0)
			       {
			    	   sqls= " and a.brhid='"+brchid+"' " ;     
			       }
			       ResultSet rs44=null;
			      // System.out.println("docno--->>>"+docno+"---"+dtype);
			       if(dtype.equalsIgnoreCase("CREG")){                 
					   sqltst="select mm.brhid crbrhid,en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,coalesce(eq.cldocno,0) cldocno,coalesce(mm.doc_no,0) crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_callregm mm left join in_endorsement en on en.refno=mm.doc_no and en.reftype='CREG' left join in_contract cm on cm.doc_no=en.cntrno and cm.dtype='ENQ' left join in_enqm eq on cm.refno=eq.doc_no left join in_srvqotm qm on qm.refdocno=eq.doc_no where 1=1 and mm.doc_no="+docno+"";
					    rs44=cpstmt.executeQuery(sqltst); 
					    while(rs44.next()){    
	 	  		    		docnoss+=rs44.getString("crgno")+",";
				    		cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("crgno")+") and a.dtype in ('CREG') and a.brhid="+rs44.getString("crbrhid")+" ";   
	 	  		    		   
					       docnoss+=rs44.getString("endno")+",";
			    		   cpsql=cpsql+"union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" ";
						 
					       docnoss+=rs44.getString("insno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("qotno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+" ";
						   
	                       if(rs44.getString("clientid").equalsIgnoreCase("1")){
			    			   dtypess+="'CRM'";
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";   
			    		   }else{
			    			   dtypess+="'PPC'";   
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
			    		   }
						    dtypess+="'END'"+",";  
			    		   dtypess+="'INS'"+",";  
						   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   dtypess+="'CRM'"+",";
			    	     }
			       }else if(dtype.equalsIgnoreCase("ENQ")){           
					   sqltst="select en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,coalesce(eq.cldocno,0) cldocno,0 crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_enqm eq left join in_srvqotm qm on qm.refdocno=eq.doc_no left join in_contract cm on cm.refno=eq.doc_no and cm.dtype='ENQ' left join in_endorsement en on cm.doc_no=en.cntrno where 1=1 and eq.voc_no="+docno+"";
					    rs44=cpstmt.executeQuery(sqltst); 
					    while(rs44.next()){    
	 	  		    			   
					       docnoss+=rs44.getString("endno")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" ";
						 
					       docnoss+=rs44.getString("insno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("qotno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+" ";
						   
	                       if(rs44.getString("clientid").equalsIgnoreCase("1")){
			    			   dtypess+="'CRM'";
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";   
			    		   }else{
			    			   dtypess+="'PPC'";   
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
			    		   }
						    dtypess+="'END'"+",";  
			    		   dtypess+="'INS'"+",";  
						   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   dtypess+="'CRM'"+",";
			    	     }
			       }else if(dtype.equalsIgnoreCase("SQOT")){
					   sqltst="select en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,coalesce(eq.cldocno,0) cldocno,0 crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_srvqotm qm left join in_enqm eq on qm.refdocno=eq.doc_no left join in_contract cm on cm.refno=eq.doc_no and cm.dtype='ENQ' left join in_endorsement en on cm.doc_no=en.cntrno where 1=1 and qm.doc_no="+docno+"";
					    rs44=cpstmt.executeQuery(sqltst); 
					    while(rs44.next()){    
	 	  		    			   
					       docnoss+=rs44.getString("endno")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" ";
						 
					       docnoss+=rs44.getString("insno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("qotno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+" ";
						   
	                       if(rs44.getString("clientid").equalsIgnoreCase("1")){
			    			   dtypess+="'CRM'";
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";   
			    		   }else{
			    			   dtypess+="'PPC'";   
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
			    		   }
						    dtypess+="'END'"+",";  
			    		   dtypess+="'INS'"+",";  
						   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   dtypess+="'CRM'"+",";
			    	     }
			       }else if(dtype.equalsIgnoreCase("INS")){
					   sqltst="select en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,coalesce(eq.cldocno,0) cldocno,0 crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_contract cm left join in_enqm eq on cm.refno=eq.doc_no left join in_srvqotm qm on qm.refdocno=eq.doc_no left join in_endorsement en on cm.doc_no=en.cntrno where 1=1 and cm.voc_no="+docno+"";
					    rs44=cpstmt.executeQuery(sqltst); 
					    while(rs44.next()){    
	 	  		    			   
					       docnoss+=rs44.getString("endno")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" ";
						 
					       docnoss+=rs44.getString("insno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("qotno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+" ";
						   
	                       if(rs44.getString("clientid").equalsIgnoreCase("1")){
			    			   dtypess+="'CRM'";
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";   
			    		   }else{
			    			   dtypess+="'PPC'";   
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
			    		   }
						    dtypess+="'END'"+",";  
			    		   dtypess+="'INS'"+",";  
						   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   dtypess+="'CRM'"+",";
			    	     }
			       }else if(dtype.equalsIgnoreCase("END")){      
					   sqltst="select en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,coalesce(eq.cldocno,0) cldocno,0 crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_endorsement en left join in_contract cm on cm.doc_no=en.cntrno and cm.dtype='ENQ' left join in_enqm eq on cm.refno=eq.doc_no left join in_srvqotm qm on qm.refdocno=eq.doc_no where 1=1 and en.voc_no="+docno+"";
					    rs44=cpstmt.executeQuery(sqltst); 
					    while(rs44.next()){      
	 	  		    			   
					       docnoss+=rs44.getString("endno")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" ";
						 
					       docnoss+=rs44.getString("insno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("qotno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+" ";
						   
	                       if(rs44.getString("clientid").equalsIgnoreCase("1")){
			    			   dtypess+="'CRM'";
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";   
			    		   }else{
			    			   dtypess+="'PPC'";   
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
			    		   }
						    dtypess+="'END'"+",";  
			    		   dtypess+="'INS'"+",";  
						   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   dtypess+="'CRM'"+",";
			    	     }
			       }else{    
                            cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+docno+") and a.dtype in ('"+dtype+"') "+sqls+" order by sr_no desc"; 					      

						  
				   }
			 	  		    	
			       /*if(dtype.equalsIgnoreCase("END")){           
			    	   sqltst="select m.cldocno,eq.voc_no enqno,en.voc_no endno,en.brhid endbrch,m.voc_no,qm.doc_no qotno,m.brhid cntbrhid,qm.brhid qotbrhid,eq.brhid enqbrhid from in_endorsement en left join in_contract m on m.doc_no=en.cntrno left join in_enqm eq on eq.doc_no=m.refno left join in_srvqotm qm on qm.refdocno=eq.doc_no where en.doc_no="+docno+"";  
			    	   System.out.println("sqltst--->>>"+sqltst);
			    	   ResultSet rs44=cpstmt.executeQuery(sqltst);      
			    	   while(rs44.next()){
					       docnoss+=rs44.getString("endno")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" ";
						 
					       docnoss+=rs44.getString("voc_no")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("voc_no")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("qotno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+" ";
						   
			    		   docnoss+=rs44.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+" ";
						   
	                       docnoss+=rs44.getString("cldocno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM') order by sr_no desc";

						    dtypess+="'END'"+",";  
			    		   dtypess+="'INS'"+",";  
						   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   dtypess+="'CRM'"+",";
			    	     }
			    	   System.out.println("cpsql--->>>"+cpsql);
			           }else if(dtype.equalsIgnoreCase("INS")){           
			    	    sqltst="select m.cldocno,eq.voc_no enqno,m.voc_no,qm.doc_no qotno,m.brhid cntbrhid,qm.brhid qotbrhid,eq.brhid enqbrhid from in_contract m left join in_enqm eq on eq.doc_no=m.refno left join in_srvqotm qm on qm.refdocno=eq.doc_no where m.doc_no="+docno+"";  
			    	    ResultSet rs33=cpstmt.executeQuery(sqltst);      
			    	    while(rs33.next()){
			    		   docnoss+=rs33.getString("voc_no")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs33.getString("voc_no")+") and a.dtype in ('INS') and a.brhid="+rs33.getString("cntbrhid")+" ";
						   
			    		   docnoss+=rs33.getString("qotno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs33.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs33.getString("qotbrhid")+" ";
						   
			    		   docnoss+=rs33.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs33.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs33.getString("enqbrhid")+" ";
						   
	                       docnoss+=rs33.getString("cldocno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs33.getString("cldocno")+") and a.dtype in ('CRM') order by sr_no desc";

			    		   dtypess+="'INS'"+",";
						   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   dtypess+="'CRM'"+",";
			    		     
			           }
			       }else if(dtype.equalsIgnoreCase("SQOT")){
			    	   sqltst="select m.cldocno,eq.voc_no enqno,eq.clientid,m.doc_no,m.brhid qotbrhid,eq.brhid enqbrhid from in_srvqotm m left join in_enqm eq on eq.doc_no=m.refdocno where m.doc_no="+docno+"";
			    	    ResultSet rs22=cpstmt.executeQuery(sqltst); 
			    	   while(rs22.next()){
			    		   docnoss+=rs22.getString("doc_no")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs22.getString("doc_no")+") and a.dtype in ('SQOT') and a.brhid="+rs22.getString("qotbrhid")+" ";
			    		   docnoss+=rs22.getString("enqno")+",";
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs22.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs22.getString("enqbrhid")+" ";
			    		   docnoss+=rs22.getString("cldocno");             
			    		   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   if(rs22.getString("clientid").equalsIgnoreCase("1")){
			    			   dtypess+="'CRM'";
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs22.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";
			    		   }else{
			    			   dtypess+="'PPC'";  
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs22.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
			    		   }
			    		     
			           }
			       }else if(dtype.equalsIgnoreCase("ENQ")){
			    	   sqltst="select m.cldocno,'0' doc_no,m.clientid,m.doc_no enqno,m.brhid enqbrhid from in_enqm m  where m.voc_no="+docno+"";
			    	    ResultSet rs22=cpstmt.executeQuery(sqltst);         
			    	   while(rs22.next()){
			    		   docnoss+=rs22.getString("doc_no")+",";
			    		   cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs22.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs22.getString("enqbrhid")+" ";
			    		   docnoss+=rs22.getString("enqno")+",";
			    		   docnoss+=rs22.getString("cldocno");            
			    		   dtypess+="'SQOT'"+",";
			    		   dtypess+="'ENQ'"+",";
			    		   if(rs22.getString("clientid").equalsIgnoreCase("1")){       
			    			   dtypess+="'CRM'";
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs22.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";
			    		   }else{
			    			   dtypess+="'PPC'"; 
			    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs22.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
			    		   }
			    		     
			           }
			       }else{
			    	   System.out.println("cpsql--->>>000");   
			       }*/  
			       //System.out.println("cpsql--->>>"+cpsql);    
			       if((!(docno.equalsIgnoreCase("") || dtype.equalsIgnoreCase(""))) || (!(docnoss.equalsIgnoreCase("") || dtypess.equalsIgnoreCase("")))){  
			    	  // cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+docnoss+") and a.dtype in ("+dtypess+") "+sqls+" order by sr_no desc"; 
			    	 //  System.out.println("cpsql--->>>"+cpsql);
				       ResultSet resultSet = cpstmt.executeQuery(cpsql);
				       RESULTDATA=clcom.convertToJSON(resultSet);                 
			       }
			       cpstmt.close();  
			       conn.close();
			     }
			     catch(Exception e){
			      e.printStackTrace();
			      conn.close();
			     }
			    finally
			    {
			    	conn.close();
			    }
			     
	           return RESULTDATA;
	       }
	public  JSONArray addressbook(HttpSession session,String name,String dtype,String cldocno,String id) throws SQLException {
		//System.out.println("inside addressbook");       
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;                  
		}       
        java.sql.Date sqlStartDate=null;
         String sqltest="",sqltest2="";    
         if(!(dtype.equalsIgnoreCase(""))){
         sqltest2=sqltest2+" and ac.dtype like '%"+dtype+"%'";  
        }
        if(!(name.equalsIgnoreCase(""))){      
         sqltest2=sqltest2+"  and ac.refname like '%"+name+"%'";    
        }
        if(!(cldocno.equalsIgnoreCase(""))){ 
        	sqltest=sqltest+"  and ac.cldocno='"+cldocno+"'";        
           }
        Connection conn =null;
        Statement stmt = null;
        ResultSet resultSet =null;  
        String sql="";   
       try {
        conn = ClsConnection.getMyConnection();     
        stmt = conn.createStatement ();
		           
               if(dtype.equalsIgnoreCase("crm") || dtype.equalsIgnoreCase("vnd")){
		    	   sql="select coalesce(ac.mail1,ac.mail2) as e_mail,ac.dtype,ac.refname as name,cn.cperson,act.ay_name activity from my_acbook ac left join my_crmcontact cn on (cn.cldocno=ac.cldocno and cn.dtype='"+dtype+"') left join my_activity act on act.doc_no=cn.actvty_id where 1=1 "+sqltest2+" "+sqltest+""; 
		       }else if(dtype.equalsIgnoreCase("user")){          
		    	   sql="select email as e_mail,'USER' as dtype,user_name as name,'' cperson,'' activity from my_user";
		       }else{
		    	   sql="select e_mail,dtype,name,cperson,activity from (select coalesce(ac.mail1,ac.mail2) as e_mail,ac.dtype,ac.refname as name,cn.cperson,act.ay_name activity from my_acbook ac left join my_crmcontact cn on (cn.cldocno=ac.cldocno) left join my_activity act on act.doc_no=cn.actvty_id where 1=1 "+sqltest+" union all select email as e_mail,'USER' as dtype,user_name as name,'' cperson,'' activity from my_user) as a ";
		       }     
        //System.out.println("sql------>>>"+sql);   
        resultSet = stmt.executeQuery(sql);
        RESULTDATA=ClsCommon.convertToJSON(resultSet);   
       stmt.close();
       conn.close();
     }
     catch(Exception e){
      e.printStackTrace();   
     }finally {  
	        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
	        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}          //Written By sudhi    
	        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}             
	    }
           return RESULTDATA;
       }
}
