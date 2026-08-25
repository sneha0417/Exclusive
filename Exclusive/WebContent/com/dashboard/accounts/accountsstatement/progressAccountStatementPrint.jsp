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

<script type="text/javascript">

	function hidedata(){
	
		var first=document.getElementById("firstarray").value;
		var sec=document.getElementById("secarray").value;
		
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

/*function pagebreak(){
	if($( "#accounting tbody tr:eq(40)")){
	 	var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
	 	$( "#accounting tbody tr:nth-child(40)").after(head.clone());
	}
	 
	if($( "#accounting tbody tr:gt(40)")){
		 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
		 $( "#accounting tbody tr:nth-child(94n)").after(head.clone());
	}
}*/

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAccountsStatement" action="printAccountsStatement" method="post" autocomplete="off" target="_blank">
<div style="background-color:white;">
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<%-- <table width="100%">
  <tr>
    <td width="10%" align="right"><b><font size="2">Account :</font></b>&nbsp;</td>
    <td width="6%" align="center"><font size="2"><label id="accountno" name="accountno"><s:property value="accountno"/></label></font></td>
    <td width="84%"><font size="2"><label id="accountname" name="accountname"><s:property value="accountname"/></label></font></td>
  </tr>
</table> --%>

<table width="100%">
  <tr>
    <td width="27%" align="right"><b><font size="2">Account :</font></b>&nbsp;</td>
    <td width="15%" align="center"><font size="2"><label id="accountno" name="accountno"><s:property value="accountno"/></label></font></td>
    <td colspan="4"><font size="2"><label id="accountname" name="accountname"><s:property value="accountname"/></label></font></td>
  </tr>
  <tr>
    <td align="right"><b><font size="2">Credit Period-Min(Days) :</font></b>&nbsp;</td>
    <td align="left"><font size="2"><label id="creditperiodmin" name="creditperiodmin"><s:property value="creditperiodmin"/></label></font></td>
    <td width="13%" align="right"><b><font size="2">Max(Days) :</font></b>&nbsp;</td>
    <td width="12%" align="left"><font size="2"><label id="creditperiodmax" name="creditperiodmax"><s:property value="creditperiodmax"/></label></font></td>
    <td width="15%" align="right"><b><font size="2">Credit Limit :</font></b>&nbsp;</td>
    <td width="18%" align="left"><font size="2"><label id="creditlimit" name="creditlimit"><s:property value="creditlimit"/></label></font></td>
  </tr>
</table><br/>

<div id="firstdiv" hidden="true"> 
<table id="accounting" width="98%" class=tablereceipt align="center">
  <thead>
  <tr>
    <th colspan="5" height="25" align="center" class=tablereceipt><b>Account Informations</b></th>
    <th colspan="3" align="center" class=tablereceipt><b>Value in AED</b></th>
  </tr>
  <tr>
    <th width="9%" height="20" align="center" class=tablereceipt><b>Date</b></th>
    <th width="6%" align="center" class=tablereceipt><b>Type</b></th>
    <th width="9%" align="center" class=tablereceipt><b>Doc No</b></th>
	<th width="13%" align="center" class=tablereceipt><b>Branch</b></th>
    <th width="28%" align="center" class=tablereceipt><b>Description</b></th>
    <th width="10%"  align="right" class=tablereceipt><b>Debit</b></th>
    <th width="10%"  align="right" class=tablereceipt><b>Credit</b></th>
    <th width="10%"  align="right" class=tablereceipt><b>Balance</b></th>
  </tr>
  </thead>
   <tbody>
    <s:iterator var="stat" value='#request.printingarray' >
	<tr class=tablereceipt>   
		<%int i=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==3 || i==4){%>
    	<td class=tablereceipt align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>4){%>
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
	 </tbody>
</table><br/>

<table width="98%">
<tr>
		<td width="68%" align="right"><b>Net Amount :</b>&nbsp;</td>
        <td width="10%" align="right"><label id="lblnetdebitamount" name="lblnetdebitamount"><s:property value="lblnetdebitamount"/></label></td>
        <td width="10%" align="right"><label id="lblnetcreditamount" name="lblnetcreditamount"><s:property value="lblnetcreditamount"/></label></td>
        <td width="10%" align="right"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
</tr>
</table><br/>
</div>

<div id="secdiv" hidden="true">
<table id="security" width="98%" class=tablereceipt align="center">
<thead>
  <tr><th colspan="7" height="28" style="background-color: #F6CECE;"><b>Security</b></th></tr>
  <tr>
    <th colspan="6" height="25" align="center" class=tablereceipt><b>Account Informations</b></th>
    <th align="center" class=tablereceipt><b>Value in AED</b></th>
  </tr>
  <tr>
    <th width="10%" height="20" align="center" class=tablereceipt><b>Date</b></th>
    <th width="7%" align="center" class=tablereceipt><b>Type</b></th>
    <th width="10%" align="center" class=tablereceipt><b>Doc No</b></th>
	<th width="14%" align="center" class=tablereceipt><b>Branch</b></th>
	<th width="14%" align="center" class=tablereceipt><b>Agreement</b></th>
    <th width="29%" align="center" class=tablereceipt><b>Description</b></th>
	<th width="11%"  align="right" class=tablereceipt><b>Amount</b></th>
  </tr>
  </thead>
   <tbody>
    <s:iterator var="stat" value='#request.printsecurityamountarray' >
	<tr class=tablereceipt>   
		<%int j=0; %>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==3 || j==5){%>
    	<td class=tablereceipt align="left">&nbsp;
		    <s:property value="#des"/>
    	</td>
     	<%} else if(j>5){%>
  		<td class=tablereceipt align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td class=tablereceipt align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } j++;  %>
 		</s:iterator>
	</tr>
	</s:iterator>
	</tbody>
</table><br/>

<table width="98%">
<tr>
		<td width="88%" align="right"><b>Security Amount :</b>&nbsp;</td>
        <td width="12%" align="right"><label id="lblnetsecurityamount" name="lblnetsecurityamount"><s:property value="lblnetsecurityamount"/></label></td>
</tr>
</table><br/>
</div> 

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
</div>
</form>
</div>
</body>
</html>