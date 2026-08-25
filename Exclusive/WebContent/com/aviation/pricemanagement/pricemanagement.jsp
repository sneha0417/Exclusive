<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
 <% String contextPath=request.getContextPath();%>

<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../includes.jsp"></jsp:include>

<style>
form label.error {
color:red;
  font-weight:bold;

}

.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>

<script type="text/javascript">

	
$(document).ready(function () {  
    
	   /* Date */ 	
	   
	   		 
	   $('#btnCalc').attr('disabled', true);
	   	    $("#fromdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	   
       $("#masterdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $("#todate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
       $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	   $('#productSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#productSearchwindow').jqxWindow('close');
	   $('#unitsearchwindow').jqxWindow({width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%', title: 'Unit Search',position: { x: 500, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	   $('#unitsearchwindow').jqxWindow('close');
	   $('#portSearchwindow').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Port Search' , position: { x: 250, y: 0 }, keyboardCloseKey: 27});
	   $('#portSearchwindow').jqxWindow('close');
	   $('#taxsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '85%' ,maxWidth: '45%' ,title: 'Taxes (Per Rate)' , position: { x: 750, y: 120 }, keyboardCloseKey: 27});
	   $('#taxsearchwindow').jqxWindow('close');
	   $('#itaxsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '85%' ,maxWidth: '45%' ,title: 'Taxes (Per Invoice)' , position: { x: 750, y: 120 }, keyboardCloseKey: 27});
	   $('#itaxsearchwindow').jqxWindow('close');
	   $('#taxtypesearchwindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' ,title: 'Tax Type ' , position: { x: 255, y: 130 }, keyboardCloseKey: 27});
	   $('#taxtypesearchwindow').jqxWindow('close');
	   $('#currencysearchwndow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' ,title: 'Currency Search ' , position: { x: 600, y: 0 }, keyboardCloseKey: 27});
	   $('#currencysearchwndow').jqxWindow('close'); 
	   $('#refnosearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	   $('#refnosearchwindow').jqxWindow('close'); 
	
	   $('#searchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	   $('#searchwindow').jqxWindow('close');	   
		   
		   
    $('#puraccid').dblclick(function(){
    	if($('#mode').val()!= "view"){
    		$('#accountSearchwindow').jqxWindow('open');
    		accountSearchContent('accountsDetailsSearch.jsp?type='+$('#cmbtype').val());
    	}
    });
    $('#part_no').dblclick(function(){
    	if($('#mode').val()!= "view"){
    		$('#productSearchwindow').jqxWindow('open');
    		productSearchContent('productSearchs.jsp?');
    	}
    });
    $('#txtcurrency').dblclick(function(){
    	if($('#mode').val()!= "view"){
    		$('#currencysearchwndow').jqxWindow('open');
    		$('#currencysearchwndow').jqxWindow('bringToFront');
    		currencySearchContent('currencySearch.jsp?');
    	}
    });
});
 


function getaccountdetails(event){
	var x= event.keyCode;
 	if($('#mode').val()!="view")
 	{
		if(x==114){
			var type=$('cmbtype')
			$('#accountSearchwindow').jqxWindow('open');
			accountSearchContent('accountsDetailsSearch.jsp?type='+$('#cmbtype').val());    }
		else{
		}
 	}
}  

function accountSearchContent(url) {
	$.get(url).done(function (data) {
		$('#accountSearchwindow').jqxWindow('setContent', data);
	}); 
}

function getProduct(event){
	var x= event.keyCode;
 	if($('#mode').val()!="view")
 	{
		if(x==114){
			$('#productSearchwindow').jqxWindow('open');
			productSearchContent('productSearchs.jsp?');    }
		else{
		}
 	}
}  
function productSearchContent(url) {
	$.get(url).done(function (data) {
		$('#productSearchwindow').jqxWindow('setContent', data);
	}); 
}
 
function portSearchContent(url) {
	$('#portSearchwindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#portSearchwindow').jqxWindow('setContent', data);
	}); 
}

function getCurrency(event){
	var x= event.keyCode;
 	if($('#mode').val()!="view")
 	{
		if(x==114){
			$('#currencysearchwndow').jqxWindow('open');
			currencySearchContent('currencySearch.jsp?');    }
		else{
		}
 	}
}  

function currencySearchContent(url) {
	$.get(url).done(function (data) {
		$('#currencysearchwndow').jqxWindow('bringToFront');
		$('#currencysearchwndow').jqxWindow('setContent', data);
	}); 
}

function funReadOnly(){
	$('#frmpmgtmt input').attr('readonly', true );
	$('#frmpmgtmt select').attr('disabled', true );
	$('#masterdate').jqxDateTimeInput({ disabled: true});
	$('#todate').jqxDateTimeInput({ disabled: true});
	$('#fromdate').jqxDateTimeInput({ disabled: true});
	$("#jqxPriceMngt").jqxGrid({ disabled: true});
	$('#cmbtype').attr('disabled', true);
	
	if($("#masterdoc_no").val()==""){
		$('#btnCalc').attr('disabled', true);
	}
	else{
		$('#btnCalc').attr('disabled', false);
	}
}
function funRemoveReadOnly(){
	$('#frmpmgtmt input').attr('readonly', false );
	$('#frmpmgtmt select').attr('disabled', false );
	$('#txtcurrency').attr('readonly', true);
	$('#puraccid').attr('readonly', true);
	$('#puraccname').attr('readonly', true);
	$('#masterdate').jqxDateTimeInput({ disabled: false});
	$('#fromdate').jqxDateTimeInput({ disabled: false});
	$('#todate').jqxDateTimeInput({ disabled: false});
	$('#cmbcurr').attr('disabled', false);
	$('#docno').attr('readonly', true);
	$("#jqxPriceMngt").jqxGrid({ disabled: false});
	if ($("#mode").val() == "A") {
		$('#masterdate').val(new Date());
		$('#todate').val(new Date());
		$('#fromdate').val(new Date());
		$("#jqxPriceMngt").jqxGrid('clear');
		$("#jqxPriceMngt").jqxGrid('addrow', null, {});
		$('#btnCalc').attr('disabled', true);
	}
	if ($("#mode").val() == "E") {
		$('#btnCalc').attr('disabled', false);
	}
}

function chkedit(){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText.trim();
			if(parseInt(items)=="1")  
			{ 
				funReadOnly();
				$("#btnEdit").attr('disabled', true );
			}
			else
			{
				$("#btnEdit").attr('disabled', false );
			}
		}
	}
	x.open("GET","chkEdit.jsp?docno="+$('#masterdoc_no').val(),true);    
	x.send();
}
function funFocus(){
   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
}
function funNotify(){
	var purid= document.getElementById("puraccid").value;
	if(purid=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Account";
	 document.getElementById("puraccid").focus();
	 return 0;
	}
	else
	{
	 document.getElementById("errormsg").innerText="";
	}
	if(document.getElementById("part_no").value=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Account";
	 document.getElementById("puraccid").focus();
	 return 0;
	}
	else
	{
		document.getElementById("errormsg").innerText="";
	}
	var rows = $("#jqxPriceMngt").jqxGrid('getrows');
	$('#pmgridlength').val(rows.length);
	for(var i=0 ; i < rows.length ; i++){
		newTextBox = $(document.createElement("input"))  
		.attr("type", "dil")
		.attr("id", "pmtest"+i)
		.attr("name", "pmtest"+i)
		.attr("hidden", "true");         
		newTextBox.val(rows[i].portid+"::"+rows[i].unitid+"::"+rows[i].price+"::"+rows[i].tax+"::"+rows[i].itax+"::");
		newTextBox.appendTo('form');
	}   
	
$("#jqxPriceMngt").jqxGrid({ disabled: false});
return 1;
} 


function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}
 
 
	   

	   function setValues() {
			if($('#hidmasterdate').val()){
				$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
			}
			if($('#hidtodate').val()){
				$("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
			}
			if($('#hidfromdate').val()){
				$("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
			}
			if($('#msg').val()!=""){
				$.messager.alert('Message',$('#msg').val());
			} 
			var docno=$('#masterdoc_no').val();
			
			if($('#hidcmbtype').val()!="")
				{
				$('#cmbtype').val($('#hidcmbtype').val());
				}
			
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    		$("#pmdiv").load("pricemanagementGrid.jsp?docno="+docno);
	   }
	   
	   function funPrintBtn(){
	 	}

	   function funCalcTax(){
		   $("#jqxPriceMngt").jqxGrid({ disabled: false});
	   }
	 
  
</script>
</head>
<body onLoad="setValues();chkedit();" >


<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpmgtmt" action="savepriceManagemenet" method="post" autocomplete="off">
<jsp:include page="../../../header.jsp" />   
<br/><fieldset> 
<table width="100%" border="0"> 
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="12%"><div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
      <input type="hidden" name="hidmasterdate" id="hidmasterdate" value='<s:property value="hidmasterdate"/>'></td>
    <td align="right" width="6%">Type</td> 
    <td><select  id="cmbtype"  name="cmbtype" style="width:62%;" > 
    <option value="S">Sales </option>   
     <option value="P">Purchase</option>
    </select>
    <input type="hidden" name="hidcmbtype" id="hidcmbtype"  value='<s:property value="hidcmbtype"/>'>
    </td>  
    <td>&nbsp;</td>
   <td>&nbsp;</td>  
    <td width="5%" align="right">Doc No</td>
    <td width="14%"><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
  </tr>
  <tr>
    <td align="right">Name</td>   
    <td colspan="3"><input type="text" name="puraccid" id="puraccid" value='<s:property value="puraccid"/>' placeholder="Press F3 To Search"   style="width:25%;" onKeyDown="getaccountdetails(event);" >  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'  style="width:72%;"></td>
  <td  align="right"> Curr</td><td><input type="text" name="txtcurrency" id="txtcurrency"  value='<s:property value="txtcurrency"/>' onKeyDown="getCurrency(event);">
  <input type="hidden" name="currate" id="currate"  value='<s:property value="currate"/>'>
  <input type="hidden" name="currid" id="currid"  value='<s:property value="currid"/>'></td>
  </tr>
<tr>
  <td align="right">Valid From</td>
    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>  
    <input type="hidden" name="hidfromdate" id="hidfromdate" value='<s:property value="hidfromdate"/>'></td>
      <td align="right">Valid Upto</td>
    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div>
    <input type="hidden" name="hidtodate" id="hidtodate" value='<s:property value="hidtodate"/>'></td>
    
       <td align="right">Note</td>
    <td colspan="5"><input type="text" name="desc1" id="desc1" value='<s:property value="desc1"/>' style="width:84.4%;"></td>
    
    </tr>
    <tr>
    <td align="right">Product</td>   
    <td colspan="3"><input type="text" name="part_no" id="part_no" value='<s:property value="part_no"/>' placeholder="Press F3 To Search"   style="width:25%;" onKeyDown="getProduct(event);" >  
      <input type="text" id="pname" name="pname" value='<s:property value="pname"/>'  style="width:72%;">
       <input type="hidden" name="hidpsrno" id="hidpsrno" value='<s:property value="hidpsrno"/>'></td>
    </tr>
  
 </table>
 
 </fieldset>
 <br>
 <fieldset>
 <table width="100%">
<tr><td style="text-align: center;"><input type="button" class="myButton" name="btnCalc" id="btnCalc" value="Calculate" onclick="funCalcTax()"></td></tr>
 <tr><td>
    <div id="pmdiv" > 
    <jsp:include page="pricemanagementGrid.jsp"></jsp:include> 
    </div>
</td></tr>
</table>     

</fieldset>

<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="formdetailcode" name="formdetailcode"  value='<s:property value="formdetailcode"/>'/>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
<input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>  
<input type="hidden" id="pmgridlength" name="pmgridlength"  value='<s:property value="pmgridlength"/>'/>    
<input type="hidden" id="taxgridlength" name="taxgridlength"  value='<s:property value="taxgridlength"/>'/>
<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
</form>
<div id="searchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>
<div id="accountSearchwindow">
	<div ></div>
	</div>
<div id="productSearchwindow">
	   <div ></div>
	</div>
<div id="currencysearchwndow">
	   <div ></div>
	</div>
<div id="unitsearchwindow">
   <div ></div>
</div>
<div id="portSearchwindow">
   <div ></div>
</div>
<div id="taxsearchwindow">
   <div ></div>
</div>
<div id="itaxsearchwindow">
   <div ></div>
</div>
<div id="taxtypesearchwindow">
   <div ></div>
</div>
	
</div>
</body>
</html>