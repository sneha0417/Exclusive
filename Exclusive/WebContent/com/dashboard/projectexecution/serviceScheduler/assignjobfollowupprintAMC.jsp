<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

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

legend{
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
hr { 
   		border-top: 1px solid #e1e2df  ;
    }

   
.verticalLine {
    border-left: 1px solid black;
}
tr {
     border-style:none;
   }
   
   .pagebreak { page-break-before: after; } 
   
    table { page-break-inside:auto }
    tr    { page-break-inside:avoid; page-break-after:auto }
    thead { display:table-header-group }
    tfoot { display:table-footer-group }
   
   
</style>



</head>
<body style="font-size:10px;background-color:white;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="clientfollowup" action="printclientfollowup" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeaderAAA.jsp"></jsp:include>
<PRE>





</PRE>

<h1 ALIGN="center"><u>WORK ORDER</u></h1>

<table align="center" width="85%" border="3" cellpadding="5"  >

        
         
         <tr>
         <td colspan="2">
         <table  width="100%">
         
         
         <tr><td width="12%"><label class="branch"><b>Client Name:</b></label>&nbsp;</td>
         <td width="38%">&nbsp;<label id="lblclname" name="lblclname" ><s:property value="lblclname"/></label></td>
         <td width="14%"><label class="branch"><b>Date:</b></label>&nbsp;</td>
         <td width="36%">&nbsp;<label id="lbljobdat" name="lbljobdat" ><s:property value="lbljobdat"/></label></td>
         </tr>
         
         <tr><td width="12%"><label class="branch"><b>Site Details:</b></label>&nbsp;</td>
         <td width="38%">&nbsp;<label id="lblsite" name="lblsite" ><s:property value="lblsite"/></label></td>
         <td width="14%"><label class="branch"><b>SJOB No:</b></label>&nbsp;</td>
         <td width="36%">&nbsp;<label id="lbldocnno" name="lbldocnno" ><s:property value="lbldocnno"/></label></td>
         
         </tr>
         
         <tr><td width="12%"><label class="branch"><b>Type of Work:</b></label>&nbsp;</td>
         <td width="38%">&nbsp;<label id="lblamc" name="lblamc" ><s:property value="lblamc"/></label></td>
         <td width="14%"><label class="branch"><b>Schedule No:</b></label>&nbsp;</td>
         <td width="36%">&nbsp;<label id="lblschno" name="lblschno" ><s:property value="lblschno"/></label></td>
         </tr>
         
         <tr><td width="12%"><label class="branch"><b>Area:</b></label></label>&nbsp;</td>
         <td width="38%">&nbsp;<label id="lblassngrp" name="lblassngrp" ><s:property value="lblassngrp"/></label></td>
         <td width="14%"><label class="branch"><b>Client LPO No:</b></label></label>&nbsp;</td>
         <td width="36%">&nbsp;<label id="lblclientlpo" name="lblclientlpo" ><s:property value="lblclientlpo"/></label></td>
         </tr>
         
             
         </table>
         </td>
         </tr>
         <tr>
         <td colspan="2">
         <label class="branch"><b><u>Work Description</u></b><br>
        <br>
         <label id="description" name="description" ><s:property value="description"/></label>
         </td>
         </tr>
         
      </table>
	     
 
<div id="firstdiv" >
<table id="client" width="85%" class="tablereceipt" align="center">
  <thead>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="12%" align="center">Sr.No</th>
   <!--  <th class="tablereceipt" width="9%" align="left">Site</th> -->
    <th class="tablereceipt" width="53%" align="left">Description</th>
   <!--  <th class="tablereceipt" width="15%" align="left">Remarks</th>
    <th class="tablereceipt" width="9%" align="left">Quantity</th> -->
     <th class="tablereceipt" width="35%" align="left">Service Details</th>
     
    
   
  </tr>
</thead>
<tbody>
  <%int l=0; %>
  <s:iterator var="stat" value='#request.amcgrid' >
  <%l=l+1;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="12%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">
    		<td class=tablereceipt align="left">
		    <s:property value="#des"/>
    	</td>
    	
 		</s:iterator>
	</tr>
	</s:iterator>
	</tbody>
</table><br/>
</div>
<br/>


<table width="85%" class="tablereceipt" style="border:1 px solid black;"  align="center">
<tr>
<td width="15%"  align="left"  class="tablereceipt" style="padding-bottom:15px;padding-top:15px;">Invoice Details</td>
<td width="85%"><label id="paydescription" name="paydescription" ><s:property value="paydescription"/></label></td>
</tr>


</table>
<br>
<table  id="client" width="85%" class="tablereceipt" align="center">
<thead>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="8%" align="center">Sr.No</th>
    <th class="tablereceipt" width="33%" align="left">Type of Document</th> 
    <th class="tablereceipt" width="29%" align="left">Received</th>
    <th class="tablereceipt" width="30%" align="left">Not Received</th>
  
   </tr>
   <tr>
   <td class="tablereceipt" width="8%" align="center">1</td>
   <td  class="tablereceipt" width="33%" align="left">WORK COMPLETION REPORT</td>
   <td class="tablereceipt" width="29%" align="left">&nbsp;</td>
   <td class="tablereceipt" width="30%" align="left">&nbsp;</td>
   </tr>
   <tr>
    <td class="tablereceipt" width="8%" align="center">2</td>
    <td  class="tablereceipt" width="33%" align="left">MATERIAL REQUEST FORM</td>
    <td class="tablereceipt" width="29%" align="left">&nbsp;</td>
    <td class="tablereceipt" width="30%" align="left">&nbsp;</td>
   </tr>
   <tr>
    <td class="tablereceipt" width="8%" align="center">3</td>
    <td  class="tablereceipt" width="33%" align="left">LOCATION SHEET</td>
    <td class="tablereceipt" width="29%" align="left">&nbsp;</td>
    <td class="tablereceipt" width="30%" align="left">&nbsp;</td>
   </tr>
</thead>
</table>

<div class="pagebreak"></div>
<br>
<table  width="85%" style=" border:1 px solid black;"  align="center">
<tr>
<td colspan="4" class="tablereceipt"  align="left" style="padding-bottom:25px;">Remarks</td>
</tr>
</table>

<br>

<table  id="client" width="85%" class="tablereceipt" align="center">
<thead>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="23%" align="left">Prepared by</th>
    <th class="tablereceipt" width="28%" align="left">Verified by Service engineer</th> 
    <th class="tablereceipt" width="27%" align="left">Received By</th>
    <th class="tablereceipt" width="22%" align="left">Approved by</th>
  
   </tr>
   <tr style="padding-top:3%;">
   <td class="tablereceipt" width="23%" height="20%" align="left"><br>Name................<br><br>Signature..............<br><br></td>
   <td  class="tablereceipt" width="28%" height="20%" align="left"><br>Name................<br><br>Signature..............<br><br></td>
   <td class="tablereceipt" width="27%" height="20%" align="left"><br>Name................<br><br>Date....................<br><br>Signature..............<br><br></td>
   <td class="tablereceipt" width="22%" height="20%" align="left">&nbsp;</td>
   </tr>
  </thead>
  </table>

<br>

<table width="95%" align="center">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by  <%=session.getAttribute("USERNAME")%>
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>
</div>
</form>
</div>
</body>
</html>