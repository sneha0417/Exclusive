package customerlogin;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class ClsCustomerLoginAction extends ActionSupport{

	
	private String clientusername,clientpassword,mode,msg,docno;
	public String getClientusername() {
		return clientusername;
	}
	public void setClientusername(String clientusername) {
		this.clientusername = clientusername;
	}
	public String getClientpassword() {
		return clientpassword;
	}
	public void setClientpassword(String clientpassword) {
		this.clientpassword = clientpassword;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	
	public String saveAction()throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		System.out.println("====== "+getClientusername()+"==="+getClientpassword()+"===="+mode);
		ClsCustomerLoginDAO dao=new ClsCustomerLoginDAO();
		if(mode.equalsIgnoreCase("A")){
			
			boolean status=dao.clientLogin(getClientusername(),getClientpassword(),session,request);
			if(status){
				return "success";
			}
			else{
				return "fail";
			}
		}
		
		return "fail";
	}
}
