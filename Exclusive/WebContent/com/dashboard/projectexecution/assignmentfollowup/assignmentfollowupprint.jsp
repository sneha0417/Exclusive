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
</style>



</head>
<body style="font-size:10px;background-color:white;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="clientfollowup" action="printclientfollowup" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">

<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
<PRE>





</PRE>

<table align="center" width="85%" border="3" cellpadding="5"  >

        
         
         <tr>
         <td colspan="2">
         <table  width="100%">
         <tr><td colspan="3" align=left>
         <label id="lblamc" name="lblamc" ><s:property value="lblamc"/></label>:<label id="lbldocnno" name="lbldocnno" ><s:property value="lbldocnno"/></label></td></tr>
         
         <tr><td colspan="3" align=left>
         <label class="branch"><b>Job Date</b></label>:&nbsp;<label id="lbljobdat" name="lbljobdat" ><s:property value="lbljobdat"/></label></td></tr>
         
         <tr><td colspan="3" align=left>
         <label class="branch"><b>Ref.</b></label>:&nbsp;<label id="lblrefno" name="lblrefno" ><s:property value="lblrefno"/></label></td></tr>
         
         <tr><td width="30%"><label class="branch"><b>Client Name</b></label>&nbsp;</td>
         <td width="5%">:</td>
         <td width="65%">&nbsp;<label id="lblclname" name="lblclname" ><s:property value="lblclname"/></label></td></tr>
         
         <tr><td width="30%"><label class="branch"><b>Site Details</b></label>&nbsp;</td>
         <td width="5%">:</td>
         <td width="65%">&nbsp;<label id="lblsite" name="lblsite" ><s:property value="lblsite"/></label></td></tr>
         
         <tr><td width="30%"><label class="branch"><b>Engg.Contact Person</b></label>&nbsp;</td>
         <td width="5%">:</td>
         <td width="65%">&nbsp;<label id="lblcntprsn" name="lblcntprsn" ><s:property value="lblcntprsn"/></label></td></tr>
         
         <tr><td width="30%"><label class="branch"><b>Contact  Number</b></label></label>&nbsp;</td>
         <td width="5%">:</td>
         <td width="65%">&nbsp;<label id="lblcontact" name="lblcontact" ><s:property value="lblcontact"/></label></td></tr>
         
         <tr><td width="30%"><label class="branch"><b>Service Type</b></label></label>&nbsp;</td>
         <td width="5%">:</td>
         <td width="65%">&nbsp;<label id="lblstype" name="lblstype" ><s:property value="lblstype"/></label></td></tr>
         
         
         </table>
         </td>
         </tr>
         <tr>
         <td colspan="2">
         <label class="branch"><b><u>Work Description</u></b></label><label id="description" name="description" ><s:property value="description"/></label><br>
        <br>
         <label id="lblamc" name="lblamc" ><s:property value="lblamc"/></label>
         </td>
         </tr>
         
      </table>
	     
 
<div id="firstdiv" >
<table id="client" width="85%" class="tablereceipt" align="center">
  <thead>
  <tr height="28" style="background-color: #D8D8D8;" class="tablereceipt" align="center">
    <th class="tablereceipt" width="4%" align="center">Sr.No</th>
    <th class="tablereceipt" width="9%" align="left">Site</th>
    <th class="tablereceipt" width="9%" align="left">Description</th>
    <th class="tablereceipt" width="15%" align="left">Remarks</th>
    <th class="tablereceipt" width="9%" align="left">Quantity</th>
     <th class="tablereceipt" width="9%" align="left">Service Type</th>
     
    
   
  </tr>
</thead>
<tbody>
  <%int l=0; %>
  <s:iterator var="stat" value='#request.printschedulerarray' >
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


<br/>

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