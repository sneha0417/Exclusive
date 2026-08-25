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
    size: 170 mm 99.0 mm;
    font-size: 50pt !important;
	
  }  
  
  body, fieldset {
    margin: 0;
    box-shadow: 0;
    width:   170 mm;
    height:  90 mm;
	-webkit-transform: rotate(90deg);
    -moz-transform:rotate(90deg);
     border:1px solid;
     bgcolor: red;
  }
  
  label{
    position: absolute;
}
.date{
	right: 27.5 mm;
    top:   5.5 mm;
    border:2px solid;
} 
.pay{
    left:  32.0 mm;
    top:   22.0 mm;
    width: 125.0 mm;
	font-size: 10pt !important;
}
.amtwords{
    left:  85.0 mm;
    top:  45.0 mm;
    width: 85.0 mm;
    border:1px solid;
}
.amtwords1{
    left:  32.0 mm;
    top:  30.0 mm;
    width: 85.0 mm;
}
.amount{
    right:  22.5 mm;
    top:   85.5 mm;
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