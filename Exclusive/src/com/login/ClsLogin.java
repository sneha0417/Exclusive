package com.login;

import java.io.IOException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsLogin  extends ActionSupport {
	
	ClsConnection ClsConnection=new ClsConnection();

	private  String userid;
	private  String password;
	private  String company;
	private  String msg;
	
    public  String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public  String getUserid() {
		return userid;
	}
	private  Map<String, Object> sessionMap;
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public  String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}

	int roleid=0;

	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	
	@SuppressWarnings("unchecked")
	public String execute() throws SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();  
		HttpSession session=request.getSession(); 
		
		String userName=getUserid();
		String passWord=getPassword();
		ClsEncrypt ClsEncrypt=new ClsEncrypt();
		Connection conn = null;
		
		try{
				/*if(userName.equals("")||passWord.equals("")){
				       setMsg("<center><b>User Name and Password cannot be blank.</b><br/>Please try again.</center>");
				       return "fail";
				}*/
			System.out.println("===="+passWord);
			passWord=ClsEncrypt.getInstance().encrypt(passWord);
			System.out.println("===="+passWord);
			
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();
				
				/*Trial Period*/
				java.sql.Date trailPeriod=null;int projectStatus=0,trialExpiry=0;
				Statement stmtCmpTrial = conn.createStatement();
				
				String strCmpTrial = "select projectstatus,era,if(projectstatus=1,DATEDIFF(era,CURDATE()),DAY(Last_DAY(CURDATE()))) trailExpiry from my_comp where comp_id='"+getCompany()+"'";
				ResultSet rsCmpTrial = stmtCmpTrial.executeQuery(strCmpTrial);
				if(rsCmpTrial.next ()) {
					projectStatus=rsCmpTrial.getInt("projectstatus");
					trailPeriod=rsCmpTrial.getDate("era");
					trialExpiry=rsCmpTrial.getInt("trailExpiry");
				}
				stmtCmpTrial.close();
				
				if(projectStatus==1 && trialExpiry<0) {
					setMsg("<center><b>Licence Expired !!!</b></center>");
					conn.close();
					return "fail";
				}
				
				if(projectStatus==1 && trailPeriod==null){
					String strsqlTrial = "update my_comp set era=DATE_ADD(CURDATE(), INTERVAL 7 DAY) where doc_no='"+getCompany()+"'";
					stmt.execute(strsqlTrial);
				}
				/*Trial Period Ends*/
				
				int userid;
				if(checkAdminGate(request,userName,passWord)) {
					userid=999;
					setRoleid(1);
					session.setAttribute("ROLEID", getRoleid());
					session.setAttribute("USERID", userid);
					session.setAttribute("USERNAME", userName);
					
				}else {
					String strSql = "select * from my_user where user_id='"+userName+"' and pass='"+passWord+"' and block=0";
					//System.out.println("=== "+strSql);
					ResultSet rs = stmt.executeQuery(strSql);
					if(rs.next ()) {
						userid=rs.getInt("doc_no");
						setRoleid(rs.getInt("role_id"));
						session.setAttribute("ROLEID", getRoleid());
						session.setAttribute("USERID", userid);
						session.setAttribute("USERNAME", userName);
					}
					else{
						setMsg("<center><b>User Name or Password is incorrect.</b><br/>Please try again.</center>");
						conn.close();
						return "fail";
					}
				}
				
				String ip = getRemortIP(request);
				String mac = getMACAddress(ip);
				
				System.out.println("ip ="+ip);
				System.out.println("mac ="+mac);
				
				Map<String, String> env = System.getenv();
			    String xuser=env.get("USERNAME");
			    String xcomp=env.get("COMPUTERNAME");
				
				String macConfig="0";
				String strConfig="select method from gl_config where field_nme='MACSECURITY'";
				ResultSet rsConfig = stmt.executeQuery(strConfig);
				if(rsConfig.next ()) {
					macConfig=rsConfig.getString("method");
				}
				
				if(macConfig.equalsIgnoreCase("1")){
					
					String strMacSql = "select user_id, user, mac_address from gc_usermac where status=3 and approval=1 and mac_address='"+mac+"'";
					ResultSet rsMAC = stmt.executeQuery(strMacSql);
					if(rsMAC.next ()) {
						
					}

					else{
						setMsg("<center><b>No Privilage to Login from this System</b><br/>Please Contact ADMIN !!!</center>");
						
						String strsql = "insert into gc_usermac (user_id, user, WIN_USER,win_cmp, mac_address, status) values ('"+userid+"','"+userName+"','"+xuser+"','"+xcomp+"','"+mac+"', 3)";
						System.out.println("strsql ="+strsql);
						stmt.execute(strsql);
						
						conn.close();
						return "fail";
					}
					
				}
				
			    if(userid>0){
				
					/*String strsql = "insert into gc_userlog (USER,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ('"+userName+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
					stmt.execute(strsql);
					*/
					
			    	String strsql = "insert into gc_userlog (USER,WIN_USER,win_cmp,DATE_IN) values ('"+userName+"','"+xuser+"','"+xcomp+"',now())";
					stmt.execute(strsql);
					
					
			    	stmt.close();
					Statement stmtLog = conn.createStatement();
					String strSqlLog = "SELECT DATE_FORMAT((max(DATE_IN)),'%d-%m-%Y %H:%i:%s') DATE_IN FROM gc_userlog WHERE USER='"+userName+"'";
					ResultSet resultSet = stmtLog.executeQuery(strSqlLog);
					if(resultSet.next ()) {
						session.setAttribute("LOGGEDIN", resultSet.getString("DATE_IN"));	
					}
				}
				
				Statement stmtCmp = conn.createStatement();
				String strCmp = "select company,comp_refid,COALESCE(if(projectstatus=1 and DATEDIFF(era,CURDATE())=0,'Licence Expires Today',if(projectstatus=1 and DATEDIFF(era,CURDATE())>0,CONCAT('Licence Expires in ',DATEDIFF(era,CURDATE()),' Day(s)'),'')),'') era from my_comp where comp_id='"+getCompany()+"'";
				ResultSet rsCmp = stmtCmp.executeQuery (strCmp);
				if(rsCmp.next ()) {
					rsCmp.getString("company");
					session.setAttribute("COMPANYNAME", rsCmp.getString("company"));
					session.setAttribute("COMPANYREFID", rsCmp.getString("comp_refid"));
					session.setAttribute("COMPANYID", getCompany());
					session.setAttribute("ERA", rsCmp.getString("era"));
				}
				stmtCmp.close();
				
				 Statement stmtBrch = conn.createStatement();
				 /*   String strBrch = "select branch,curid from my_brch where cmpid='"+getCompany()+"' and mainbranch=1";*/
				    String strBrch = "select b.branchname,b.mclose,b.doc_no brhid,(select code from my_curr where doc_no=b.curId) as curr,(select type from my_curr where doc_no=b.curId) as type,b.curId "
							 +" from my_brch b  left join my_user u on u.doc_no='"+session.getAttribute("USERID") +"'  left join my_usrbr ub on ub.user_id=u.doc_no and ub.brhid=b.doc_no and u.permission=1 "
							 +" where  b.cmpid='"+getCompany()+"'  and  if(u.permission=1,ub.user_id,'"+session.getAttribute("USERID")+"')='"+session.getAttribute("USERID")+"'  and  b.status<>7  order by mainbranch desc" ;
				   
				    //System.out.println("=======STR BRNCH"+strBrch);
				    ResultSet rsBrch = stmtBrch.executeQuery(strBrch);
				    if(rsBrch.next ()) {
				     rsBrch.getString("brhid");
				     session.setAttribute("BRANCHID", rsBrch.getString("brhid"));
				     rsBrch.getString("curid");
				         session.setAttribute("CURRENCYID", rsBrch.getString("curid"));
				     rsBrch.getString("type");   
				         session.setAttribute("CURRENCYTYPE", rsBrch.getString("type"));
				    }
				     
				   //System.out.println("=====branch==="+session.getAttribute("BRANCHID"));
				    stmtBrch.close();

					Statement stmt1 = conn.createStatement();
					String strSqlYr = "select DATE_FORMAT((ACCYR_F),'%d-%m-%Y') ACCYR_F, DATE_FORMAT((ACCYR_T),'%d-%m-%Y') ACCYR_T from my_year where CL_STAT=0  and CMPID='"+getCompany()+"'";

					ResultSet rsyr = stmt1.executeQuery(strSqlYr);
					if(rsyr.next ()) {
							session.setAttribute("STYEAR", rsyr.getString("ACCYR_F"));
							session.setAttribute("EDYEAR", rsyr.getString("ACCYR_T"));
					}
					
					LinkedHashMap<String, HashMap<String, LinkedHashMap<String,ArrayList<String>>>> Menu =getMenuDetails();
					request.setAttribute("MenuMap", Menu);
					
					Statement stmtsys = conn.createStatement();
					String strSys = "select cvalue,codeno from my_system where comp_id='"+getCompany()+"'";
					ResultSet rsSys = stmtsys.executeQuery (strSys);
					while(rsSys.next ()) {
						session.setAttribute(rsSys.getString("codeno").toUpperCase().trim(), rsSys.getString("cvalue").trim());
					}
					stmtsys.close();
					
					userName="";
					passWord="";
					setUserid("");
					setPassword("");
			conn.close();
			return "success";
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
				return "fail";
			}
	}
	
	public String getRemortIP(HttpServletRequest request) { 
	    if (request.getHeader("x-forwarded-for") == null) { 
	        return request.getRemoteAddr(); 
	    } 
	    return request.getHeader("x-forwarded-for"); 
	} 
	
	public String getMACAddress(String ip){ 
        String str = ""; 
        String macAddress = ""; 
        try { 
            Process p = Runtime.getRuntime().exec("nbtstat -A " + ip); 
            InputStreamReader ir = new InputStreamReader(p.getInputStream()); 
            LineNumberReader input = new LineNumberReader(ir); 
            for (int i = 1; i <100; i++) { 
                str = input.readLine(); 
                if (str != null) { 
                    if (str.indexOf("MAC Address") > 1) { 
                        macAddress = str.substring(str.indexOf("MAC Address") + 14, str.length()); 
                        break; 
                    } 
                } 
            } 
        } catch (IOException e) { 
            e.printStackTrace(System.out); 
        } 
        return macAddress; 
    }

	private LinkedHashMap<String, HashMap<String, LinkedHashMap<String,ArrayList<String>>>> getMenuDetails() throws SQLException {

		LinkedHashMap<String, HashMap<String,LinkedHashMap<String,ArrayList<String>>>> mainMap=new LinkedHashMap<String, HashMap<String, LinkedHashMap<String,ArrayList<String>>>>();
		LinkedHashMap<String, LinkedHashMap<String,ArrayList<String>>> detailMap=new LinkedHashMap<String, LinkedHashMap<String,ArrayList<String>>>();
		ArrayList<String> alDetail= new ArrayList<String>();
		LinkedHashMap<String,ArrayList<String>> mapDetail= new LinkedHashMap<String,ArrayList<String>>();
		ArrayList<String> parentMenu= new ArrayList<>();
		ArrayList<String> alchildMenu= new ArrayList<>();
		LinkedHashMap<String, ArrayList<String>> childMenu= new LinkedHashMap<>();
		String menuName="";
		String menuName1="";
		HttpServletRequest request=ServletActionContext.getRequest();  
		HttpSession session=request.getSession(); 
	
		Connection conn = null;
		
		try{
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
	
			//String strSql = "Select t.menu_name,t.pmenu,t.mno  from my_menu t left join my_powr p on p.mno=t.mno  "
				//	+ "left join my_user u on u.role_id=p.roleid  where t.pmenu=0 and t.GATE!='N' "
				//	+ "and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and u.doc_no='"+session.getAttribute("USERID").toString()+"'";
		
			String strSql = "Select t.menu_name,t.pmenu,t.mno  from my_menu t left join my_powr p on p.mno=t.mno where t.pmenu=0 and t.GATE!='N' "
					+ "and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and p.roleid='"+getRoleid()+"'";
			
			ResultSet rsMenu = stmt.executeQuery(strSql);
			while(rsMenu.next()){
					double pmenu=rsMenu.getDouble("pmenu");
					double mno=rsMenu.getDouble("mno");
					menuName=rsMenu.getString("menu_name");
					parentMenu.add(menuName);
				}
				for(int i=0;i<parentMenu.size();i++){
				/*	String sqlMenu1="select menu_name,func from my_menu where pmenu in (select mno from my_menu where menu_name='"+parentMenu.get(i)+"') and GATE!='N'";*/
					
					//String sqlMenu1="select t.menu_name,t.func from my_menu t left join my_powr p on p.mno=t.mno left join my_user u on u.role_id=p.roleid where t.pmenu in "
						//	+ " (select mno from my_menu where menu_name='"+parentMenu.get(i)+"') and t.GATE!='N' and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and u.doc_no='"+session.getAttribute("USERID").toString()+"'";
					
					String sqlMenu1="select t.menu_name,t.func from my_menu t left join my_powr p on p.mno=t.mno where t.pmenu in "
							+ " (select mno from my_menu where menu_name='"+parentMenu.get(i)+"') and t.GATE!='N' and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and p.roleid='"+getRoleid()+"'";
					
					ResultSet rsMenu1 = stmt.executeQuery(sqlMenu1);
						while(rsMenu1.next()) {
							menuName1=rsMenu1.getString("menu_name");
							alchildMenu.add(menuName1);
						}
						childMenu.put(parentMenu.get(i),alchildMenu);
						alchildMenu=new ArrayList<>();
				}	
				for(int i=0;i<parentMenu.size();i++){
					for(int j=0; j< (childMenu.get(parentMenu.get(i))).size();j++){
						String menuPart=(childMenu.get(parentMenu.get(i)).toString());
					/*	String sqlMenu2="select menu_name,func,mno from my_menu where pmenu in"
								+ " (select mno from my_menu where menu_name='"+childMenu.get(parentMenu.get(i)).get(j)+"') and GATE!='N'";*/
						
						//String sqlMenu2="select t.menu_name,t.func,t.mno from my_menu t left join my_powr p on p.mno=t.mno  left join my_user u on u.role_id=p.roleid where t.pmenu in "
							//	+ " (select mno from my_menu where menu_name='"+childMenu.get(parentMenu.get(i)).get(j)+"') and t.GATE!='N' "
							//	+ "and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and u.doc_no='"+session.getAttribute("USERID").toString()+"'";
						
						String sqlMenu2="select t.menu_name,t.func,t.mno from my_menu t left join my_powr p on p.mno=t.mno where t.pmenu in "
								+ " (select mno from my_menu where menu_name='"+childMenu.get(parentMenu.get(i)).get(j)+"') and t.GATE!='N' "
								+ "and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and p.roleid='"+getRoleid()+"'";
						
						Statement stmt1 = conn.createStatement();
						ResultSet rsMenu2 = stmt1.executeQuery(sqlMenu2);
							while(rsMenu2.next()){
								menuName1=rsMenu2.getString("menu_name");
						int mno=rsMenu2.getInt("mno");
						/*		String sqlMenu3="select menu_name,func from my_menu where pmenu ="+mno+" and GATE!='N'";*/
						
						
						//String sqlMenu3="select t.menu_name,t.func,t.pmenu from my_menu t left join my_powr p on p.mno=t.mno  left join my_user u on u.role_id=p.roleid where t.pmenu ="+mno+" and t.GATE!='N' "
						//		+ "and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and u.doc_no='"+session.getAttribute("USERID").toString()+"'";
							
						String sqlMenu3="select t.menu_name,t.func,t.pmenu from my_menu t left join my_powr p on p.mno=t.mno where t.pmenu ="+mno+" and t.GATE!='N' "
								+ "and (p.add1<>0 or p.edit<>0 or p.del<>0 or p.print<>0 or p.attach<>0 or p.excel<>0) and p.roleid='"+getRoleid()+"'";

								ResultSet rsMenu3 = stmt.executeQuery(sqlMenu3);
									while(rsMenu3.next()){
										alDetail.add(rsMenu3.getString("menu_name"));
									}
								mapDetail.put(menuName1,alDetail);	
						alDetail=new ArrayList<>();
							}
							
						detailMap.put((childMenu.get(parentMenu.get(i))).get(j), mapDetail);
						mainMap.put(parentMenu.get(i), detailMap);
						mapDetail=new LinkedHashMap<>();	
					}
					detailMap=new LinkedHashMap();
					}
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return mainMap;
	}
	
	public String logout() {
		HttpServletRequest request=ServletActionContext.getRequest();  
		HttpSession session=request.getSession();
		/*if (sessionMap.containsKey("userName")) {
			sessionMap.remove("userName");
		}*/
		return "success";
	}
	
	public boolean checkAdminGate(HttpServletRequest request, String userName,String passWord) throws IOException {
		
		String filePath=request.getSession().getServletContext().getRealPath("/com/login/login.properties");
		filePath=filePath.replace("\\", "\\\\"); 
		boolean flg=false;
		String pUserName,pPassWord;
		Properties pros = new Properties();
		
		try {
			FileInputStream ip=new FileInputStream(filePath);
			pros.load(ip);
			
			pUserName=pros.getProperty("username");
			pPassWord=pros.getProperty("password");
			pPassWord=ClsEncrypt.getInstance().encrypt(pPassWord);
			
			if(userName.equals(pUserName) && passWord.equals(pPassWord)) {
				flg=true;
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return false;
		}
		return flg;
	}
	
}
