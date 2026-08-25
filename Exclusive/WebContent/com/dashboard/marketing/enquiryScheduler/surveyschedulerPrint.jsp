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

</style>



</head>
<body style="font-size:10px;background-color:white;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="clientfollowup" action="printclientfollowup" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="printHeader.jsp"></jsp:include>

<table width="96%" align="center">
<tr><td>

<table width="98%" align="center">
  <tr>
    <td width="16%" align="left"><b>Doc.No</b> </td>
    <td colspan="2"><b>:</b> <label id="lbldocno" name="lbldocno"><s:property value="lbldocno"/></label></td>
    <td width="18%" align="left"><b>Date Assigned</b> </td>
    <td width="20%"> <b>:</b> <label name="lbldate" id="lbldate" ><s:property value="lbldate"/></label></td>
  </tr>
<tr><td>
<pre>
</pre>

</td></tr>
  <tr>
    <td align="left"><b>Customer Name</b> </td>
    <td colspan="2"><b>:</b> <label name="lblcusname" id="lblcusname" ><s:property value="lblcusname"/></label></td>
    <td align="left"><b>Deadline</b> </td>
    <td colspan="3"><b>:</b> <label name="lbl" id="lbl" ><s:property value="lbl"/></label></td>
    </tr>
    <tr>
    <td align="left"><b>Addrss.</b> </td>
    <td>: <label name="lbladdrs" id="lbladdrs" ><s:property value="lbladdrs"/></label></td>
  </tr>
  
  <tr width="100%">
    <td align="left"><b>Contact Person.</b> </td>
    <td colspan="3"><b>:</b> <label id="lblconper" name="lblconper" ><s:property value="lblconper"/></label></td>
    <td colspan="2"></td>
    </tr>
    
    <tr width="100%">
    <td align="left"><b>Contact Nos..</b> </td>
    <td colspan="3"><b>:</b> <label id="lblconnum" name="lblconnum" ><s:property value="lblconnum"/></label></td>
    <td colspan="2"></td>
    </tr>

<tr>
<td><pre>
</pre></td>
</tr>


</table>

</td></tr>
<tr><td>
<table style="width:100%"  align="center"  border="1" cellspacing="0" cellpadding="4">

<tr>
 <td align="left" colspan="1" width="15%"><b>Surveyed By:</b> </td>
 <td> <label id="lblsurveyed" name="lblsurveyed" ><s:property value="lblsurveyed"/></label></td>
 <td align="left" colspan="1" width="15%"><b>Signature</b> </td>
 <td> <label id="signature" name="signature" ><s:property value="signature"/></label></td>
 </tr>
 </table>
 <table>
 <tr>
 <td align="left" colspan="1" width="20%"><b>Surveyed Date:</b> </td>
 <td> <label id="survdate" name="survdate" ><s:property value="survdate"/></label></td>
 </tr>
 </table>
</td></tr>
<tr><td>
<pre>
</pre>
</td></tr>

<tr>
<td><h3>EXISTING CONTRACTOR/PREVIOUS VENDOR DETAILS</h3></td>
</tr>
<tr>
<td>
<table style="width:100%"  align="center"  border="1" cellspacing="0" cellpadding="10">
<tr> 
 <td> <label id="lblcontr" name="lblcontr" ><s:property value="lblcontr"/></label></td>
 </tr>
 
 </table>
 </td>
</tr>

<tr>
<td><h3>LOCATION:</h3></td>
</tr>
<tr>
<td>
<table style="width:100%"  align="center"  border="1" cellspacing="0" cellpadding="10">
<tr> 
 <td> <label id="lbllocn" name="lbllocn" ><s:property value="lbllocn"/></label></td>
 </tr>
 
 </table>
 </td>
</tr>

<tr>
<td><h3>SERVICES:</h3></td>
</tr>
<tr>
<td>
<table style="width:100%"  align="center"  border="1" cellspacing="0" cellpadding="10">
<tr> 
 <td> <label id="lblservice" name="lblservice" ><s:property value="lblservice"/></label></td>
 </tr>
 
 </table>
 </td>
</tr>

<tr>
<td><h3>REMARKS/COMMENTS:</h3></td>
</tr>
<tr>
<td>
<table style="width:100%"  align="center"  border="1" cellspacing="0" cellpadding="10">
<tr> 
 <td> <label id="lblremarks" name="lblremarks" ><s:property value="lblremarks"/></label></td>
 </tr>
 
 </table>
 </td>
</tr>
</table>



<br/>

<table width="95%" align="center">

<tr><td><h3>Warehouse-AMC:</h3></td></tr></table>

<div id="firstdiv" >
<table id="wrhse" width="95%" class="tablereceipt" align="center">

  <thead>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
       <th class="tablereceipt" width="5%" align="center">Sr.No</th>
    <th class="tablereceipt" width="45%" align="left">Specification</th>
    <th class="tablereceipt" width="50%" align="left">Description</th>
   
  </tr>
</thead>
<tbody>
  <%int l=0; %>
  <s:iterator var="stat" value='#request.printclientarray' >
  <%l=l+1;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="4%" align="center"><%=l%></td>
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

<table width="95%" align="center">

<tr><td><h3>Building-AMC:</h3></td></tr></table>

<div id="seconddiv" >
<table id="client" width="95%" class="tablereceipt" align="center">

  <thead>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
       <th class="tablereceipt" width="5%" align="center">Sr.No</th>
    <th class="tablereceipt" width="45%" align="left">Specification</th>
    <th class="tablereceipt" width="50%" align="left">Description</th>
   
  </tr>
</thead>
<tbody>
  <%int j=0; %>
  <s:iterator var="stat" value='#request.printclientarray1' >
  <%j=j+1;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="4%" align="center"><%=j%></td>
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
<br/>
<table width="95%" align="center">

<tr><td><h3>Project:</h3></td></tr></table>

<div id="tddiv" >
<table id="client" width="95%" class="tablereceipt" align="center">

  <thead>
  
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="5%" align="center">Sr.No</th>
    <th class="tablereceipt" width="45%" align="left">Specification</th>
    <th class="tablereceipt" width="50%" align="left">Description</th>
   
   
  </tr>
</thead>
<tbody>
  <%int k=0; %>
  <s:iterator var="stat" value='#request.printclientarray2' >
  <%k=k+1;%>
	<tr height="25" class=tablereceipt> 
	    <td class="tablereceipt" width="4%" align="center"><%=k%></td>
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
<table width="95%" align="center">
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
</div>
</form>
</div>
</body>
</html>