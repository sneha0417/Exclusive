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
 legend{
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
 hr { 
   border-top: 1px solid #e1e2df  ;
    } 

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
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>

<fieldset>
<table width="100%">
  <tr>
    <td colspan="2" align="left">Your Account has been <label id="lblcreditordebit" name="lblcreditordebit"><s:property value="lblcreditordebit"/></label></td>
    <td width="76%">: <label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label></td>
    
  </tr>
  <tr>
    <td width="7%" align="left">Description</td>
    <td colspan="2">: <label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></td>
  </tr>
</table>
  </fieldset><br/>
  
<div id="firstdiv" hidden="true" >
<table style="border-collapse: collapse;" width="98%" align="center">
  
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;" ><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Acc. No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Acc. Head</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Currency</b></td> 
    <td align="right" style="border-collapse: collapse;"><b>Debit</b></td>
    <td align="right" style="border-collapse: collapse;"><b>Credit</b></td>
  </tr>
  <tr>
      <td colspan="6"><hr noshade size=1 color="#e1e2df" width="100%"></td>
  </tr>
    <%int i=0,l=0; %>
    <s:iterator var="stat" value='#request.printingarray' >
   <%l=l+1;i=0;%>
	<tr>   
		<td width="6%" align="left"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==2){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>2){%>
  		<td align="right">
		    <s:property value="#des"/>
  			</td>
   		<%} else{ %>
  		<td align="left">
		  <s:property value="#des"/>
  		</td>
  		<% } i++;  %>
 		</s:iterator>
	</tr>
	</s:iterator> 
<tr ><td colspan="6">&nbsp;</td></tr>
<tr >
		<td  align="right" colspan="4"><b>Total </b>&nbsp;</td>
        <td width="8%" align="right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
        <td width="7%" align="right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
</tr>
</table><br/>
</div><br/>

<table width="100%" class="tablereceipt">
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
</table>
<br/>
<br/><br/><br/><br/>
<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>

</form>
</div>
</body>
</html>
