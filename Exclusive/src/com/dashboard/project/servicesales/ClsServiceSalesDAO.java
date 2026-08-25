package com.dashboard.project.servicesales;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


 

public class ClsServiceSalesDAO{

	ClsConnection ClsConnection=new ClsConnection();
 
	 
 
	ClsCommon ClsCommon=new ClsCommon();
	public   JSONArray listsearch(String barchval,String fromdate,String todate,String acno) throws SQLException {
     	Connection conn =null;
        JSONArray RESULTDATA=new JSONArray();
		try {

        
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
     	
     	String sqltest="",sqljoin="";
     	
     	if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
		 
			 
				sqltest=sqltest+" and m.brhid='"+barchval+"'";
		 
			
			
			
			
			
			}
		
     	if((sqlfromdate!=null)&&(sqltodate!=null)){
            sqltest=sqltest+" and m.date between '"+sqlfromdate+"' and  '"+sqltodate+"' ";
        }
     	if(!(acno.equalsIgnoreCase(null)) && !(acno.equalsIgnoreCase("")) && !(acno.equalsIgnoreCase("undefined")) && !(acno.equalsIgnoreCase("NaN") && !(acno.equalsIgnoreCase("NA")))){
            sqltest=sqltest+" and m.acno='"+acno+"' ";
           
             }
           String sqlsal="select m.brhid,coalesce(ac.tax,0) tax,m.doc_no,m.date date,m.voc_no voc_no,br.branchname,h.description client,"
	              +" round(m.taxamount,2) taxvalue,round(m.invvalue,2) nettotal,m.rdtype reftype,convert(if(m.rdtype='DLY',dlym.voc_no,''),char(100)) refno,"
	              +" case when m.ftype=1 then 'CASH' when m.ftype=2 then 'SHOWROOM' when m.ftype=3 then 'CREDIT' end as ftype,"
	              +" case when m.costtype=1 then c.description when m.costtype in(3,4) then convert(concat(co.ref_type,' ',co.refdocno),char(100))"
	              +" when m.costtype in (5) then convert(concat(cs.contracttype,' ',cs.contractno),char(100))  end as 'projectname',"
	              +" s.sal_name salesman,m.lpono,round(m.nettotal,2) total,round(m.discount,2) discount,ar.area,m.remarks"
	              +" from my_cutinvm m inner join my_cutinvd d on m.doc_no=d.rdocno left join my_head h on h.doc_no=m.acno"
	              +" left join my_salm s on m.sal_id=s.doc_no left join my_dlym dlym on dlym.doc_no=m.rrefno  "
	              + "   left join my_ccentre c on c.costcode=m.costcode and m.costtype=1"
	              +" left join cm_srvcontrm co on co.tr_no=m.costcode and m.costtype in(3,4)"
	              +" left join cm_cuscallm cs on cs.tr_no=m.costcode and m.costtype=5 left join my_brch br on m.brhid=br.branch "
	              +" left join my_acbook ac on ac.acno=m.acno left join my_area ar on ac.area_id=ar.doc_no"
	              +sqljoin+" where m.status=3"+sqltest+"  and m.clstatus=0  group by m.doc_no";
	
           
           //System.out.println("===sqlsal=="+sqlsal);
			conn=ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();
		ResultSet resultSet = stmt.executeQuery(sqlsal);
		
		RESULTDATA=ClsCommon.convertToJSON(resultSet);
		
		stmt.close();
		conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
     	return RESULTDATA;
	}
	
public JSONArray clientAccountsDetails(HttpSession session,String atype,String accountno,String accountname,String mobile,String check) throws SQLException {
        
		JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null; 
       
        
       
	     try {
		       conn = ClsConnection.getMyConnection();
		       Statement stmt = conn.createStatement();
	
		       Enumeration<String> Enumeration = session.getAttributeNames();
	           int a=0;
	           while(Enumeration.hasMoreElements()){
	            if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	             a=1;
	            }
	           }
	           if(a==0){
	              return RESULTDATA;
	            }
	           String branch=session.getAttribute("BRANCHID").toString();
	           String company = session.getAttribute("COMPANYID").toString();
	           
	           java.sql.Date sqlDate=null;
	           
	           System.out.println("===atype====="+atype);
	           
	           System.out.println("===check====="+check);
	           
	           if(check.equalsIgnoreCase("1")){
	        	   
	            
	      

	            String sqltest="";
		        String sql="";
		        
		        String code= "";
				
				if(atype.equalsIgnoreCase("AP")){
					code="VND";
				}
				else if(atype.equalsIgnoreCase("AR")){
					code="CRM";
				}
		        
		        if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
		            sqltest=sqltest+" and t.account like '%"+accountno+"%'";
		        }
		        if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and t.description like '%"+accountname+"%'";
		        }
		        if(!(mobile.equalsIgnoreCase("0")) && !(mobile.equalsIgnoreCase(""))){
		         sqltest=sqltest+" and a1.per_mob like '%"+mobile+"%'";
		        }
		        
	 
		        
  
		        if(atype.equalsIgnoreCase("GL")){
	        	
			        sql="select t.doc_no,t.account,t.description,t.curid,c.code currency,c.type,round(cb.rate,2) rate from my_head t left join my_curr c "
							+ "on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,"
							+ "cr.frmDate from my_curbook cr where coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo "
							+ "on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where t.atype='"+atype+"' and t.m_s=0"+sqltest;
		        
		        }else{
		        
			        sql= "select t.doc_no,t.account,t.description,t.curid,c.code currency,a.cldocno,c.type,round(cb.rate,2) rate,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_head t inner join my_acbook a on t.cldocno=a.cldocno and "
		        		+ "a.dtype='"+code+"' and t.atype='"+atype+"' left join my_curr c on t.curid=c.doc_no left join my_curbook cb on t.curid=cb.curid inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate "
		        		+ "from my_curbook cr where  coalesce(toDate,curdate())>=curdate() and frmDate<=curdate() group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where a.active=1 and t.m_s=0"+sqltest;
		        
		        }
	 
		        
		        System.out.println("=======sql="+sql);
		        
		       ResultSet resultSet = stmt.executeQuery(sql);
		       RESULTDATA=ClsCommon.convertToJSON(resultSet);
	           
		       stmt.close();
		       conn.close();
		       }
		     stmt.close();
			 conn.close();   
	     }
	     catch(Exception e){
		      e.printStackTrace();
		      conn.close();
	     }finally{
			  conn.close();
			}
	       return RESULTDATA;
	  }


}
