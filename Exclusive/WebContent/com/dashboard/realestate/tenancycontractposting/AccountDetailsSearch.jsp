 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">

<%
String id = request.getParameter("id")==null?"0":request.getParameter("id");

 
%> 

	$(document).ready(function () {
		
		 
		  
	}); 
	
	function loadClientAccountSearch() {
		
		var id='<%=id%>';
		
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value; 
			var clientmobile=0;
			var curr=0;
			var accounttype=0; 
			var code=0;
			var debitcredit=0;
			var	dtype="";
			var date=0;
			 
			if(id==1 || id=="1")
				{
			 	dtype="CA";
				}
			else
				{
				dtype="BA";
				}
			
 
			var checked = 1;
	
			getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,dtype,code,debitcredit,date,checked,accounttype);
	}
		
	function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,dtype,code,debitcredit,date,checked,accounttype){
		 $("#refreshClientAccountDiv").load("AccountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&atype='+accounttype+'&dtype='+dtype+'&debitcredit='+debitcredit+'&date='+date+'&check='+checked);
	}

</script>
<body>
<div id=search>
<table width="100%" >
  <tr>
    <td width="10%" align="right"><label style="font-size:9px;">Account No</label></td>
    <td width="20%"><input type="text" name="accountsno" id="accountsno" style="width:70%;height:20px;" value='<s:property value="accountsno"/>'></td>
     
    <td align="right"><label style="font-size:9px;">Account Name</label></td>
    <td ><input type="text" name="accountsname" id="accountsname" style="width:85%;height:20px;" value='<s:property value="accountsname"/>'></td>
   <!--  </tr> -->
<%--     <tr>
    <td width="9%" align="right">Currency</td>
    <td width="14%"><input type="text" name="txtcurrencies" id="txtcurrencies" style="width:70%;" value='<s:property value="txtcurrencies"/>'>
    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
    <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'></td>
    <td width="8%" align="right">Mobile</td>
    <td width="25%"><input type="text" name="clientmobileno" id="clientmobileno" style="width:85%;" value='<s:property value="clientmobileno"/>'>
    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'></td>  
   --%>
  
  
   
    <td align="center"><input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search"  onclick="loadClientAccountSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshClientAccountDiv"><jsp:include page="AccountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>