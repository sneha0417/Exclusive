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
<form id="frmprintDeduction" action="printDeduction" method="post" autocomplete="off" target="_blank">

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
    <td width="2%" align="left"><b>Date</b></td>
    <td width="22%">: <label name="deductionScheduleDate" id="deductionScheduleDate" ><s:property value="deductionScheduleDate"/></label></td>
  </tr>
  <tr>
    <td width="2%" align="left"><b>Doc No </b></td>
    <td width="22%">: <label name="txtdeductionscheduledocno" id="txtdeductionscheduledocno" ><s:property value="txtdeductionscheduledocno"/></label></td></tr>
    <tr><td width="2%" align="left"><b>Ref No</b></td>
    <td colspan="3">: <label name="txtemployeerefno" id="txtemployeerefno" ><s:property value="txtemployeerefno"/></label></td>
  </tr>
  <tr>
    <td width="2%" align="left"><b>Employee Details </b></td>
    <td>: <label name="txtemployeedetails" id="txtemployeedetails" ><s:property value="txtemployeedetails"/></label></td>
    
  </tr>
  
</table><br/>
</fieldset><br/>

<div id="firstdiv" hidden="true" >
<fieldset>
<legend>Accounts</legend>
<table id="applying" style="border-collapse: collapse;" width="100%">
<thead>
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="12%" align="center" style="border-collapse: collapse;"><b>Account No</b></th>
    <th width="38%" align="left" style="border-collapse: collapse;"><b>Account Name</b></th>
    <th width="20%" align="right" style="border-collapse: collapse;"><b>Debit</b></th>
    <th width="20%" align="right" style="border-collapse: collapse;"><b>Credit</b></th> 
  </tr>
</thead>
<tbody>
  <tr>
      <td colspan="4"><hr noshade size=1   color="#e1e2df"   width="100%"></td>
  </tr>
    <%int j=0; %>
    <s:iterator var="stat" value='#request.printaccounting' >
   <%j=0;%>
	<tr height="20">   
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(j==1){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(j>1){%>
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
<tr><td colspan="4"><hr noshade size=1 color="#e1e2df" width="100%"></td></tr>
<tr>
		<td align="right" colspan="2"><b>Total </b>&nbsp;</td>
        <td width="8%" align="right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
        <td width="7%" align="right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
</tr>
</table><br/>
</fieldset>
</div><br/>
 
<div id="secdiv" hidden="true" > 
<fieldset>
<legend>Details</legend>
<table id="accounting" style="border-collapse: collapse;" width="100%">
  <thead>
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="5%" align="center" style="border-collapse: collapse;"><b>Sl No</b></th>
    <th width="52%" align="left" style="border-collapse: collapse;">&nbsp;</th>
    <th width="15%" align="right" style="border-collapse: collapse;"><b>Gratuity</b></th>
    <th width="15%" align="right" style="border-collapse: collapse;"><b>Leave Salary</b></th>
    <th width="15%" align="right" style="border-collapse: collapse;"><b>Travels</b></th> 
  </tr>
  </thead>
  <tbody>
  <tr>
      <td colspan="5"><hr noshade size=1 color="#e1e2df" width="100%"></td>
  </tr>
    <%int i=0,l=0; %>
    <s:iterator var="stat" value='#request.printingarray' >
   <%l=l+1;i=0;%>
	<tr height="20">   
		<td width="5%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==0){%>
    	<td align="left">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>0){%>
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
</table><br/>
</fieldset>
</div><br/>

<table id="preparedby" width="100%" class="tablereceipt">
<tr>
<td width="50%">
<table width="100%">
  <!-- <tr>
    <td width="39%" align="left" height="25"><b>Prepared</b></td>
    <td width="35%" align="center"><b>Verified</b></td>
    <td width="26%" align="center"><b>Approved</b></td>
  </tr> -->
  <tr>
    <td width="4%" align="left"><b>Amount</b></td>
    <td width="22%">: <label name="txtamount" id="txtamount" ><s:property value="txtamount"/></label></td>
    <%-- <td><b>Amount </b>&nbsp;<label name="txtamount" id="txtamount" ><s:property value="txtamount"/></label></td> --%>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <br>
  <tr>
    <td width="4%" align="left"><b>Inst Nos</b></td>
    <td width="22%">: <label name="txtinstnos" id="txtinstnos" ><s:property value="txtinstnos"/></label></td>
    <%-- <td><b>Inst Nos</b>&nbsp;<label name="txtinstnos" id="txtinstnos" ><s:property value="lblpreparedon"/></label></td> --%>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <br>
  <tr>
    <td width="4%" align="left"><b>Start Date</b></td>
    <td width="22%">: <label name="startDate" id="startDate" ><s:property value="startDate"/></label></td>
    <%-- <td><b>Start Date</b>&nbsp;<label name="startDate" id="startDate" ><s:property value="startDate"/></label></td> --%>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <br>
  <tr>
    <td width="4%" align="left"><b>Description</b></td>
    <td width="22%">: <label name="txtdescription" id="txtdescription" ><s:property value="txtdescription"/></label></td>
    <%-- <td><b>Description</b>&nbsp;<label name="txtdescription" id="txtdescription" ><s:property value="txtdescription"/></label></td> --%>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</td>

<td width="50%" class="tablereceipt">
<%-- <table width="100%">
  <tr>
    <td width="39%" align="left" height="25"><b>Sr.No</b></td>
    <td width="35%" align="center"><b>Date</b></td>
    <td width="26%" align="center"><b>Amount</b></td>
  </tr>
  <tr>
    <td width="39%" align="left"> <label name="srno" id="srno" ><s:property value="srno"/></label></td>
    <td width="35%" align="center"> <label name="date" id="date" ><s:property value="date"/></label></td>
    <td width="26%"align="center"> <label name="amount" id="amount" ><s:property value="amount"/></label></td>
  </tr>
</table> --%>
<table style="border-collapse: collapse;" width="100%"  >

 <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <td align="left" style="border-collapse: collapse;"><b>Sl No</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Date</b></td>
    <td align="left" style="border-collapse: collapse;"><b>Amount</b></td>
  </tr>

<s:iterator var="stat" value='#request.details' >
<tr>   
<%int m=0; %>
    <s:iterator status="arr" value="#stat.split('::')" var="des1">   
    <%
    if(m>1){%>
    
  <td  align="left" >
  <s:property value="#des1"/>
  </td>
   <%} else{ %>
    
  <td  align="left" >
  <s:property value="#des1"/>
  </td>
  <% } m++;  %>
 </s:iterator>
</tr>
</s:iterator>

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
