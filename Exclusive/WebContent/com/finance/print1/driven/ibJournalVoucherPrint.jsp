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
			   
			   if($( "#accounting tbody tr:eq(27)")){
				 	var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
				 	$( "#accounting tbody tr:nth-child(27)").after(head.clone());
				}
				 
				if($( "#accounting tbody tr:gt(27)")){
					 var head = $('<tr><td><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/></td></tr>');
					 $( "#accounting tbody tr:nth-child(68n)").after(head.clone());
				}
			}
		else{
			$("#firstdiv").prop("hidden", true);
			}
		}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmIbJournalVoucherPrint" action="ibJournalVoucherPrint" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<div id="headerdiv" hidden="true" >
<jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>

<fieldset>
<table width="100%">
   <tr>
    <td width="12%" align="left">Voucher Date </td>
    <td width="28%">: <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
    <td width="7%" align="left">Ref No. </td>
    <td width="21%">: <label name="lblrefno" id="lblrefno" ><s:property value="lblrefno"/></label></td>
    <td width="11%" align="left">Voucher No. </td>
    <td width="21%">: <label name="lblvoucherno" id="lblvoucherno" ><s:property value="lblvoucherno"/></label></td>
  </tr>
  <tr>
    <td align="left">Description </td>
    <td colspan="5">: <label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></td>
  </tr>
  <tr>
    <td align="left">Amount in words </td>
    <td colspan="3">: <label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></td>
    <td align="left">Amount </td>
    <td>: <label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
  </tr>
</table><br/>
</fieldset>

<div id="firstdiv" hidden="true" > 
<fieldset>
<legend>Accounting</legend>
<table id="accounting" style="border-collapse: collapse;" width="100%">
 <thead>
 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="5%" align="center" style="border-collapse: collapse;"><b>Sl No</b></th>
    <th width="11%" align="left" style="border-collapse: collapse;"><b>Branch</b></th>
    <th width="8%" align="center" style="border-collapse: collapse;"><b>Acc. No</b></th>
    <th width="23%" align="left" style="border-collapse: collapse;"><b>Acc. Head</b></th>
    <th width="24%" align="left" style="border-collapse: collapse;"><b>Description</b></th>
    <th width="7%" align="center" style="border-collapse: collapse;"><b>Currency</b></th> 
    <th width="11%" align="right" style="border-collapse: collapse;"><b>Debit</b></th>
    <th width="11%" align="right" style="border-collapse: collapse;"><b>Credit</b></th>
  </tr>
  </thead>
  <tbody>
  <tr>
      <td colspan="8"><hr noshade size=1 color="#e1e2df" width="100%"></td>
  </tr>
    <%int i=0,l=0; %>
    <s:iterator var="stat" value='#request.printingarray' >
   <%l=l+1;i=0;%>
	<tr height="20">   
		<td align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==0 || i==2){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
    	<%} else if(i==3){%>
  		<td align="left">
		    <s:property value="#des"/>
  		</td>
     	<%} else if(i>4){%>
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
<tr><td colspan="8">&nbsp;</td></tr>
<tr>
		<td  align="right" colspan="6"><b>Total </b>&nbsp;</td>
        <td width="8%" align="right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
        <td width="7%" align="right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
</tr>
</table>
<br/>
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
</table>

<jsp:include page="../../../common/printFooter.jsp"></jsp:include>
<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>  
</div>

</form>
</div>
</body>
</html>