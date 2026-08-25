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

fieldSet {
  		-webkit-border-radius: 8px;
  		-moz-border-radius: 8px;
  		border-radius: 8px;
  		border: 1px solid rgb(139,136,120);
  }

legend{
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
hr { 
   		border-top: 1px solid #e1e2df  ;
    }

.verticalLine {
    border-left: 1px solid black;
}

</style>



</head>
<body style="font-size:10px;background-color:white;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="clientfollowup" action="printclientfollowup" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<table width="96%" align="center">
<tr><td>
<fieldset>
<table width="98%" align="center">
  <tr>
    <td width="16%" align="left"><b>Name</b> </td>
    <td colspan="3"><b>:</b> <label id="lblname" name="lblname"><s:property value="lblname"/></label></td>
    <td width="18%" align="left"><b>Account No</b> </td>
    <td width="20%"> <b>:</b> <label name="lblacno" id="lblacno" ><s:property value="lblacno"/></label></td>
  </tr>
  
  <tr>
    <td align="left"><b>Address</b> </td>
    <td colspan="3"><b>:</b> <label name="lbladdress" id="lbladdress" ><s:property value="lbladdress"/></label></td>
    <td align="left"><b>Mobile No.</b> </td>
    <td>: <label name="lblmobno" id="lblmobno" ><s:property value="lblmobno"/></label></td>
  </tr>
  
  <tr>
    <td align="left"><b>Code No.</b> </td>
    <td colspan="3"><b>:</b> <label id="lblcodeno" name="lblcodeno" ><s:property value="lblcodeno"/></label></td>
    <td colspan="2"></td>
    </tr>
	

</table>
</fieldset>
</td></tr>
</table>
<br/>

<div id="firstdiv" >
<table id="client" width="95%" class="tablereceipt" align="center">
  <thead>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="4%" align="center">Sr.No</th>
    <th class="tablereceipt" width="15%" align="left">Branch</th>
    <th class="tablereceipt" width="9%" align="left">Date</th>
    <th class="tablereceipt" width="30%" align="left">Comments</th>
    <th class="tablereceipt" width="10%" align="left">Process</th>
    <th class="tablereceipt" width="9%" align="left">Followup Date</th>
    <th class="tablereceipt" width="17%" align="left">User</th>
   
  </tr>
</thead>
<tbody>
  <%int l=0; %>
  <s:iterator var="stat" value='#request.printclientarray' >
  <%l=l+1;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="4%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    		<td class=tablereceipt align="left">
		    <s:property value="#des"/>
    	</td>
    	
 		</s:iterator>
	</tr>
	</s:iterator>
	</tbody>
</table><br/>
</div>


<br/>

<table width="95%" align="center">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>
</div>
</form>
</div>
</body>
</html>