<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<style type="text/css">

@media print {
   @page {
    margin: 0;
    size: <s:property value="lblpagesheight"/>in <s:property value="lblpageswidth"/>in;
    font-size: 50pt !important;
  }  
  
  body, fieldset {
    margin: 0;
    box-shadow: 0;
    width:   <s:property value="lblpagewidth"/>px;
    height:  <s:property value="lblpageheight"/>px;
    -webkit-transform: rotate(90deg);
    -moz-transform:rotate(90deg);
  }
  
  label{
    position: absolute;
}
.date{
	right: <s:property value="lbldatex"/>px;
    top:   <s:property value="lbldatey"/>px;
} 
.pay{
    left:  <s:property value="lblpaytohorizontal"/>px;
    top:  <s:property value="lblpaytovertical"/>px;
	font-size: 10pt !important;
    text-align: left;
}
.amtwords{
    left:  <s:property value="lblamtwordshorizontal"/>px;
    top:  <s:property value="lblamtwordsvertical"/>px;
    text-align: left;
}
.amtwords1{
    left:  <s:property value="lblamtwords1horizontal"/>px;
    top:  <s:property value="lblamtwords1vertical"/>px;
    text-align: left;
}
.amount{
    right:  <s:property value="lblamountx"/>px;
    top:  <s:property value="lblamounty"/>px;
}
 .textbox {
	background-color : #fff;
	border: 1px solid #D8DAD8;
	width: 65px;
	height: 20px;
	text-align: center;
	margin-right: 3em;
} 
}
</style>

</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmChequeVoucher" action="printChequeVoucher" method="post" autocomplete="off">

    <label class="date"><label class="textbox">Date</label></label>
    <label class="pay">Payee<hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="<s:property value="lblpaytolength"/>px"></label>  
    <label class="amtwords">Amount in words<hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="<s:property value="lblamtwordslength"/>px"></label>
    <label class="amtwords1">Amount in words<hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="<s:property value="lblamtwords1length"/>px"></label>
    <label class="amount"><label class="textbox">Amount</label></label>
 
</form>
</div>
</body>
</html>