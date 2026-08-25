package com.dashboard.vehiclepurchase.purchaselist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsPurchaseListDAO 
{
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray reqlistsearch(String branch,String fromdate,String todate,String status) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  m.status=3 and rq.clstatus=0 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and m.status=3 and rq.clstatus=0  and p.rno is null ";
     		 
  		
      	}
  	
      	else if(status.equalsIgnoreCase("CLS"))
  	    {
  		
      		sqltest+=" and  rq.clstatus=1 "; 
  	    }
    	
     	else if(status.equalsIgnoreCase("POD"))
  	    {
  		
      		sqltest+=" and  p.rtype='VPR' "; 
  	    }
     	else if(status.equalsIgnoreCase("PUH"))
  	    {
  		
      		sqltest+=" and  pu.rtype='VPO' and o.pqty!=0 "; 
  	    }
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  
		
            		/*String sql="select m.doc_no,m.voc_no, m.date, m.type, m.expdeldt,rq.spec, round(rq.qty) qty,vb.brand_name brand,vm.vtype model,vc.color color "
            				+ " from gl_vprm m  left join gl_vprd rq  on m.doc_no=rq.rdocno left join gl_vehbrand vb on vb.doc_no=rq.BRDID  "
            				+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid  "
            				+ "    left join gl_vpom p on p.rtype='VPR' and p.rno=m.doc_no "
            				+ " where 1=1 and m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;*/
	
			/*
				String sql="select convert(if(coalesce(round(dd.qty),0)=0,'',round(dd.qty)),char(50)) orderqty,convert(if(coalesce(dd.pqty,0)=0,'',dd.pqty),char(50)) purqty, "
						+ "	convert(if(if(coalesce(dd.pqty,0)=0,'',dd.pqty)>0,if(coalesce(dd.qty,0)=0,'',dd.qty)-if(coalesce(dd.pqty,0)=0,'',dd.pqty),''),char(50)) remqty, "
						+ "	m.doc_no,m.voc_no, m.date, m.type, m.expdeldt,rq.spec,round(rq.qty) qty,vb.brand_name brand,vm.vtype model,vc.color color "
						+ " from gl_vprm m  left join gl_vprd rq  on m.doc_no=rq.rdocno left join gl_vehbrand vb on vb.doc_no=rq.brdid  "
						+ "	left join gl_vehmodel vm on vm.doc_no=rq.modid left join my_color vc on vc.doc_no=rq.clrid  "
						+ " left join gl_vpom p on p.rtype='VPR' and p.rno=m.doc_no left join gl_vpod dd on dd.rdocno=p.doc_no  "
						+ " left join gl_vpurm pu on pu.rno=p.doc_no and pu.rtype='VPO' where 1=1 and m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"' "
						+ " and  m.status=3 and rq.clstatus=0 "+sqltest+" group by rq.rowno ";*/
				 //puqty 	 
				
				String sql="select round(rq.qty) qty,convert(if(coalesce(rq.pqty,0)=0,'',round(rq.pqty)),char(50)) orderqty,  "
						+ " convert(if(coalesce(o.pqty,0)=0 ,'',o.pqty),char(50)) puqty,if(coalesce(rq.pqty,0)=0,'',round(rq.pqty))-if(coalesce(o.pqty,0)=0 ,'',round(o.pqty)) rempuqty, "
						+ "  convert(if(if(coalesce(rq.pqty,0)=0,'',rq.pqty)>0,round(rq.qty)-if(coalesce(rq.pqty,0)=0,'',round(rq.pqty)),''),char(50)) remqty,"
						+ "  m.doc_no,m.voc_no, m.date, m.type, m.expdeldt,rq.spec,round(rq.qty) qty,vb.brand_name brand,vm.vtype model,vc.color color  "
						+ "   from gl_vprm m  left join gl_vprd rq  on m.doc_no=rq.rdocno left join gl_vehbrand vb on vb.doc_no=rq.brdid  "
						+ " left join gl_vehmodel vm on vm.doc_no=rq.modid left join my_color vc on vc.doc_no=rq.clrid  "
						+ " left join gl_vpom p on p.rtype='VPR' and p.rno=m.doc_no left join gl_vpurm pu on pu.rno=p.doc_no and pu.rtype='VPO'  "
						+ " left join gl_vpod o on rq.rowno=o.reqrowno  where 1=1 and m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' and  m.status=3 and rq.clstatus=0 "+sqltest+" ";
          
            	//System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray orderlistsearch(String branch,String fromdate,String todate,String status) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and vo.brhid='"+branch+"'";
 		}	
     	Connection conn = null;
     	
	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  vo.status=3 and rq.clstatus=0 ";	
    	}
     
     	
     	if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and  vo.status=3 and rq.clstatus=0 and p.rno is null ";
     		 
  		
      	}
  	
      	else if(status.equalsIgnoreCase("CLS"))
  	    {
  		
      		sqltest+=" and  rq.clstatus=1  "; 
  	    }
	
      	else if(status.equalsIgnoreCase("PUH"))
  	    {
  		
      		sqltest+=" and  p.rtype='VPO' and rq.pqty!=0 "; 
  	    }
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
            /*		String sql="select p.rno,vo.voc_no,vo.doc_no,vo.date, if(vo.rtype='DIR','Direct','Request') type,vo.expdeldt,h.description,h.account, "
            				+ "round(rq.qty) qty,round(rq.price,2) price, round(rq.total,2) total, vb.brand_name brand,vm.vtype model,vc.color color  "
            				+ "from gl_vpom vo  left  join my_head h on h.doc_no=vo.venid left join gl_vprm ss on ss.doc_no=vo.rno  "
            				+ " left join gl_vpod rq on rq.rdocno=vo.doc_no left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
            				+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid  "
            				+ " left join gl_vpurm p on p.rtype='VPO' and p.rno=vo.doc_no " 
            				+ " where 1=1  and vo.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;*/ 
				
				String sql="select round(rq.qty) odqty,convert(if(round(rq.pqty)=0,'',round(rq.pqty)),char(50))  pqty, round(rq.qty)-round(rq.pqty) remqty, "
						+ " p.rno,vo.voc_no,vo.doc_no,vo.date, if(vo.rtype='DIR','Direct','Request') type, "
						+ "vo.expdeldt,h.description,h.account, round(rq.qty) qty,round(rq.price,2) price, round(rq.total,2) total, "
						+ "	 vb.brand_name brand,vm.vtype model,vc.color color  from gl_vpom vo  left  join my_head h on h.doc_no=vo.venid  "
						+ " left join gl_vprm ss on ss.doc_no=vo.rno   left join gl_vpod rq on rq.rdocno=vo.doc_no left join gl_vehbrand vb  "
						+ " on vb.doc_no=rq.BRDID  left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid  "
						+ " left join (SELECT rtype,rno FROM gl_vpurm GROUP BY rtype,rno) p on p.rtype='VPO' and p.rno=vo.doc_no  where 1=1  and vo.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "
						+ "    and  vo.status=3 and rq.clstatus=0 "+sqltest;
            		
            	//	System.out.println("============="+sql);
            		
          
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	
	public JSONArray reqclosesearch(String branch,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and m.brhid='"+branch+"'";
 		}	
 
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();  
		
            		String sql="select  rq.rowno srno,'Edit' btnsave, m.brhid,m.doc_no,m.voc_no, m.date, m.type, m.expdeldt,rq.spec, round(rq.qty) qty,vb.brand_name brand,vm.vtype model,vc.color color "
            				+ " from gl_vprm m  left join gl_vprd rq  on m.doc_no=rq.rdocno left join gl_vehbrand vb on vb.doc_no=rq.BRDID  "
            				+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid  "
            				+ "    left join gl_vpom p on p.rtype='VPR' and p.rno=m.doc_no  "
            				+ " where m.status=3 and p.rno is null AND  rq.clstatus=0 and m.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
          
            //	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	public JSONArray orderclosesearch(String branch,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and vo.brhid='"+branch+"'";
 		}	
     	Connection conn = null;
     	
    /*	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  vo.status=3 and rq.clstatus=0 ";	
    	}
     	*/
     	
     /*	if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and p.rno is null ";
     		 
  		
      	}
  	
      	else if(status.equalsIgnoreCase("CLS"))
  	    {
  		
      		sqltest+=" and vo.status=6 "; 
  	    }
	
     	*/
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
            		/*String sql="select rq.rowno srno,vo.brhid,'Edit' btnsave,p.rno,vo.voc_no,vo.doc_no,vo.date, if(vo.rtype='DIR','Direct','Request') type,vo.expdeldt,h.description,h.account, "
            				+ "round(rq.qty) qty,round(rq.price,2) price, round(rq.total,2) total, vb.brand_name brand,vm.vtype model,vc.color color  "
            				+ "from gl_vpom vo  left  join my_head h on h.doc_no=vo.venid left join gl_vprm ss on ss.doc_no=vo.rno  "
            				+ " left join gl_vpod rq on rq.rdocno=vo.doc_no left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
            				+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid  "
            				+ " left join gl_vpurm p on p.rtype='VPO' and p.rno=vo.doc_no "
            				+ " where  p.rno is null and vo.status=3  and  rq.clstatus=0 and vo.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
            		*/
            		String sql="select rq.rowno srno,vo.brhid,'Edit' btnsave,p.rno,vo.voc_no,vo.doc_no,vo.date, if(vo.rtype='DIR','Direct','Request') type,vo.expdeldt,h.description,h.account, "
            				+ "round(rq.qty) qty,round(rq.price,2) price, round(rq.total,2) total, vb.brand_name brand,vm.vtype model,vc.color color  "
            				+ "from gl_vpom vo  left  join my_head h on h.doc_no=vo.venid left join gl_vprm ss on ss.doc_no=vo.rno  "
            				+ " left join gl_vpod rq on rq.rdocno=vo.doc_no left join gl_vehbrand vb on vb.doc_no=rq.BRDID "
            				+ " left join gl_vehmodel vm on vm.doc_no=rq.MODID left join my_color vc on vc.doc_no=rq.clrid  "
            				+ " left join gl_vpurm p on p.rtype='VPO' and p.rno=vo.doc_no "
            				+ " where  p.rno is null and vo.status=3  and  rq.clstatus=0 and vo.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
            		
        		System.out.println("======sql======="+sql);
            		
          
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
	
	
	
}
