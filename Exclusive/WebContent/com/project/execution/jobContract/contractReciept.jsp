
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">

<style media="all">

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
 .saliktable{
 border:1px solid;
 border-collapse:collapse;

 }
 
 table:last-of-type {
    page-break-after: auto
}

.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

.verticalLine {
    border-left: 1px solid black;
}


#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
       
 P.breakhere {page-break-before: always}     
</style> 

 
<script>

function getPrint(){
	 document.getElementById("mode").value="print";
	document.getElementById("frmprintSJOBContract").submit(); 
}
function hidedata(){

	var header=document.getElementById("txtheader").value;
	
	if(parseInt(header)==1){
	
		 $("#headerdiv").show();
		 $("#withoutHeaderDiv").hide();
	}
	else{
		 $("#headerdiv").hide();
		 $("#withoutHeaderDiv").show();
	}
	

	}
	
function hidecheckbox(){
	
	var check=document.getElementById("islegaldoc").value;
	//alert("checkbox"+check);
	
	if(parseInt(check)==1) {
			$("#chrg").show();
		} else {
			$("#chrg").hide();
		}
	}
</script>
</head>
<body style="background-color:#fff !important;" bgcolor="white"  style="font-size:12px" onload="hidecheckbox();hidedata();">
<div id="mainBG" class="homeContent" data-type="background">

<jsp:include page="../../../../includes.jsp"></jsp:include>
<form id="frmprintSJOBContract" action="printJobContract" autocomplete="off" target="_blank" >

 <div id="headerdiv" style="background-color:white;" >
 <%-- <jsp:include page="../../../common/printHeader.jsp"></jsp:include>  --%>
 </div>
 <div id="withoutHeaderDiv"  style="height: 100px;" >
 <table width="100%">
 <tr>
 <td width="18%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="150" height="91"  alt=""/></td>
 </tr>
<tr>
<td width="35%" align="left"><b><font size="4"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b>
</td>
</tr>
</table>
</div>
<fieldset>
<table width="100%" >
  <tr>
    <td width="16%" align="left">Contract No </td>
    <td colspan="3">: <label id="docno" name="docno"><s:property value="docno"/></label></td>
    <td width="18%" align="left">Agreement Date</td>
    <td width="20%"> : <label name="date" id="date" ><s:property value="date"/></label></td>
  </tr>
  <tr>
    <td align="left"></td>
    <td width="18%"></td>
    <td colspan="2" align="center"><b>Between</b></td>
    <td align="left"></td>
   <td></td>
  </tr>
  <tr>
    <td align="left"></td>
    <td width="18%"><b><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></b></td>
    <td width="12%" align="left"></td>
    <td width="16%"></td>
    <td align="left"><b><label id="txtclient" name="txtclient" ><s:property value="txtclient"/></label></b></td>
    <td></td>
  </tr>
  <tr>
    <td align="left"></td>
    <td width="18%"><label id="lblcompaddress" name="lblcompaddress" ><s:property value="lblcompaddress"/></label></td>
    <td colspan="2" align="center"><b>And</b></td>
    <td align="left"><label id="txtclientdet" name="txtclientdet" ><s:property value="txtclientdet"/></label></td>
    <td width="16%"></td>
  </tr>
  <tr>

    <td align="left"></td>
    <td>(Being the First party and herin after called <label name="lblcompname" id="lblcompname" ><s:property value="lblcompname"/>)</label></td>
    <td align="left">&nbsp;</td>
    <td></td>
    <td align="left">(Being the 2nd party herein after called CLIENT)</td>
    <td></td>
  </tr>
  
   
</table>
</fieldset>
<s:if test="%{getSitelist().size()>0}">

<br>
<hr>

<fieldset><legend>Site Details</legend>

<table width="100%" style="border-collapse:collapse;" class="tablereceipt">

 <tr Style="background-color:#d8d8d8" class="tablereceipt">
    <td align="center" style="width:5%;"><strong>SI No</strong></td>
    <td align="center" style="width:45%;"><strong> Site</strong></td>
    <td align="center" style="width:45%;"><strong>Area</strong></td>
    
  </tr>
 
 <s:iterator var="stat1" status="arr" value='#request.SITELIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
		   
<tr class="tablereceipt">   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
   		<s:if test="#arr.index==0">
   		<td align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<td align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
   		<s:elseif test="#arr.index==2">
   		<td  align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
   		<s:else>
  <td  align="right"> 		
   		</s:else>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>

</fieldset>
</s:if>
<br>
<fieldset><legend>Payment Details</legend>
 <s:if test="%{getPaylist().size()>0}">	
 <table width="100%" style="border-collapse:collapse;" class="tablereceipt">

 <tr Style="background-color:#d8d8d8" class="tablereceipt">
    <td align="center" style="width:5%;"><strong>Sr.no</strong></td>
    <td align="center" style="width:15%;"><strong>Due Date</strong></td>
    <td align="right" style="width:30%;"><strong>Amount</strong></td>
    <td align="center" style="width:50%;"><strong>Description</strong></td>
   
  </tr>
 
 <s:iterator var="stat1" status="arr" value='#request.PAYLIST' >
	<s:iterator status="arr" value="#stat1" var="stat"> 
	<%-- <%k=k+1;
	%>  --%>  
		  
<tr class="tablereceipt">   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
   		<s:if test="#arr.index==0">
   		<td align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<td align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
   		<s:elseif test="#arr.index==2">
   		<td align="right" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
   		<s:elseif test="#arr.index==3">
   		<td align="center" class="tablereceipt">&nbsp;
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>
</s:if>
</fieldset>
<br>


<div id="chrg">
Dubai Civil Defence contract attestation charge AED <label name="temp1" id="temp1" ><s:property value="temp1"/> will be charged additional.<br>
Our offer price is exclusive of VAT.
</label>
</div>


<fieldset><legend>Service Details</legend>
   <s:if test="%{getSerlist().size()>0}">		
 <table width="100%" style="border-collapse:collapse;" class="tablereceipt">

 <tr Style="background-color:#d8d8d8" class="tablereceipt">
    <td align="center" style="width:5%;"><strong>SI No</strong></td>
    <td align="center" style="width:20%;"><strong> Services</strong></td>  
    <td align="center" style="width:55%;"><strong> Description</strong></td>
    <td align="center" style="width:10%;"><strong> Qty</strong></td> 
     
  </tr> 
 <s:iterator var="stat1" status="arr" value='#request.SERLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    
<%-- <%k=k+1;
%> --%>		   
<tr class="tablereceipt">   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
   		<s:if test="#arr.index==0 || #arr.index==1  || #arr.index==2  || #arr.index==4">
   		<s:if test="#arr.index==2">
   		<td align="left" class="tablereceipt">
   		</s:if>
   		<s:else>
   		<td align="center" class="tablereceipt">
   		</s:else>
   		
   		
   		<s:property value="#des"/>
   		</td>
   		</s:if><%-- 
   		<s:elseif test="#arr.index==1">
   		<td align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
   --%>
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
</table>
</s:if>
</fieldset>

<br>
<fieldset><legend>Schedule Details</legend>

<s:if test="%{getSchlist().size()>0}">		
 <table width="100%" style="border-collapse:collapse;" class="tablereceipt">

 <tr Style="background-color:#d8d8d8" class="tablereceipt">
    <td align="center" style="width:65%;"><strong></strong></td>
    <td align="center" style="width:35%;"><strong></strong></td>
   
  </tr>
 
 <s:iterator var="stat1" status="arr" value='#request.SCHLIST' >
	<s:iterator status="arr" value="#stat1" var="stat">    

<tr class="tablereceipt">   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
      
   		<s:if test="#arr.index==1">
   		<td align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:if>
   		<s:elseif test="#arr.index==2">
   		<td align="center" class="tablereceipt">
   		<s:property value="#des"/>
   		</td>
   		</s:elseif>
  
 </s:iterator>
</tr>
</s:iterator>
</s:iterator>
 
</table>
</s:if>
</fieldset>
<s:if test="%{getTermlist().size()>0}">
<br>
<hr>
<fieldset><legend><strong>Terms & Conditions</strong></legend>
<table width="100%">
 <tr>
    <td align="left" style="width:20%;"></td>
    <%-- <td align="center" style="width:25%;"><strong>Terms</strong></td>
    <td align="center" style="width:70%;"><strong>Conditions</strong></td>  --%>
  <s:set var="temp" value="1"></s:set>
  
<%int i=0; %>
 <%-- <%  int k=0; %> --%>
 <s:iterator var="stat1" status="arr" value='#request.TERMLIST' >
 
	<s:iterator status="arr" value="#stat1" var="stat">    
<%i=i+1;%>
<%-- <%k=k+1;
%>  --%>		   
<tr>   
     <s:iterator status="arr" value="#stat.split('::')" var="des">
     
     
   		<s:if test="#arr.index==0">
   		<th width="10%" align="left" ><s:property value="#des"/></th> 
   		</s:if>
   		<s:elseif test="#arr.index==1">
   		<tr>
   		<td><s:property value="#des"/></td>
   		</tr>
   		
   		</s:elseif>
   		<s:else>
  <td  align="left"><s:property value="#des"/></td> 		
   		</s:else>
   		
   
 </s:iterator>

</tr>
</s:iterator>
</s:iterator>
 
</table>
</fieldset>
</s:if>
<br>
<hr>
<br><br><br>
<%-- <table width="100%" >
  <tr>
    <td width="197" align="left">Total :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttotalamt" name="txttotalamt"><s:property value="txttotalamt"/></label></b></td>
  </tr>
 <tr>
    <td width="197" align="left">Tax :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txttaxamt" name="txttaxamt"><s:property value="txttaxamt"/></label></b></td>
  </tr>
  <tr>
    <td width="197" align="left">Discount :</td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="txtdisamt" name="txtdisamt"><s:property value="txtdisamt"/></label></b></td>
  </tr> 
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="txtnettotal" name="txtnettotal"><s:property value="txtnettotal"/></label><b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="amountwords" name="amountwords"><s:property value="amountwords"/></label></b></td>
    </tr>
</table> --%>

<hr>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Processed By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Recieved By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
   
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    
    </tr>
</table>
</div>
<br/><br/><br/><br/><br/><br/>
<div class="divFooter">
 
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
<input type="hidden" name="islegaldoc" id="islegaldoc" value='<s:property value="islegaldoc"/> '>
</div>
</form>

 <s:set name="counter" value="%{#counter+1}" />

</div>
</body>
</html>
