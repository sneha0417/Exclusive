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
 
legend {
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
	
	}

</script>



</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCreditDebitVoucherPrint" action="creditDebitVoucherPrint" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<div id="headerdiv" hidden="true" >

<table width="100%" class="normaltable" >
  <tr>
    <td width="25%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="50%" rowspan="2">&nbsp;</td>
    <td width="25%"><font size="3"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5">Tax Debit Note</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2" align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
    <td align="left"><b>TRN :</b>&nbsp;<label id="lblcomptrn" name="lblcomptrn" ><s:property value="lblcomptrn"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr>
    </table>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
<table width="89%" height="35%">
<tr>
<td width="50%" height="55" align="right"><b>TRN :</b>&nbsp;<label id="lblcomptrn" name="lblcomptrn" ><s:property value="lblcomptrn"/></label></td>
</tr>
</table>
</div>

<fieldset>
<table width="100%">
  <tr>
    <td colspan="2" align="left">Your Account has been <label id="lblcreditordebit" name="lblcreditordebit"><s:property value="lblcreditordebit"/></label></td>
    <td width="52%">: <label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label></td>
    <td width="12%" align="left">Voucher No</td>
    <td width="19%">: <label id="lbldocumentno" name="lbldocumentno"><s:property value="lbldocumentno"/></label></td>
    
  </tr>
   <tr>
     <td width="15%" align="left">Address</td>
    <td colspan="2">: <label id="lblcustaddress" name="lblcustaddress"><s:property value="lblcustaddress"/></label></td>
   <td width="12%" align="left">Voucher Date</td>
    <td width="19%">: <label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></td>
    
  </tr>
  <tr>
    <td width="15%" align="left">Description</td>
    <td colspan="2">: <label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></td>
     <td width="12%" align="left">Amount </td>
   <td width="19%">: <label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
  </tr>
   <tr>
   <td width="15%" align="left">Amount in words </td>
   <td colspan="2">: <label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></td>
  
  </tr>
  <tr>
   <td width="15%" align="left">TRN No</td>
   <td colspan="4">: <label id="lblclienttrno" name="lblclienttrno"><s:property value="lblclienttrno"/></label></td>
  </tr>
  <s:set name="agreement" value="lblagreement" />
  <s:if test="#agreement == 0"> 
  </s:if> 
  <s:else>
  <tr>
   <td width="15%" align="left">Agreement Vehicle </td>
   <td colspan="2">: <label id="lblvehicleinfo" name="lblvehicleinfo"><s:property value="lblvehicleinfo"/></label></td>
   <td width="12%" align="left">Agreement </td>
   <td width="19%">: <label id="lblagreement" name="lblagreement"><s:property value="lblagreement"/></label></td>
  </tr>
  </s:else>
</table><br/>
</fieldset>
  
<div id="firstdiv" hidden="true" >
<fieldset>
<legend>Accounting</legend>
<table id="accounting" style="border-collapse: collapse;" width="98%" align="center">
  <thead>
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="5%" align="center" style="border-collapse: collapse;"><b>Sl No</b></th>
    <th width="8%" align="center" style="border-collapse: collapse;"><b>Acc. No</b></th>
    <th width="28%" align="left" style="border-collapse: collapse;"><b>Acc. Head</b></th>
    <th width="30%" align="left" style="border-collapse: collapse;"><b>Description</b></th>
    <th width="7%" align="center" style="border-collapse: collapse;"><b>Currency</b></th> 
    <th width="11%" align="right" style="border-collapse: collapse;"><b>Debit</b></th>
    <th width="11%" align="right" style="border-collapse: collapse;"><b>Credit</b></th>
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
<tr>
		<td  align="right" colspan="5"><b>Total </b>&nbsp;</td>
        <td width="8%" align="right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
        <td width="7%" align="right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
</tr>
</table>
</fieldset>
</div><br/>

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
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>

</form>
</div>
</body>
</html>
