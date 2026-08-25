<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<s:iterator value='#request.TRIAL' var="#aa" status="arr">
<style type="text/css">

@media print {
@page {
    margin: 0; 
    margin-top: 0;
    margin-right: 0;
    size: <s:property value="lblpagesheight"/>in <s:property value="lblpageswidth"/>in;
    font-size: 50pt !important;    
  }    
body, fieldset {
    margin: 0; 
	margin-top: 0;
    margin-right: 0;
    box-shadow: 0;  
    width:   <s:property value="lblpagewidth"/>px;
    height:  <s:property value="lblpageheight"/>px; 
  }
.date{
	right: <s:property value="lbldatex"/>px;
    top:   <s:property value="lbldatey"/>px;
    font-size: 12pt !important;
    position: absolute; 
} 
.pay{
    left:  <s:property value="lblpaytohorizontal"/>px;
    top:  <s:property value="lblpaytovertical"/>px;
    width: <s:property value="lblpaytolength"/>px;
    font-size: 10pt !important;
    position: absolute;
}
.amtwords{
    left:  <s:property value="lblamtwordshorizontal"/>px;
    top:  <s:property value="lblamtwordsvertical"/>px;
    width: <s:property value="lblamtwordslength"/>px;
    font-size: 12pt !important;
    position: absolute;
}
.amtwords1{
    left:  <s:property value="lblamtwords1horizontal"/>px;
    top:  <s:property value="lblamtwords1vertical"/>px;
    width: <s:property value="lblamtwords1length"/>px;
    font-size: 12pt !important;
    position: absolute;
}
.amount{
    right:  <s:property value="lblamountx"/>px;
    top:  <s:property value="lblamounty"/>px;
    font-size: 12pt !important;
    position: absolute;  
}

.dummy{
    right:  <s:property value="lblamountx"/>px;
    top:  <s:property value="lblamounty"/>px;
    visibility:hidden;
}

.textbox {
	background-color : #ADFDCA;
	border: 1px solid #D8DAD8;
	width: <s:property value="lblamountx"/>px;
	height: 20px;
}

#chequeRotate {
    margin: 0;   
    margin-top: 0;
    margin-right: 0;
    box-shadow: 0;  
    width:   <s:property value="lblpagewidth"/>px;
    height:  <s:property value="lblpageheight"/>px;
	-ms-transform: rotate(90deg); /* IE 9 */
    -webkit-transform: rotate(90deg); /* Chrome, Safari, Opera */
    transform: rotate(90deg);
}

/* #pagebreak {
	page-break-after:always;
} */

}
</style>

</head>
<body>
<form id="frmChequeVoucher" action="printChequeVoucher" method="post" autocomplete="off">
<div id="chequeRotate">
    <label class="date"><s:property value="lblchequedate"/></label>
    <label class="pay"><s:property value="lblpaidto"/></label>  
    <label class="amtwords"><s:property value="lblamountwords"/></label>
    <label class="amtwords1"><s:property value="lblamountwords1"/></label>
    <label class="amount">#<s:property value="lblamount"/>#</label>
	<label class="dummy"><s:property value="lbldummy"/></label>
</div>
<!-- <div style="page-break-before:always;">&nbsp;</div> -->
<s:if test="#arr.index!=#request.TRIAL.size-1">
	<div style="page-break-before:always;">&nbsp;</div>
</s:if>  
</form>
</body>
</s:iterator>  
</html>