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
		var second=document.getElementById("secarray").value;
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
		
		if(parseInt(second)==2){
			   $("#seconddiv").prop("hidden", false);
		}
		else{
			 $("#seconddiv").prop("hidden", true);
			}
		
		}

</script>



</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmbudgetPrint" action="budgetprintVoucher" method="post" autocomplete="off" target="_blank">

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
    <td width="16%" align="left">Assessment Year </td>
    <td>: <label id="lblassessmentyear" name="lblassessmentyear"><s:property value="lblassessmentyear"/></label></td>
    
    <td width="12%" align="left">Voucher No. </td>
    <td width="20%">: <label name="lblvoucherno" id="lblvoucherno" ><s:property value="lblvoucherno"/></label></td>
  </tr>
  <tr>
    <td align="left">Description </td>
    <td>: <label id="lbldescription" name="lbldescription" ><s:property value="lbldescription"/></label></td>
    <td align="left">Date </td>
    <td>: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
   </tr>
   <tr>
   <tr>
    <td align="left">Total Income </td>
    <td>: <label id="lbltotincome" name="lbltotincome" ><s:property value="lbltotincome"/></label></td>
    <td align="left">Total Expenditure </td>
    <td>: <label name="lbltotexpenditure" id="lbltotexpenditure" ><s:property value="lbltotexpenditure"/></label></td>
   </tr>
   <tr>
  </table>
</fieldset><br/>
  
<div id="firstdiv" hidden="true" >
<table width="100%" class="tablereceipt" align="center">
  <tr><td colspan="15" height="28" style="background-color: #F6CECE;"><b>&nbsp;Income</b></td></tr>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <td width="5%" align="center" class="tablereceipt"><b>Account</b></td> 
    <td width="23%" align="left" class="tablereceipt"><b>Account Name</b></td>
    <td width="6%" align="center" class="tablereceipt"><b><label name="lblincomemonth1" id="lblincomemonth1" ><s:property value="lblincomemonth1"/></label></b></td>
    <td width="6%" align="center" class="tablereceipt"><b><label name="lblincomemonth2" id="lblincomemonth2" ><s:property value="lblincomemonth2"/></label></b></td> 
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth3" id="lblincomemonth3" ><s:property value="lblincomemonth3"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth4" id="lblincomemonth4" ><s:property value="lblincomemonth4"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth5" id="lblincomemonth5" ><s:property value="lblincomemonth5"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth6" id="lblincomemonth6" ><s:property value="lblincomemonth6"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth7" id="lblincomemonth7" ><s:property value="lblincomemonth7"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth8" id="lblincomemonth8" ><s:property value="lblincomemonth8"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth9" id="lblincomemonth9" ><s:property value="lblincomemonth9"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth10" id="lblincomemonth10" ><s:property value="lblincomemonth10"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth11" id="lblincomemonth11" ><s:property value="lblincomemonth11"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblincomemonth12" id="lblincomemonth12" ><s:property value="lblincomemonth12"/></label></b></td>
  </tr>
    <%int j=0,k=0; %>
    <s:iterator var="stat" value='#request.printincomes'>
   <%k=k+1;j=0;%>
	<tr height="25" class="tablereceipt">   
		<%-- <td width="5%" align="center"><%=k%></td> --%>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==1){%>
    	<td class=tablereceipt width="23%" align="left">
		    <s:property value="#des"/>
    	</td>
    	<%} else if(j>1){%>
  		<td class="tablereceipt" width="6%" align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td class="tablereceipt" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } j++;  %>
 		</s:iterator>
	</tr>
	</s:iterator> 
	<tr height="25">
		<td class="tablereceipt" align="left" colspan="12"><b>Total </b>&nbsp;</td>
        <td class="tablereceipt" width="7%" colspan="2" align="right"><label id="lblincometotal" name="lblincometotal"><s:property value="lblincometotal"/></label>&nbsp;</td>
	</tr>
</table><br/>
</div><br/>

<div id="seconddiv" hidden="true" >
<table width="100%" class="tablereceipt" align="center">
  <tr><td colspan="15" height="28" style="background-color: #F6CECE;"><b>&nbsp;Expenditure</b></td></tr>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <td width="5%" align="center" class="tablereceipt"><b>Account</b></td> 
    <td width="23%" align="left" class="tablereceipt"><b>Account Name</b></td>
    <td width="6%" align="center" class="tablereceipt"><b><label name="lblexpendituremonth1" id="lblexpendituremonth1" ><s:property value="lblexpendituremonth1"/></label></b></td>
    <td width="6%" align="center" class="tablereceipt"><b><label name="lblexpendituremonth2" id="lblexpendituremonth2" ><s:property value="lblexpendituremonth2"/></label></b></td> 
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth3" id="lblexpendituremonth3" ><s:property value="lblexpendituremonth3"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth4" id="lblexpendituremonth4" ><s:property value="lblexpendituremonth4"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth5" id="lblexpendituremonth5" ><s:property value="lblexpendituremonth5"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth6" id="lblexpendituremonth6" ><s:property value="lblexpendituremonth6"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth7" id="lblexpendituremonth7" ><s:property value="lblexpendituremonth7"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth8" id="lblexpendituremonth8" ><s:property value="lblexpendituremonth8"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth9" id="lblexpendituremonth9" ><s:property value="lblexpendituremonth9"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth10" id="lblexpendituremonth10" ><s:property value="lblexpendituremonth10"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth11" id="lblexpendituremonth11" ><s:property value="lblexpendituremonth11"/></label></b></td>
    <td width="6%" align="right" class="tablereceipt"><b><label name="lblexpendituremonth12" id="lblexpendituremonth12" ><s:property value="lblexpendituremonth12"/></label></b></td>
  </tr>
    <%int l=0,m=0; %>
    <s:iterator var="stat" value='#request.printexpenditures'>
   <%m=m+1;l=0;%>
	<tr height="25" class="tablereceipt">   
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(l==1){%>
    	<td class="tablereceipt" width="23%" align="left">
		    <s:property value="#des"/>
    	</td>
    	<%} else if(l>1){%>
  		<td class="tablereceipt" align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td class="tablereceipt" align="center">
		  <s:property value="#des"/>
  		</td>
  		<% } l++;  %>
 		</s:iterator>
	</tr>
	</s:iterator> 
	<tr height="25">
		<td class="tablereceipt" align="left" colspan="12"><b>Total </b>&nbsp;</td>
        <td class="tablereceipt" width="7%" colspan="2" align="right"><label id="lblexpendituretotal" name="lblexpendituretotal"><s:property value="lblexpendituretotal"/></label>&nbsp;</td>
	</tr>
</table><br/>
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
<input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>

</form>
</div>
</body>
</html>
