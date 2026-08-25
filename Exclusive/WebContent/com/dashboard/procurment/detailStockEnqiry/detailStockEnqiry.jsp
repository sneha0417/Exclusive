<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%
	String contextPath=request.getContextPath();
 %>
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.transactionHead {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	height: 28px;
	font-family: Myriad Pro;
	font-weight: bold;
}
.transactionHeadDetails {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: comic sans ms;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#productDetailsWindow').jqxWindow({width: '70%', height: '65%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#productDetailsWindow').jqxWindow('close');
		 
		 $('#unitDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Units Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#unitDetailsWindow').jqxWindow('close');
		 
		 /* $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close'); */
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdbackorder").checked=false;document.getElementById("rdpendingdelivery").checked=false;
	     $('#rdbackorder').attr('hidden', true );$('#rdpendingdelivery').attr('hidden', true );
		 $('#lblrdbackorder').attr('hidden', true );$('#lblpenddel').attr('hidden', true );

		 $('#txtpartno').dblclick(function(){
			 var aa="DSE";
			 productSearchContent("<%=contextPath%>/com/productsearch/productSearch.jsp?frm="+aa, $('#productDetailsWindow'));
		 }); 
		  
		 $('#txtunit').dblclick(function(){
			  unitsSearchContent('unitsDetailsSearch.jsp');
		 }); 
		
	});
	
	function getProduct(){
		
		 $('#productDetailsWindow').jqxWindow('open');
			$('#productDetailsWindow').jqxWindow('focus');
			 var aa="DSE";
			 productSearchContent("<%=contextPath%>/com/productsearch/productSearch.jsp?frm="+aa, $('#productDetailsWindow'));

	}
	
	function productSearchContent(url) {
	    $('#productDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#productDetailsWindow').jqxWindow('setContent', data);
		$('#productDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function unitsSearchContent(url) {
	    $('#unitDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#unitDetailsWindow').jqxWindow('setContent', data);
		$('#unitDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getProductType(event){
        var x= event.keyCode;
        if(x==114){
        	productsSearchContent('productsDetailsSearch.jsp');
        }
        else{
         }
        }
	
	function getUnit(event){
        var x= event.keyCode;
        if(x==114){
        	unitsSearchContent('unitsDetailsSearch.jsp');
        }
        else{
         }
        }
	    
	function clearTypeInfo(){
		 /* $('#txtpartno').val('');$('#txtproductname').val('');$('#txtunit').val('');$('#detailinfo').val('');
		 $('#hidproductid').val(''); */
		 document.getElementById("rdbackorder").checked=false;document.getElementById("rdpendingdelivery").checked=false;
	     
		 $('#rdbackorder').attr('hidden', true );$('#rdpendingdelivery').attr('hidden', true );
		 $('#lblrdbackorder').attr('hidden', true );$('#lblpenddel').attr('hidden', true );
	     
		 /* if (document.getElementById("txtpartno").value == "") {
		        $('#txtpartno').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtunit").value == "") {
		        $('#txtunit').attr('placeholder', 'Press F3 to Search'); 
		    } */
	} 
	
	function  funClearData(){
		 $('#cmbtype').val('curstk');$('#fromdate').val(new Date());$('#todate').val(new Date());
		 $('#txtpartno').val('');$('#txtproductname').val('');$('#txtunit').val('');$('#detailinfo').val('');
		 $('#hidproductid').val('');
		 $('#fromdate').val(new Date());
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdbackorder").checked=false;document.getElementById("rdpendingdelivery").checked=false;
	     
	     $('#rdbackorder').attr('hidden', true );$('#rdpendingdelivery').attr('hidden', true );
		 $('#lblrdbackorder').attr('hidden', true );$('#lblpenddel').attr('hidden', true );
		 document.getElementById("searchdetails").value= "";
	     $("#currentStockGridID").jqxGrid('clear');$("#transactionDetailsGridID").jqxGrid('clear');$("#jqxStockDetailGrid").jqxGrid('clear');$("#lastPurchasePriceDetailsGridID").jqxGrid('clear');$("#salesDetailsGridID").jqxGrid('clear');
	     $("#currentStockGridID").jqxGrid('addrow', null, {});$("#transactionDetailsGridID").jqxGrid('addrow', null, {});$("#jqxStockDetailGrid").jqxGrid('addrow', null, {});$("#lastPurchasePriceDetailsGridID").jqxGrid('addrow', null, {});$("#salesDetailsGridID").jqxGrid('addrow', null, {});
	     $("#currentStockDiv").prop("hidden", false);$("#transactionDetailsDiv").prop("hidden", true);$("#detailMovementDiv").prop("hidden", true);$("#lastPurchasePriceDetailsDiv").prop("hidden", true);$("#salesDetailsDiv").prop("hidden", true);
	     
		 /* if (document.getElementById("txtpartno").value == "") {
		        $('#txtpartno').attr('placeholder', 'Press F3 to Search'); 
		    } */
		 
	}
	
	function detailStockType(){
		
		 var type=$('#cmbtype').val();
		//$('#searchdetails').val('');
		 $("#currentStockGridID").jqxGrid('clear');$("#transactionDetailsGridID").jqxGrid('clear');$("#jqxStockDetailGrid").jqxGrid('clear');$("#lastPurchasePriceDetailsGridID").jqxGrid('clear');$("#salesDetailsGridID").jqxGrid('clear');
	     $("#currentStockGridID").jqxGrid('addrow', null, {});$("#transactionDetailsGridID").jqxGrid('addrow', null, {});$("#jqxStockDetailGrid").jqxGrid('addrow', null, {});$("#lastPurchasePriceDetailsGridID").jqxGrid('addrow', null, {});$("#salesDetailsGridID").jqxGrid('addrow', null, {});
	     
		 if(type=='saldet') {
			 
			 document.getElementById("rdbackorder").checked=false;document.getElementById("rdpendingdelivery").checked=false;
			 $('#rdbackorder').attr('hidden', true );$('#rdpendingdelivery').attr('hidden', true );
			 $('#lblrdbackorder').attr('hidden', true );$('#lblpenddel').attr('hidden', true );
			 $("#salesDetailsDiv").prop("hidden", false);$("#currentStockDiv").prop("hidden", true);$("#transactionDetailsDiv").prop("hidden", true);$("#detailMovementDiv").prop("hidden", true);$("#lastPurchasePriceDetailsDiv").prop("hidden", true);
		 } else if(type=='trdet') {
			 
			 document.getElementById("rdbackorder").checked=true;document.getElementById("rdpendingdelivery").checked=false;
			 $('#rdbackorder').attr('hidden', false );$('#rdpendingdelivery').attr('hidden', false );
			 $('#lblrdbackorder').attr('hidden', false );$('#lblpenddel').attr('hidden', false );
			 $("#transactionDetailsDiv").prop("hidden", false);$("#currentStockDiv").prop("hidden", true);$("#detailMovementDiv").prop("hidden", true);$("#lastPurchasePriceDetailsDiv").prop("hidden", true);$("#salesDetailsDiv").prop("hidden", true);
		 } else if(type=='detmov') {
			 $('#chk').attr('hidden', true );
			 document.getElementById("rdbackorder").checked=false;document.getElementById("rdpendingdelivery").checked=false;
			 $('#rdbackorder').attr('hidden', true );$('#rdpendingdelivery').attr('hidden', true );
			 $('#lblrdbackorder').attr('hidden', true );$('#lblpenddel').attr('hidden', true );
			 $("#detailMovementDiv").prop("hidden", false);$("#currentStockDiv").prop("hidden", true);$("#transactionDetailsDiv").prop("hidden", true);$("#lastPurchasePriceDetailsDiv").prop("hidden", true);$("#salesDetailsDiv").prop("hidden", true);
		 } else if(type=='lpurdet') {
			 document.getElementById("rdbackorder").checked=false;document.getElementById("rdpendingdelivery").checked=false;
			 $('#rdbackorder').attr('hidden', true );$('#rdpendingdelivery').attr('hidden', true );
			 $('#lblrdbackorder').attr('hidden', true );$('#lblpenddel').attr('hidden', true );
			 $("#lastPurchasePriceDetailsDiv").prop("hidden", false);$("#currentStockDiv").prop("hidden", true);$("#transactionDetailsDiv").prop("hidden", true);$("#detailMovementDiv").prop("hidden", true);$("#salesDetailsDiv").prop("hidden", true);
		 } else {
			 
			 document.getElementById("rdbackorder").checked=false;document.getElementById("rdpendingdelivery").checked=false;
			 $('#rdbackorder').attr('hidden', true );$('#rdpendingdelivery').attr('hidden', true );
			 $('#lblrdbackorder').attr('hidden', true );$('#lblpenddel').attr('hidden', true );
			 $("#currentStockDiv").prop("hidden", false);$("#transactionDetailsDiv").prop("hidden", true);$("#detailMovementDiv").prop("hidden", true);$("#lastPurchasePriceDetailsDiv").prop("hidden", true);$("#salesDetailsDiv").prop("hidden", true);
		 }
	}
	
	function funreload(event){

		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var rpttype = $('#cmbtype').val();
		 var product=$('#txtpartno').val();
		 var productid=$('#hidproductid').val();
		 var unit=$('#txtunit').val();
		 var chk=1;
		 
		 var aa="yes";
		 
			if(productid==""){
				
				$.messager.alert('Message','Select a product to Continue','warning');
				   return false;
			}
		 
		 $("#currentStockGridID").jqxGrid('clear');$("#transactionDetailsGridID").jqxGrid('clear');$("#jqxStockDetailGrid").jqxGrid('clear');$("#lastPurchasePriceDetailsGridID").jqxGrid('clear');$("#salesDetailsGridID").jqxGrid('clear');
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(rpttype=='saldet') {
				 $("#salesDetailsDiv").load("salesDetailsGrid.jsp?todate="+todate+"&frmdate="+fromdate+"&productid="+productid+"&branchval="+branchval+"&dtype="+rpttype+"&aa="+aa);
		 } else if(rpttype=='trdet') {
			     var documenttype='';
			     var dtype='';
			     if(document.getElementById("rdbackorder").checked==true)
			     {documenttype='Pending Order Details';
			     document.getElementById("gridhead").value="Reserved"; 
			     dtype='SOR';
			     }
			     if(document.getElementById("rdpendingdelivery").checked==true)
			     {documenttype='Pending Delivery List';
			     document.getElementById("gridhead").value="Deliverd"; 
			     dtype='DEL';
			     }
			     document.getElementById("lbldoctype").innerText=documenttype; 
			     $("#transactionDetailsDiv").load("transactionDetailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&rpttype='+rpttype+'&unit='+unit+'&chk='+chk+'&productid='+productid+'&dtype='+dtype+"&aa="+aa);
		 } else if(rpttype=='detmov') {
			 $("#detailMovementDiv").load("stockLedgerGridDetail.jsp?todate="+todate+"&frmdate="+fromdate+"&hidproduct="+productid+"&branchid="+branchval+"&aa="+aa);
	    	     /* $("#detailMovementDiv").load("detailMovementGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&rpttype='+rpttype+'&product='+product+'&unit='+unit+'&chk='+chk); */
		 } else if(rpttype=='lpurdet') {
	    	     $("#lastPurchasePriceDetailsDiv").load("lastPurchasePriceDetailsGrid.jsp?todate="+todate+"&frmdate="+fromdate+"&productid="+productid+"&branchval="+branchval+"&dtype="+rpttype+"&aa="+aa);
	     } else {
	    	     $("#currentStockDiv").load("currentStockGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&rpttype='+rpttype+'&unit='+unit+'&chk='+chk+'&productid='+productid+"&aa="+aa);
		 }
	}
	
	
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		 
	 <tr><td align="right"><label class="branch">Period</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  	  

    <tr><td align="right"><label class="branch">Product</label></td>
	<td align="left"><input type="text" id="txtpartno" name="txtpartno" style="width:80%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtpartno"/>' onKeyDown="getProduct(event);"/></td></tr>
	<input type="hidden" id="psrno" name="psrno" value='<s:property value="psrno"/>' /> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtproductname" name="txtproductname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtproductname"/>' tabindex="-1"/></td></tr> 
	
	
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:72%;" onchange="clearTypeInfo();detailStockType();" value='<s:property value="cmbtype"/>'>
    
    <option value="curstk" selected>Current Stock</option>
  <!--   <option value="trdet">Transaction Details</option>
    <option value="detmov">Detail Movement</option>
    <option value="lpurdet">Last Purchase Price Details</option>
    <option value="saldet">Sales Details</option> --></select></td></tr>
	<tr>
	<tr>
       <td align="right"><input type="radio" id="rdbackorder" name="rdo" value="rdbackorder"></td>
       <td align="left"><label for="rdbackorder" id="lblrdbackorder" class="branch">Pending Order</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rdpendingdelivery" name="rdo" value="rdpendingdelivery"><label for="rdpendingdelivery" id="lblpenddel" class="branch">Pend. Delivery</label></td>
    </tr>
	
	
	
	<tr> <td  align="center" colspan="2"><textarea id="searchdetails" style="height:150px;width:220px;font: 10px Tahoma;resize:none" name="searchdetails"  readonly="readonly"  ><s:property value="searchdetails" ></s:property></textarea></td></tr>
 	
	<tr><td align="right"><label class="branch"> </label></td>
	<td align="left"><input type="hidden" id="txtunit" name="txtunit" style="width:60%;height:20px;" readonly="readonly"  value='<s:property value="txtunit"/>'/></td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
 
			
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
	    <tr><td><label class="transactionHead">&nbsp;</label><label class="transactionHeadDetails" name="lbldoctype" id="lbldoctype"></label></td></tr> 
		<tr>
			 <td><div id="currentStockDiv"><jsp:include page="currentStockGrid.jsp"></jsp:include></div>
			 <div id="transactionDetailsDiv" hidden="true"><jsp:include page="transactionDetailsGrid.jsp"></jsp:include></div>
			 <%-- <div id="detailMovementDiv" hidden="true"><jsp:include page="detailMovementGrid.jsp"></jsp:include></div> --%>
			 <div id="detailMovementDiv" hidden="true"><jsp:include page="stockLedgerGridDetail.jsp"></jsp:include></div>
			 <div id="lastPurchasePriceDetailsDiv" hidden="true"><jsp:include page="lastPurchasePriceDetailsGrid.jsp"></jsp:include></div>
			 <div id="salesDetailsDiv" hidden="true"><jsp:include page="salesDetailsGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr><td>
			 <input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct"></td></tr>
	</table>
</tr>
</table>

</div>

<div id="productDetailsWindow">
	<div></div><div></div>
</div>
<div id="unitDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>