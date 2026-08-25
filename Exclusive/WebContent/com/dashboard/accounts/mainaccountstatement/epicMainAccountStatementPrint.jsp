<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
</style>

</head>
<body bgcolor="white" style="font-size:10px;">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMainAccountStatement" action="printMainAccountStatement" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<table width="100%">
  <tr>
    <td width="10%" align="right"><b><font size="2">Account :</font></b>&nbsp;</td>
    <td width="90%"><font size="2"><label id="accountname" name="accountname"><s:property value="accountname"/></label></font></td>
  </tr>
</table><br/>

<table width="95%" class=tablereceipt align="center">
  <tr>
    <td colspan="2" height="25" align="center" class=tablereceipt><b>Account Informations</b></td>
    <td colspan="2" align="center" class=tablereceipt><b>Value in AED</b></td>
  </tr>
  <tr>
    <td width="16%" align="center" class=tablereceipt><b>Account</b></td>
    <td width="48%" align="left" class=tablereceipt><b>Account Name</b></td>
    <td width="18%"  align="right" class=tablereceipt><b>Debit</b></td>
    <td width="18%"  align="right" class=tablereceipt><b>Credit</b></td>
  </tr>
  
    <s:iterator var="stat" value='#request.printingarray' >
	<tr class=tablereceipt>   
		<%int i=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==1){%>
    	<td class=tablereceipt align="left">
		    &nbsp;<s:property value="#des"/>
    	</td>
     	<%} else if(i>1){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td class=tablereceipt align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } i++;  %>
 		</s:iterator>
	</tr>
	</s:iterator>
</table><br/>

<table width="100%">
<tr>
		<td width="92%" align="right"><b>Net Amount :</b>&nbsp;</td>
        <td width="8%" align="left"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
</tr>
</table><br/>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
</div>
</form>
</div>
</body>
</html>