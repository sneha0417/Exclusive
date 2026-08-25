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
    margin: 100%;
    size: <s:property value="lblpagesheight"/>in <s:property value="lblpageswidth"/>in;
    font-size: 50pt !important;
     
  }  
  
  body, fieldset {
    margin: 50%;
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
    width: <s:property value="lblpaytolength"/>px;
	font-size: 10pt !important;
}
.amtwords{
    left:  <s:property value="lblamtwordshorizontal"/>px;
    top:  <s:property value="lblamtwordsvertical"/>px;
    width: <s:property value="lblamtwordslength"/>px;
}
.amtwords1{
    left:  <s:property value="lblamtwords1horizontal"/>px;
    top:  <s:property value="lblamtwords1vertical"/>px;
    width: <s:property value="lblamtwords1length"/>px;
}
.amount{
    right:  <s:property value="lblamountx"/>px;
    top:  <s:property value="lblamounty"/>px;
}
.textbox {
	background-color : #ADFDCA;
	border: 1px solid #D8DAD8;
	width: <s:property value="lblamountx"/>px;
	height: 20px;
}
}
</style>

</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmChequeVoucher" action="printChequeVoucher" method="post" autocomplete="off">

    <label class="date"><s:property value="lblchequedate"/></label>
    <label class="pay"><s:property value="lblpaidto"/></label>  
    <label class="amtwords"><s:property value="lblamountwords"/></label>
    <label class="amtwords1"><s:property value="lblamountwords1"/></label>
    <label class="amount">#<s:property value="lblamount"/>#</label>
  
</form>
</div>
</body>
</html>