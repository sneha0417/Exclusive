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
<form id="frmbankVoucherPrint" action="bankprintVoucher" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<div id="headerdiv" hidden="true" >
<%-- <jsp:include page="../../../common/printHeader.jsp"></jsp:include> --%>
<%-- <table width="100%" class="normaltable">
  <tr>
    <td><img src="<%=contextPath%>/icons/nsibheader.jpg" width="100%" height="100%"  alt=""/></td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr>    <td align="center"><b><font size="4"><label id="lblprintnamensib" name="lblprintnamensib"><s:property value="lblprintnamensib"/></label></font></b></td>
  </tr>
 </table>
  --%>
  <table width="100%" class="normaltable">
  <tr>
    <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="110" height="100"  alt=""/></td>
    <td width="50%" rowspan="2">&nbsp;</td>
    <td width="32%" align=right><font size="2"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td>
  </tr>
  <tr>
    <td align=right><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="5"><label id="lblprintnamensib" name="lblprintnamensib"><s:property value="lblprintnamensib"/></label></font></b></td>
    <td align=right><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
  </tr>
  <tr>
    <td align=right><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2" align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td align=right><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align=right><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintnamensib" name="lblprintnamensib"><s:property value="lblprintnamensib"/></label></font></b></center>
</div>

<fieldset>
<table width="100%">
  <tr>
    <td width="16%" align="left"><label id="lblmainname" name="lblmainname"><s:property value="lblmainname"/></label></td>
    <td>: <label id="lblname" name="lblname"><s:property value="lblname"/></label></td>
    
    <td width="12%" align="left">Voucher No. </td>
    <td width="20%">: <label name="lblvoucherno" id="lblvoucherno" ><s:property value="lblvoucherno"/></label></td>
  </tr>
  <tr>
    <td align="left">Description </td>
    <td>: <label id="lbldescription" name="lbldescription" ><s:property value="lbldescription"/></label></td>
    <td align="left">Voucher Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
   </tr>
   <tr>
   <td align="left">Cheque  No</td>
    <td>: <label id="lblchqno" name="lblchqno"><s:property value="lblchqno"/></label></td> 
   <td align="left">Cheque Date</td>
    <td>: <label id="lblchqdate" name="lblchqdate"><s:property value="lblchqdate"/></label></td>
   </tr>
   <tr>
   <td align="left">Amount in words </td>
   <td>: <label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></td>
   <td align="left">Amount </td>
   <td>: <label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
  </tr>
  </table><br/>
</fieldset>
  
<div id="firstdiv" hidden="true" >
<fieldset>
<legend>Applying</legend>
<table id="applying" style="border-collapse: collapse;" width="100%">
  <thead>
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="5%" align="center" style="border-collapse: collapse;" ><b>Sl No</b></th>
    <th width="11%" align="center" style="border-collapse: collapse;"><b>Doc No</b></th>
    <th width="9%" align="center" style="border-collapse: collapse;"><b>Doc Type</b></th>
    <th width="11%" align="center" style="border-collapse: collapse;"><b>Date</b></th> 
    <th width="25%" align="left" style="border-collapse: collapse;"><b>Remarks</b></th> 
    <th width="13%" align="right" style="border-collapse: collapse;"><b>Amount</b></th>
    <th width="13%" align="right" style="border-collapse: collapse;"><b>Applying</b></th>
    <th width="13%" align="right" style="border-collapse: collapse;"><b>Balance</b></th>
  </tr>
  </thead>
  <tbody>
  <tr>
      <td colspan="8"><hr noshade size=1   color="#e1e2df"   width="100%"></td>
  </tr>
    <%int j=0,k=0; %>
    <s:iterator var="stat" value='#request.printapplying'>
   <%k=k+1;j=0;%>
	<tr height="20">   
		<td width="5%" align="center"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==3){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(j>3){%>
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
</table><br/>
</fieldset>
</div>

<div id="secdiv" hidden="true" > 
<fieldset>
<legend>Accounting</legend>
<table id="accounting" style="border-collapse: collapse;" width="100%" >
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
<tr >
		<td  align="right" colspan="5"><b>Total </b>&nbsp;</td>
        <td width="8%" align="right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
        <td width="7%" align="right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
</tr>
</table><br/>
</fieldset>
</div><br/>
<table>
<tr>
<td  align="right" colspan="5"><b>* Cheque Receipt is subject to realisation.</b></td>
</tr>
</table>
<br>
<br>
<table id="preparedby" width="100%" class="tablereceipt">
<tr>
<td width="60%">
<table width="100%">
  <tr>
    <td width="25%" align="left" height="25"><b>Prepared</b></td>
    <td width="25%" align="left"><b>Verified</b></td>
    <td width="26%" align="left"><b>Approved</b></td>
    <td width="26%" align="center" rowspan="3"><img src="<%=contextPath%>/icons/nsib_stamp.png" width="100%" height="25%"  alt=""/></td>
  </tr>
  
  <tr>
    <td><b>by</b>&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    <td><b>by</b>&nbsp;<label name="verifiedappr" id="verifiedappr" ><s:property value="verifiedappr"/></label></td>
    <td><b>by</b>&nbsp;<label name="approved" id="approved" ><s:property value="approved"/></label></td>
    
  </tr>
  <tr>
    <td><b>on</b>&nbsp;<label name="lblpreparedon" id="lblpreparedon" ><s:property value="lblpreparedon"/></label></td>
    <td><b>on</b>&nbsp;<label name="verifybydt" id="verifybydt" ><s:property value="verifybydt"/></label></td>
    <td><b>on</b>&nbsp;<label name="approvedt" id="approvedt" ><s:property value="approvedt"/></label></td>
  </tr>
  <tr>
    <td><b>at</b>&nbsp;<label name="lblpreparedat" id="lblpreparedat" ><s:property value="lblpreparedat"/></label></td>
    <td><b>at</b>&nbsp;<label name="verifybyat" id="verifybyat" ><s:property value="verifybyat"/></label></td>
        <td><b>at</b>&nbsp;<label name="approveat" id="approveat" ><s:property value="approveat"/></label></td>
    
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
