package com.dashboard.realestate.agentcommissionlist;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;   
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

public class ClsAgentCommissionListAction {    
	ClsCommon cmn=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();  
	private String url;
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String group=request.getParameter("group");    
		String agentdocno=request.getParameter("agent"); 
		String fromdate=request.getParameter("fromdate");  
		String todate=request.getParameter("todate");       
		String imgpath="",comp="",tel="",fax="",cmpname="",printedby="",sqltest="";       
		int comacno=0,comexacno=0;
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
				java.sql.Date sqltodate = null;
			    java.sql.Date sqlfromdate = null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			     		sqltodate=cmn.changeStringtoSqlDate(todate);
			        }
					if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate=cmn.changeStringtoSqlDate(fromdate);    
			        } 
					if(!(agentdocno.equalsIgnoreCase("undefined")) && !(agentdocno.equalsIgnoreCase(""))){
						sqltest=" and s.doc_no='"+agentdocno+"'";   
					}
					String sqlaccount="select (select coalesce(acno,0) acno from my_account where codeno='COMMISSION ACCOUNT') comacno,(select coalesce(acno,0) acno from my_account where codeno='COMEXP') comexacno";   
					ResultSet rsac = stmt.executeQuery(sqlaccount);    
					while(rsac.next()){
						comacno=rsac.getInt("comacno");
						comexacno=rsac.getInt("comexacno");
					} 
					String mainsql="";
					/*if(group.equalsIgnoreCase("T")){   
						 mainsql="select w.* from(select @i:=@i+1 srno,b.*,format(agg.totalamt,2) totalamt from(select invno doc, dtype type, date_format(date,'%d.%m.%Y') date, tenant, propname property, cnt shared, format(total,2) total, format(commpercent,2) per, format(commval,2) agentval, agent salesman,doc_no from(select inv.voc_no invno,'PRIV' dtype, inv.date,coalesce(a.refname,'') tenant,cast(coalesce(inv.property,'') as char(200)) propname,cnt,coalesce(d.total,0) total,commpercent,coalesce(pg.commvalue,0) commval,s.acc_no acno,s.team agent,s.doc_no from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno='"+comacno+"' left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where pg.confirm=1 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' union all select m.voc_no,'TNC' dtype,m.date,a.refname,p.accname,(ta1.cnt) person,d.amount,(cper) per,ta.camount agentcomm,s.acc_no acno,s.team agent,s.doc_no from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where m.date<='"+sqltodate+"' and m.date>='"+sqlfromdate+"') z order by z.agent)b left join (select sum(commval) totalamt,agent,doc_no from (select coalesce(pg.commvalue,0) commval,s.team agent,s.doc_no from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno='"+comacno+"' left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where pg.confirm=1 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' union all select ta.camount agentcomm,s.team agent,s.doc_no from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where m.date<='"+sqltodate+"' and m.date>='"+sqlfromdate+"')d group by agent) agg on agg.doc_no=b.doc_no,(select @i:=0)c order by b.salesman)w where 1=1 "+sqltest+"";
					}else{
						 mainsql="select w.* from(select @i:=@i+1 srno,b.*,format(agg.totalamt,2) totalamt from(select invno doc, dtype type, date_format(date,'%d.%m.%Y') date, tenant, propname property, cnt shared, format(total,2) total, format(commpercent,2) per, format(commval,2) agentval, agent salesman,doc_no from(select inv.voc_no invno,'PRIV' dtype, inv.date,coalesce(a.refname,'') tenant,cast(coalesce(inv.property,'') as char(200)) propname,cnt,coalesce(d.total,0) total,commpercent,coalesce(pg.commvalue,0) commval,s.acc_no acno,s.sal_name agent,s.doc_no from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno='"+comacno+"' left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where pg.confirm=1 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' union all select m.voc_no,'TNC' dtype,m.date,a.refname,p.accname,(ta1.cnt) person,d.amount,(cper) per,ta.camount agentcomm,s.acc_no acno,s.sal_name agent,s.doc_no from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where m.date<='"+sqltodate+"' and m.date>='"+sqlfromdate+"') z order by z.agent)b left join (select sum(commval) totalamt,agent,doc_no from (select coalesce(pg.commvalue,0) commval,s.sal_name agent,s.doc_no from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno='"+comacno+"' left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where pg.confirm=1 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' union all select ta.camount agentcomm,s.sal_name agent,s.doc_no from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where m.date<='"+sqltodate+"' and m.date>='"+sqlfromdate+"')d group by agent) agg on agg.doc_no=b.doc_no,(select @i:=0)c order by b.salesman)w where 1=1 "+sqltest+"";
					}*/
					//System.out.println("==="+group+"====");
					/*if(group.equalsIgnoreCase("T")){   
						mainsql="select w.* from( select @i:=@i+1  srno, invno doc, reftype type,date_format(date,'%d.%m.%Y') date, tenant, propname property,cnt shared,format(netamount,2) total,format(commpercent,2) per,format(commval,2) agentval,agent salesman, salid doc_no,format(netamount,2) totalamt from(select s.doc_no salid,inv.doc_no,inv.brhid,inv.voc_no invno,'PRIV' reftype, inv.date,coalesce(a.refname,'') tenant,cast(coalesce(inv.property,'') as char(200)) propname,cnt,coalesce(d.total,0) total,commpercent,coalesce(inv.rentsalevalue,0) saleval,coalesce(inv.netamount,0) netamount,coalesce(pg.commvalue,0) commval,coalesce(pg.claimval,0) claimamt,s.acc_no acno,s.team agent,if(astatus=1,'Claimed',if(astatus=2,'Approve','')) status from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno='"+comacno+"' left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where coalesce(pg.commvalue,0)!=0 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' and inv.status=3 "+sqltest+" union all select s.doc_no salid,m.doc_no,m.brhid,m.voc_no,'TNC' reftype,m.date,a.refname,p.accname,(ta1.cnt) person,d.amount,(cper) per,0,0,ta.camount agentcomm,0,s.acc_no acno,s.team agent,'' from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where status=3 and date<='"+sqltodate+"' and date>='"+sqlfromdate+"' and dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where  m.status=3 "+sqltest+" group by agent) a,(select @i:=0)c )w ";
					}if(group.equalsIgnoreCase("A")){   
						mainsql="select w.* from( select @i:=@i+1  srno, invno doc, reftype type,date_format(date,'%d.%m.%Y') date, tenant, propname property,cnt shared,format(netamount,2) total,format(commpercent,2) per,format(commval,2) agentval,agent salesman, salid doc_no,format(netamount,2) totalamt from(select s.doc_no salid,inv.doc_no,inv.brhid,inv.voc_no invno,'PRIV' reftype, inv.date,coalesce(a.refname,'') tenant,cast(coalesce(inv.property,'') as char(200)) propname,cnt,coalesce(d.total,0) total,commpercent,coalesce(inv.rentsalevalue,0) saleval,coalesce(inv.netamount,0) netamount,coalesce(pg.commvalue,0) commval,coalesce(pg.claimval,0) claimamt,s.acc_no acno,s.sal_name agent,if(astatus=1,'Claimed',if(astatus=2,'Approve','')) status from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno='"+comacno+"' left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where coalesce(pg.commvalue,0)!=0 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' and inv.status=3 "+sqltest+" union all select s.doc_no salid,m.doc_no,m.brhid,m.voc_no,'TNC' reftype,m.date,a.refname,p.accname,(ta1.cnt) person,d.amount,(cper) per,0,0,ta.camount agentcomm,0,s.acc_no acno,s.sal_name agent,'' from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where status=3 and date<='"+sqltodate+"' and date>='"+sqlfromdate+"' and dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where  m.status=3 "+sqltest+" group by agent) a,(select @i:=0)c )w ";
					}
					else{
					*/	
					mainsql="select w.* from( select @i:=@i+1  srno, invno doc, reftype type,date_format(date,'%d.%m.%Y') date, tenant, propname property,cnt shared,format(netamount,2) total,format(commpercent,2) per,round(commval,2) agentval,agent salesman, salid doc_no,format(netamount,2) totalamt,format(saleval,2) saleval,format(halfper,2) halfper from(select s.doc_no salid,inv.doc_no,inv.brhid,inv.voc_no invno,'PRIV' reftype, inv.date,coalesce(a.refname,'') tenant,cast(coalesce(inv.property,'') as char(200)) propname,cnt,coalesce(d.total,0) total,commpercent,coalesce(d.nettotal,0) saleval,(coalesce(d.nettotal,0)*50)/100 halfper,coalesce(inv.netamount,0) netamount,coalesce(pg.commvalue,0) commval,coalesce(pg.claimval,0) claimamt,s.acc_no acno,s.sal_name agent,if(astatus=1,'Claimed',if(astatus=2,'Approve','')) status from rl_prinvm inv left join rl_prinvagent pg on pg.rdocno=inv.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=pg.sal_id left join my_acbook a on a.acno=inv.acno and a.dtype='crm' left join rl_prinvd d on inv.doc_no=d.rdocno and d.acno in (1143, 5606 , 5605 , 5381, 5609) left join (select count(*) cnt,rdocno from rl_prinvagent group by rdocno) ta1 on ta1.rdocno=inv.doc_no where coalesce(pg.commvalue,0)!=0 and inv.date<='"+sqltodate+"' and inv.date>='"+sqlfromdate+"' and inv.status=3 "+sqltest+" union all select s.doc_no salid,m.doc_no,m.brhid,m.voc_no,'TNC' reftype,m.date,a.refname,p.accname,(ta1.cnt) person,d.amount,(cper) per,0 saleval,0 halfper,0,ta.camount agentcomm,0,s.acc_no acno,s.sal_name agent,'' from rl_tncm m inner join (select doc_no,sum(if(acno='"+comacno+"',dramount*id,0)) amount,sum(if(acno='"+comexacno+"',dramount*id,0)) agentcomm from my_jvtran where status=3 and date<='"+sqltodate+"' and date>='"+sqlfromdate+"' and dtype='tnc' group by doc_no having coalesce(agentcomm,0)!=0) d on m.doc_no=d.doc_no left join rl_propertymaster p on m.prtype=p.doc_no left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' left join rl_tncagent ta on ta.rdocno=m.doc_no left join (select count(*) cnt,rdocno from rl_tncagent group by rdocno) ta1 on ta1.rdocno=m.doc_no left join my_salesman s on sal_type='sla' and s.doc_no=ta.sal_id where  m.status=3 "+sqltest+" order by agent) a,(select @i:=0)c )w ";
					// }
					//System.out.println("mainsql--->>>"+mainsql);                 
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123);      
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");    
					}
					String sql="select company,address,tel,fax from  my_comp group by doc_no limit 1";   
					//System.out.println("print main--->>>"+sql); 
					ResultSet resultSet = stmt.executeQuery(sql);         
					while(resultSet.next()){
						comp=resultSet.getString("company");
						//tel=resultSet.getString("tel");
						//fax=resultSet.getString("fax");
						//address=resultSet.getString("address");
					}
					
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");  
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        param.put("comp",comp);   
			        param.put("mainsql",mainsql);
			        
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/realestate/agentcommissionlist/salesagentcommissionreport.jrxml"));  
  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	                generateReportPDF(response, param, jasperReport, conn);        
	               } catch (Exception e) {      

	                 e.printStackTrace();
	             }
	            	 
	            finally{
			conn.close();
		}	  	
	return "print";   
	} 
	
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
 		  byte[] bytes = null;
         bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
           resp.reset();
         resp.resetBuffer();
         
         resp.setContentType("application/pdf");  
         resp.setContentLength(bytes.length);
         ServletOutputStream ouputStream = resp.getOutputStream();
         ouputStream.write(bytes, 0, bytes.length);
            
         ouputStream.flush();
         ouputStream.close();
     }
}
