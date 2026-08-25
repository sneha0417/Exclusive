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
	
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
		} else {
			$("#firstdiv").prop("hidden", true);
		    }
		}

</script>

</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmPrepaymentSummaryPrint" action="summaryVoucherPrint" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>

<fieldset>
<table width="100%">
  <tr>
    <td width="18%" align="left">Account</td>
    <td width="50%">: <label id="lblaccount" name="lblaccount"><s:property value="lblaccount"/></label></td>
    
    <td width="12%" align="left">Voucher No. </td>
    <td width="20%">: <label name="lblvoucherno" id="lblvoucherno" ><s:property value="lblvoucherno"/></label></td>
  </tr>
  <tr>
    <td align="left">Description </td>
    <td>: <label id="lbldescription" name="lbldescription" ><s:property value="lbldescription"/></label></td>
    <td align="left">Voucher Date </td>
    <td>: <label name="lblvoucherdate" id="lblvoucherdate" ><s:property value="lblvoucherdate"/></label></td>
  </tr>
   <tr>
   <td align="left">Amount in words </td>
   <td>: <label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></td>
   <td align="left">Amount </td>
   <td>: <label id="lblamount" name="lblamount"><s:property value="lblamount"/></label></td>
  </tr>
  <tr>
   <td align="left">Posted Amount in words </td>
   <td>: <label id="lblpostamountwords" name="lblpostamountwords"><s:property value="lblpostamountwords"/></label></td>
   <td align="left">Posted </td>
   <td>: <label id="lblpostedamount" name="lblpostedamount"><s:property value="lblpostedamount"/></label></td>
  </tr>
  <tr>
   <td align="left">Balance Amount in words </td>
   <td>: <label id="lblbalanceamountwords" name="lblbalanceamountwords"><s:property value="lblbalanceamountwords"/></label></td>
   <td align="left">Balance </td>
   <td>: <label id="lblbalanceamount" name="lblbalanceamount"><s:property value="lblbalanceamount"/></label></td>
  </tr>
</table><br/>
</fieldset>

<fieldset><legend>Distribution Details</legend>
<table width="100%">
  <tr>
    <td width="16%" align="left">Account (To be Posted)</td>
    <td>: <label id="lbldistributionaccount" name="lbldistributionaccount"><s:property value="lbldistributionaccount"/></label></td>
    
    <td width="12%" align="left">Amount</td>
    <td width="20%">: <label name="lbldistributionamount" id="lbldistributionamount" ><s:property value="lbldistributionamount"/></label></td>
  </tr>
  <tr>
    <td align="left">Cost Type</td>
    <td>: <label id="lbldistributioncosttype" name="lbldistributioncosttype" ><s:property value="lbldistributioncosttype"/></label></td>
    <td align="left">Frequency</td>
    <td>: <label id="lbldistributionfrequency" name="lbldistributionfrequency"><s:property value="lbldistributionfrequency"/></label></td>
  </tr>
   <tr>
   <td align="left">Cost No</td>
   <td>: <label name="lbldistributioncostno" id="lbldistributioncostno" ><s:property value="lbldistributioncostno"/></label></td>
   <td align="left">Due After </td>
   <td>: <label id="lbldistributiondueafter" name="lbldistributiondueafter"><s:property value="lbldistributiondueafter"/></label></td>
  </tr>
  <tr>
   <td align="left">Inst. Nos</td>
   <td>: <label id="lbldistributioninstnos" name="lbldistributioninstnos"><s:property value="lbldistributioninstnos"/></label></td>
   <td align="left">Start Date </td>
   <td>: <label id="lbldistributionstartdate" name="lbldistributionstartdate"><s:property value="lbldistributionstartdate"/></label></td>
  </tr>
  <tr>
   <td align="left">Description</td>
   <td>: <label id="lbldistributiondescription" name="lbldistributiondescription"><s:property value="lbldistributiondescription"/></label></td>
   <td align="left">End Date </td>
   <td>: <label id="lbldistributionenddate" name="lbldistributionenddate"><s:property value="lbldistributionenddate"/></label></td>
  </tr>
</table><br/>
</fieldset><br/>

<div id="firstdiv" hidden="true" >
<fieldset>
<table id="distribution" style="border-collapse: collapse;" width="95%" >
	<thead>
  	<tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    	<th width="10%" align="center" style="border-collapse: collapse;" ><b>Sl No</b></th>
    	<th width="25%" align="left" style="border-collapse: collapse;"><b>Date</b></th>
    	<th width="33%" align="right" style="border-collapse: collapse;"><b>Amount</b></th>
    	<th width="32%" align="center" style="border-collapse: collapse;"><b>Posted</b></th>
  	</tr>
  	</thead>
  	<tbody>
  <tr>
      <td colspan="4"><hr noshade size=1 color="#e1e2df"   width="100%"></td>
  </tr>
    <%int j=0,k=0; %>
    <s:iterator var="stat" value='#request.printdistribution' >
   <%k=k+1;j=0;%>
	<tr height="20">   
		<td width="10%" align="center"><%=k%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==0){%>
    	<td align="left">
		    <s:property value="#des"/>
  		</td>
  		<% } else if(j==1){%>
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
</div>

</form>
</div>
</body>
</html>
