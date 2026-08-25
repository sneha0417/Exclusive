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
 
legend {
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
    
 hr { 
   	   border-top: 1px solid #000000  ;
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
<%-- <jsp:include page="../../../common/printHeader.jsp"></jsp:include> --%>
<table width="100%" class="normaltable">
<%-- <center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center> --%>
  
   <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
     <tr><td>&nbsp;</td></tr> 
     <tr><td>&nbsp;</td></tr>
      <tr><td>&nbsp;</td></tr>
     <tr><td>&nbsp;</td></tr>  
  <tr>
  <td align="center" colspan="4"><font size="6"><b><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></b></font></td>
  </tr>
  
  <tr>
  	<td width="7%" align="left">Location </td>
  	<td width="59%" align="left"><label id="lbllocation" name="lbllocation" >: <s:property value="lbllocation"/></label></td>
 	<td width="7%" align="left"> <b>TRN</b></td>
  	<td width="27%" align="left"><b>: <label id="lblcomptrn" name="lblcomptrn" ><s:property value="lblcomptrn"/></label></b></td>
  </tr>
  
  <tr>
  	<td align="left">Branch </td>
  	<td colspan="3" align="left"><label id="lblbranch" name="lblbranch" >: <s:property value="lblbranch"/></label></td>
  </tr>
 
  </table>


</div> 
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>

</div>

<fieldset>
  <table width="100%">
  <tr>
    <td align="right"><table width="100%">
      <tr></tr>
      <tr>
      <tr>
        <td width="8%" align="left">Customer </td>
        <td colspan="3">:
          <label id="lblaccountname" name="lblaccountname">
            <s:property value="lblaccountname"/>
          </label></td>
        <td width="6%" align="right">&nbsp;</td>
        <td width="7%" align="left">INV No </td>
        <td width="27%">:
          <label name="lbldocumentno" id="lbldocumentno" >
            <s:property value="lbldocumentno"/>
          </label>
          <%-- <label name="lblinvtype" id="lblinvtype" >(<s:property value="lblinvtype"/>)</label>--%></td>
      </tr>
      <tr>
        <td align="left">Code </td>
        <td width="26%">:
          <label id="lblcustcodeno" name="lblcustcodeno" >
            <s:property value="lblcustcodeno"/>
          </label></td>
        <td width="12%" align="left">&nbsp;</td>
        <td width="14%"></td>
        <td align="right">&nbsp;</td>
        <td align="left">Date</td>
        <td>:
          <label name="lbldate" id="lbldate" >
            <s:property value="lbldate"/>
          </label></td>
      </tr>
      <tr>
        <td align="left">Address </td>
        <td colspan="3">:
          <label name="lblcustaddress" id="lblcustaddress" >
            <s:property value="lblcustaddress"/>
          </label></td>
      <tr>
        <td align="left">TRN</td>
        <td>:
          <label name="lblclienttrno" id="lblclienttrno" >
            <s:property value="lblclienttrno"/>
          </label></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="left">Mobile </td>
        <td>:
          <label name="lblcustmobno" id="lblcustmobno" >
            <s:property value="lblcustmobno"/>
          </label></td>
      </tr>
      <tr>
        <td align="left"> Phone </td>
        <td>:
          <label name="lblcustphno" id="lblcustphno" >
            <s:property value="lblcustphno"/>
          </label></td>
      </tr>
      <tr>
        <td align="left">Description</td>
        <td colspan="3">:
          <label id="lbldescription" name="lbldescription">
            <s:property value="lbldescription"/>
          </label></td>
      </tr>
    </table></td>
  </tr>
  </table>
  <br/>
</fieldset>
  
<div id="firstdiv" hidden="true" >
<fieldset>

<table id="accounting" style="border-collapse: collapse;" width="97%" align="center">
  <thead>
  <tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
    <th width="5%" align="center" style="border-collapse: collapse;"><b>Sl No</b></th>
    <th width="30%" align="left" style="border-collapse: collapse;"><b>Charge Description</b></th>
    <th width="7%" align="right" style="border-collapse: collapse;"><b>Amount</b></th> 
    
  </tr>
  </thead>
  <tbody>
  <tr>
      <td colspan="7"><hr noshade size=1 color="#e1e2df" width="100%"></td>
  </tr>
    <%int i=0,l=0; %>
    <s:iterator var="stat" value='#request.printingarray1' >
   <%l=l+1;i=0;%>
	<tr height="20">   
		<td width="5%" align="center"><%=l%></td>
    	<s:iterator status="arr" value="#stat.split('::')" var="des">   
    	<% if(i==1 || i==2){%>
    	<td align="right">
		    <s:property value="#des"/>
    	</td>
     	<%} else if(i>3){%>
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
	</tbody>	

</table>
</fieldset>
</div>
<div>
<hr>
<table width="98%" >
  <tr>
    <td width="132" align="left">Total </td>
    <td width="8" align="right">:</td>
    
    <td  width="884" align="right"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
  </tr>
  
  <tr>
    <td align="left">Amount In Words  </td>
    <td align="right">:</td>
    <td colspan="3" align="right"><label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></td>
    </tr>
</table>
<hr>
</div>
<div id="bottompage">
<table width="100%" >
  <tr>
    <td width="13%">Checked By</td>
    <td width="24%"><label id="lblpreparedby" name="lblpreparedby"><s:property value="lblpreparedby"/></label></td>
    <td width="14%">Received By</td>
    <td width="30%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="5%">Date</td>
    <td width="14%"><label id="currentdate" name="currentdate"><s:property value="currentdate"/></label></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
</table>
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
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
</div>

</form>
</div>
</body>
</html>
