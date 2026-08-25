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
    size: 17 cm 9.90 cm;
    font-size: 50pt !important;
	
  }  
  
  body, fieldset {
    margin: 0;
    box-shadow: 0;
    width:   17 cm;
    height:  9.90 cm;
	-webkit-transform: rotate(90deg);
    -moz-transform:rotate(90deg);
     border:1px solid;
     bgcolor: red;
  }
  
  label{
    position: absolute;
}
.date{
	right: 2.75 cm;
    top:   0.55 cm;
    border:2 px solid;
} 
.pay{
    left:  3.20 cm;
    top:   2.20 cm;
    width: 12.50 cm;
	font-size: 10pt !important;
}
.amtwords{
    left:  3.20 cm;
    top:  3.00 cm;
    width: 8.50 cm;
}
.amtwords1{
    left:  3.20 cm;
    top:  3.00 cm;
    width: 8.50 cm;
}
.amount{
    right:  2.25 cm;
    top:   3.25 cm;
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

    <label class="date" ><s:property value="lblchequedate"/></label>
    <label class="pay"><s:property value="lblpaidto"/></label>  
    <label class="amtwords"><s:property value="lblamountwords"/></label>
    <label class="amtwords1"><s:property value="lblamountwords1"/></label>
    <label class="amount">#<s:property value="lblamount"/>#</label>
  
</form>
</div>
</body>
</html>