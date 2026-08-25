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

function pagebreak(){
	if($( "#accounting tbody tr:eq(40)")){
	 	var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
	 	$( "#accounting tbody tr:nth-child(40)").after(head.clone());
	}
	 
	if($( "#accounting tbody tr:gt(40)")){
		 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
		 $( "#accounting tbody tr:nth-child(94n)").after(head.clone());
	}
}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="pagebreak();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAccountsStatement" action="printAccountsStatement" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<table width="100%" class="normaltable">
  <tr>
	<td width="21%"><img src="<%=contextPath%>/icons/epic.jpg"  width="100%" height="82"  alt=""/></td>
	<td width="50%" align="center"><b><font size="4"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
	<td colspan="2" align="center"><img src="<%=contextPath%>/icons/manilaBooking.gif"  width="100%" height="82"  alt=""/></td>
  </tr>
  <tr>
    <td><b>Tel 1:</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td>
    <td align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td width="5%">&nbsp;</td>
    <td width="24%"><b>Website :</b>&nbsp;<label id="lblcompwebsite" name="lblcompwebsite"><s:property value="lblcompwebsite"/></label></td>
  </tr>
  <tr>
    <td><b>Tel 2:</b>&nbsp;<label id="lblcomptel2" name="lblcomptel2"><s:property value="lblcomptel2"/></label></td>
    <td>&nbsp;</td>
    <td width="5%">&nbsp;</td>
     <td><b>Email :</b>&nbsp;<label id="lblcompemail" name="lblcompemail"><s:property value="lblcompemail"/></label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td width="5%">&nbsp;</td>
    <td><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td colspan="4"><hr noshade size=1 width="100%"></td>
  </tr>
  <tr>
    <td colspan="4"></td>
  </tr>
</table>

<table width="100%">
  <tr>
    <td width="10%" align="right"><b><font size="2">Account :</font></b>&nbsp;</td>
    <td width="6%" align="center"><font size="2"><label id="accountno" name="accountno"><s:property value="accountno"/></label></font></td>
    <td width="84%"><font size="2"><label id="accountname" name="accountname"><s:property value="accountname"/></label></font></td>
  </tr>
</table><br/>

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
        <td width="12%" align="right"><label id="lblnetdebitamount" name="lblnetdebitamount"><s:property value="lblnetdebitamount"/></label></td>
        <td width="12%" align="right"><label id="lblnetcreditamount" name="lblnetcreditamount"><s:property value="lblnetcreditamount"/></label></td>
        <td width="12%" align="right"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
</tr>
</table><br/>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<br/><br/>
</div>
</form>
</div>
</body>
</html>