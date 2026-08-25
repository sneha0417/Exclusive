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

table.hovertable {
	font-size:9px;
	border-width: 1px;
	border-color: #111111;
	border-collapse: collapse;
}
table.hovertable th {
	background-color:#D8D8D8;
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #111111;
}
table.hovertable tr {
	background-color:#FFF;
}
table.hovertable td {
	border-width: 1px;
	border-style: solid;
	border-color: #111111;
}

</style>

<script type="text/javascript">

	function hidedata(){
		
		var header=document.getElementById("txtheader").value;
	
		if(parseInt(header)==1){
			   $("#headerdiv").prop("hidden", false);
			   $("#withoutHeaderDiv").attr("hidden", true);
			}
			else{
				$("#headerdiv").prop("hidden", true);
				$("#withoutHeaderDiv").attr("hidden", false);
			}
		
		}

</script>
</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmmonthlypayrollPrint" action="printMonthlyPayroll" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<div id="headerdiv" hidden="true" >
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>

<table width="100%"  class="hovertable">
  <thead>
  <tr height="25" style="font-size: 9px;color: #353535;">
    <th width="6%" align="left"><b>ID.</b></th>
    <th width="13%" align="left"><b>Name</b></th>
  <!--   <th width="10%" align="left"><b>Date</b></th> -->
    <th width="3%" align="center"><b>Days</b></th> 
    <th width="2%" align="center"><b>Leaves</b></th>
    <th width="7%" align="right"><b>Basic</b></th>
    <th width="5%" align="right"><b>Alow.</b></th>
    <th width="3%" align="center"><b>OT</b></th>  
    <th width="2%" align="center"><b>HOT</b></th>
    <th width="8%" align="right"><b>Over Time</b></th>
    <th width="6%" align="right"><b>Gross Salary</b></th>
    <th width="5%" align="right"><b>Add.</b></th>
    <th width="5%" align="right"><b>Ded.</b></th>        
    <th width="5%" align="right"><b>Loan</b></th>
    <th width="7%" align="right"><b>Net Salary</b></th>
    <th width="14%" align="left"><b>Remarks</b></th>
  </tr>
  </thead>
  <tbody> 
    <%int j=0,k=0; %>
    <s:iterator var="stat" value='#request.printpayroll'>
   <%k=k+1;j=0;%>
	<tr height="20" style="font-size: 9px;color: #353535;"  onmouseover="this.style.backgroundColor='#F3F3F3';" onmouseout="this.style.backgroundColor='#FFF';">   
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==0 || j==1 || j==14){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
    	<%} else if(j==5 || j==6 || j==4){%>
  		<td align="right">
		    <s:property value="#des"/>
  			</td>
  			<%} else if(j==2){%>
  		<td align="center">
		    <s:property value="#des"/>
  			</td>
     	<%} else if(j>7){%>
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
	<tr  height="25">
		<td  align="right" colspan="9"><b>Total :</b>&nbsp;</td>
		<td width="8%" align="right"><label id="lblgrosstotal" name="lblgrosstotal"><s:property value="lblgrosstotal"/></label></td>
		<td width="8%" align="right"><label id="lbladditiontotal" name="lbladditiontotal"><s:property value="lbladditiontotal"/></label></td>
		<td width="8%" align="right"><label id="lbldeductiontotal" name="lbldeductiontotal"><s:property value="lbldeductiontotal"/></label></td>
        <td width="8%" align="right"><label id="lblloantotal" name="lblloantotal"><s:property value="lblloantotal"/></label></td>
        <td width="7%" align="right"><label id="lblnetsalarytotal" name="lblnetsalarytotal"><s:property value="lblnetsalarytotal"/></label></td>
	</tr>
</table><br/>


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

<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>

</form>
</div>
</body>
</html>
