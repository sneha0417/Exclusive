<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>  
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }

 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
body {
    background-color: white;
}
</style> 
<script type="text/javascript">
$(document).ready(function ()
		 {
	document.getElementById("accidentfield").style.display="none";
	document.getElementById("existingfield").style.display="none";
	document.getElementById("newfield").style.display="none";
	if(document.getElementById("lblaccident").innerText=="1"){
		document.getElementById("accidentfield").style.display="block";
	}
	if(document.getElementById("lblhidexisting").innerText=="1"){
		document.getElementById("existingfield").style.display="block";
	}
	if(document.getElementById("lblhidnew").innerText=="1"){
		document.getElementById("newfield").style.display="block";
	}
	document.getElementById("lblurl").innerText=window.location.origin;
	
		 }); 
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmInspectionPrint").submit(); 
	
}
</script>
<style>
img{
float:right;
}
</style>
</head>
<body onload="" bcolor="white">
<div id="mainBG" class="homeContent" data-type="background"  style="background-color:white;">
<form id="frmInspectionPrint" action="inspectionPrint" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
<fieldset>
<table width="100%" >
  <tr>
    <td width="23%" align="left">Ref Type</td>
    <td width="50%" align="left">:
      <label name="lblreftype" id="lblreftype">
        <s:property value="lblreftype"/>
      </label></td>
    <td width="13%" align="left">Doc No</td>
    <td width="14%" align="left">:
      <label name="lbldocno" id="lbldocno">
        <s:property value="lbldocno"/>
      </label></td>
    </tr>
  <tr>
    <td align="left">Ref Doc Details</td>
    <td align="left">:
      <label name="lblrefdocno" id="lblrefdocno">
        <s:property value="lblrefdocno"/>
      </label></td>
    <td align="left">Date</td>
    <td align="left">:<label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></td>
  </tr>
  <tr>
    <td align="left">Ref Fleet</td>
    <td align="left">:
      <label name="lblreffleetno" id="lblreffleetno">
        <s:property value="lblreffleetno"/>
      </label></td>
    <td align="left">Time</td>
    <td align="left">:<label name="lbltime" id="lbltime"><s:property value="lbltime"/></label></td>
  </tr>
  <tr>
    <td align="left">Chargeable Amount</td>
    <td align="left">:<label name="lblamount" id="lblamount"><s:property value="lblamount"/></label></td>
    <td align="left">Type</td>
    <td align="left">:<label name="lbltype" id="lbltype"><s:property value="lbltype"/></label></td>
  </tr>
  
</table>
</fieldset>
<table width="100%" >
  <tr>
   
  </tr>
</table>

<div  id="accidentfield">
  <fieldset><legend><b>Accident Details</b></legend>
<table width="100%">
  <tr>
    <td width="6%" align="left">Date</td>
    <td width="15%" align="left">:<label name="lblaccdate" id="lblaccdate"><s:property value="lblaccdate"/></label></td>
    <td width="12%" align="left">Police Report</td>
    <td width="9%" align="left">:<label name="lblprcs" id="lblprcs"><s:property value="lblprcs"/></label></td>
    <td width="9%" align="left">Coll Date</td>
    <td width="11%" align="left">:<label name="lblcoldate" id="lblcoldate"><s:property value="lblcoldate"/></label></td>
    <td width="6%" align="right">Place</td>
    <td width="10%" align="left">:<label name="lblplace" id="lblplace"><s:property value="lblplace"/></label></td>
    <td width="4%" align="left">Fines</td>
    <td width="6%" align="left">:<label name="lblfines" id="lblfines"><s:property value="lblfines"/></label></td>
    <td width="5%" align="left">Claim</td>
    <td width="7%" align="left">:<label name="lblclaim" id="lblclaim"><s:property value="lblclaim"/></label></td>
    <label name="lblaccident" id="lblaccident" hidden="true"><s:property value="lblaccident"/></label>
  </tr>
  <tr>
    <td align="left">Remarks</td>
    <td colspan="11" align="left">:
      <label name="lblremarks" id="lblremarks">
        <s:property value="lblremarks"/>
      </label></td>
    </tr>
</table>
 </fieldset>
 </div>
 <div id="existingfield">
 <fieldset><legend><b>Existing Damages</b></legend>
 <table width="100%" >
 <thead>
 <tr>
 <th align="left" style="width:10%;">Sr No</th> 
 <th align="left" style="width:10%;">Code</th>
 <th align="left" style="width:30%;">Description</th>
 <th align="left" style="width:10%;">Type</th>
 <th align="left" style="width:40%;">Remarks</th>
 </tr>
 </thead>
 <tbody>
 <s:iterator var="stat" value='#request.EXISTINGDAMAGEPRINT' >
<tr>   

    <s:iterator status="arr" value="#stat.split('::')" var="des">   

  	

  		<td  align="left">

 	 		<s:property value="#des"/>

  		</td>

 	</s:iterator>

</tr>

</s:iterator>

  </tbody>
</table>
</fieldset>
</div>
<div id="newfield">
<fieldset><legend><b>New Damages</b></legend>
<table width="100%" >
<thead>
 <tr>
 <th align="left" style="width:10%;">Sr No</th> 
 <th align="left" style="width:10%;">Code</th>
 <th align="left" style="width:30%;">Description</th>
 <th align="left" style="width:10%;">Type</th>
 <th align="left" style="width:40%;">Remarks</th>
 </tr>
 </thead>

<tbody>
 <s:iterator var="stat1" value='#request.NEWDAMAGEPRINT' >
<tr>   

    <s:iterator status="arr1" value="#stat1.split('::')" var="des1">   

  	

  		<td  align="left">
  		
  		<s:if test="#arr1.index<5">
	
 	 		<s:property value="#des1"/>
			</s:if>
  		</td>

 	</s:iterator>

</tr>
</s:iterator>
  </tbody>

</table>
</fieldset>
</div>
<div align="left">
<img src='<s:property value="#statpic"/>'  height="25%" width="25%">
</div>
<br>

<s:iterator var="statpic" value="#request.NEWDAMAGEPRINTPICS">
<img src='<s:property value="#statpic"/>'  height="25%" width="25%">
</s:iterator>
<center>
  <label style="color: #D8D8D8;"><b>Powered by GATEWAY ERP</b></label></center>
  <label name="lblhidexisting" id="lblhidexisting" hidden="true"><s:property value="lblhidexisting"/></label>
  <label name="lblhidnew" id="lblhidnew" hidden="true"><s:property value="lblhidnew"/></label>
  <label name="lblurl" id="lblurl" hidden="true"><s:property value="lblurl" /></label>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</form>
</div>
</body>
</html>
