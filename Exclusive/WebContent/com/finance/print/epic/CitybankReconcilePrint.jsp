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
    border: 1px solid rgb(139,136,120);
    border-collapse: collapse;
}
 
fieldSet {
  		-webkit-border-radius: 8px;
  		-moz-border-radius: 8px;	
  		border-radius: 8px;
  		border: 1px solid rgb(139,136,120);
  }

legend
    {
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }

hr { 
	   border-top: 1px solid #e1e2df  ;
   } 

#preparedby table { page-break-inside:avoid; }

</style>

<script type="text/javascript">

	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		var sec=document.getElementById("secarray").value;
		var header=document.getElementById("txtheader").value;
	
		if(parseInt(header)==1){
			   $("#headerdiv").prop("hidden", false);
			   $("#withoutHeaderDiv").attr("hidden", true);
			}
			else{
				$("#headerdiv").prop("hidden", true);
				$("#withoutHeaderDiv").attr("hidden", false);
			}
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
		}
		else{
			 $("#firstdiv").prop("hidden", true);
			}
		if(parseInt(sec)==2){
			  $("#secdiv").prop("hidden", false);
		}
		else{
			 $("#secdiv").prop("hidden", true);
			}
		}

		

</script>



</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmbankReconcilePrint" action="reconcileprintVoucher" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<div id="headerdiv" hidden="true" >
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>

<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left">Account </td>
    <td>: <label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label></td>
    
    <td width="12%" align="left">Voucher No. </td>
    <td width="20%">: <label name="lblvoucherno" id="lblvoucherno" ><s:property value="lblvoucherno"/></label></td>
  </tr>
  <tr>
    <td align="left">Currency </td>
    <td>: <label id="lblcurrency" name="lblcurrency" ><s:property value="lblcurrency"/></label></td>
    <td align="left">Date Upto </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
   </tr>
   <tr>
  </table><br/>
</fieldset><br/>
  
<div id="firstdiv" hidden="true" >
<fieldset>
<table id="reconcile" style="border-collapse: collapse;" width="100%">
  <thead>
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="5%" align="center" style="border-collapse: collapse;"><b>Sl No</b></th>
    <th width="14%" align="center" style="border-collapse: collapse;"><b>Date</b></th> 
    <th width="11%" align="center" style="border-collapse: collapse;"><b>Doc Type</b></th>
    <th width="13%" align="center" style="border-collapse: collapse;"><b>Doc No</b></th>
    <th width="27%" align="center" style="border-collapse: collapse;"><b>Cheque No.</b></th> 
    <th width="15%" align="right" style="border-collapse: collapse;"><b>Receipts</b></th>
  </tr>
  </thead>
  <tbody>
  <tr>
      <td colspan="7"><hr noshade size=1 color="#e1e2df" width="100%"></td>
  </tr>
    <%int j=0,k=0; %>
    <s:iterator var="stat" value='#request.printarrays'>
   <%k=k+1;j=0;%>
	<tr height="20">   
		<td width="5%" align="center"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j>3){%>
  		<td align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } j++;  %>
 		</s:iterator>
	</tr>
	</s:iterator> 
	</tbody>
	<tr><td colspan="7">&nbsp;</td></tr>
	<tr>
		<td  align="right" colspan="5"><b>Total </b>&nbsp;</td>
        <td width="8%" align="right"><label id="lblunclearedreceipttotal" name="lblunclearedreceipttotal"><s:property value="lblunclearedreceipttotal"/></label></td>
	</tr>
</table><br/>
</fieldset>
</div><br/>

<div id="secdiv" hidden="true" > 
<fieldset>
<!-- <legend>Accounting</legend> -->
<table id="payment" style="border-collapse: collapse;" width="100%" >
  <thead>
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="5%" align="center" style="border-collapse: collapse;"><b>Sl No</b></th>
    <th width="14%" align="center" style="border-collapse: collapse;"><b>Date</b></th> 
    <th width="11%" align="center" style="border-collapse: collapse;"><b>Doc Type</b></th>
    <th width="13%" align="center" style="border-collapse: collapse;"><b>Doc No</b></th>
    <th width="27%" align="center" style="border-collapse: collapse;"><b>Cheque No.</b></th> 
    <th width="15%" align="right" style="border-collapse: collapse;"><b>Payments</b></th>
  </tr>
  </thead>
  <tbody>
  <tr>
      <td colspan="7"><hr noshade size=1 color="#e1e2df" width="100%"></td>
  </tr>
    <%int i=0,l=0; %>
    <s:iterator var="stat" value='#request.printingarray' >
   <%l=l+1;i=0;%>
	<tr height="20">   
		<td width="5%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==1 || i==2){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>3){%>
  		<td align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } i++;  %>
 		</s:iterator>
	</tr>
	</s:iterator> 
</tbody>
<tr><td colspan="7">&nbsp;</td></tr>
<tr >
		<td  align="right" colspan="5"><b>Total </b>&nbsp;</td>
        <td width="7%" align="right"><label id="lblunclearedpaymenttotal" name="lblunclearedpaymenttotal"><s:property value="lblunclearedpaymenttotal"/></label></td>
	</tr>
</table><br/>
</fieldset>
</div><br/>

<table width="100%">
  <tr height="25">
    <td width="84%" align="right"><b>Balance As Per Book </b></td>
    <td width="1%"><b>:</b></td>
    <td width="15%" align="left">&nbsp;<label id="lblbookbalance" name="lblbookbalance"><s:property value="lblbookbalance"/></label></td>
  </tr>
  <tr height="25">
    <td align="right"><b>ADD: Uncleared Payments </b></td>
    <td><b>:</b></td>
    <td align="left">&nbsp;<label id="lblunclearedpayments" name="lblunclearedpayments"><s:property value="lblunclearedpayments"/></label></td>
  </tr>
  <tr height="25">
    <td align="right"><b>LESS: Uncleared Receipts </b></td>
    <td><b>:</b></td>
    <td align="left">&nbsp;<label id="lblunclearedreceipts" name="lblunclearedreceipts"><s:property value="lblunclearedreceipts"/></label></td>
  </tr>
  <tr height="25">
    <td align="right"><b>Balance As Per Bank Statement </b></td>
    <td><b>:</b></td>
    <td align="left">&nbsp;<label id="lblbankstatements" name="lblbankstatements"><s:property value="lblbankstatements"/></label></td>
  </tr>
</table>

<table id="preparedby" width="100%" class="tablereceipt">
<tr>
<td width="60%">
<table width="100%">
  <tr>
    <td width="39%" align="left" height="25"><b>Prepared</b></td>
    <td width="35%" align="center"><b>Verified</b></td>
    <td width="26%" align="center"><b>Approved</b></td>
  </tr>
  <tr>
    <td><b>by</b>&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><b>on</b>&nbsp;<label name="lblpreparedon" id="lblpreparedon" ><s:property value="lblpreparedon"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><b>at</b>&nbsp;<label name="lblpreparedat" id="lblpreparedat" ><s:property value="lblpreparedat"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</td>

<td width="40%" class="tablereceipt">
<table width="100%">
  <tr>
    <td height="25" colspan="4"><b>Received By</b></td>
  </tr>
  <tr>
    <td width="5%"><b>Name</b></td>
    <td colspan="3">:<hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="100%"></td>
  </tr>
  <tr>
    <td><b>Date</b></td>
    <td width="48%">:&nbsp;</td>
    <td width="5%"><b>Time</b></td>
    <td width="42%">:&nbsp;</td>
  </tr>
</table>
</td></tr>
</table><br/>

<table width="100%">
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

<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'> 
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>

</form>
</div>
</body>
</html>
