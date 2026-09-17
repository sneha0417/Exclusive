<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<s:head/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui form label.error {
    color: red;
    font-weight: bold;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
    display: flex;
    align-items: center;
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">

$(document).ready(function () {   
    
    $("#date_accountmaster").jqxDateTimeInput({ width: '120px', height: 24 ,formatString : "dd.MM.yyyy", theme: 'energyblue' });   
    setTimeout(function () {
        $("#date_accountmaster").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#date_accountmaster").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
    
    $('#accountSearchwindow').jqxWindow({ width: '20%', height: '50%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Currency  Search' ,position: { x: 600, y: 150 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
   
	$('#currs').dblclick(function(){		 
		 
	 if($('#mode').val()!= "view" && document.getElementById('category3').checked)
 		{
		  	  $('#accountSearchwindow').jqxWindow('open');
		  	  accountSearchContent('accountGridSearch.jsp');
 		} 
	}); 
	
});

function getaccountdetails(event){
    var x= event.keyCode;
    if($('#mode').val()!= "view" && document.getElementById('category3').checked) {
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountGridSearch.jsp');   
        }
    } 
}  

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}

function funFocus(){}
 
function funReset() {} 

function funReadOnly() {
	$('#frmAccountmaster input').attr('readonly', true);	
	$('#localcurrency').attr('disabled', true);
	$('#ageingdetails').attr('disabled', true);
	$('#interbranch').attr('disabled', true);
	$('#category1').attr('disabled', true);
	$('#category2').attr('disabled', true);
	$('#category3').attr('disabled', true);
	$('#frmAccountmaster select').attr('disabled', true);
	delvalueChange();
}

function funRemoveReadOnly() {
	$('#frmAccountmaster input').attr('readonly', true);
	$('#localcurrency').attr('disabled', true);
	$('#ageingdetails').attr('disabled', true);
	$('#interbranch').attr('disabled', false);
	$('#category1').attr('disabled', false);
	$('#category2').attr('disabled', false);
	$('#category3').attr('disabled', false);
	
	 if ($("#mode").val() =="A") {
		 $('#date_accountmaster').val(new Date());
		 document.getElementById("interbranch").checked = false;
		 $('#frmAccountmaster select').attr('disabled', true);
		 
		 var disother=document.getElementById("otherdis").value; 
			if(disother==1)
			 {
				 $("#main input").prop("disabled", false);
				 $("#main input").prop("readonly", false);
				 $("#main select").prop("disabled", false);
				 $('#category1').attr('disabled', false);
				 $('#category2').attr('disabled', true);
				 $('#category3').attr('disabled', true);
				 $("#sub input").prop("readonly", true);
				 $("#trans input").prop("readonly", true);
			     $('#interbranch').attr('disabled', true);
			 }
		 if(disother==2)
		 {
			 $("#sub input").prop("disabled", false);
			 $("#sub input").prop("readonly", false);
			 $("#sub select").prop("disabled", false);
			 $('#subaccgpname').attr('readonly', true);
			 $('#category2').attr('disabled', false);
		     $('#category1').attr('disabled', true);
			 $('#category3').attr('disabled', true);
			 $("#trans input").prop("readonly", true);
			 $("#main input").prop("readonly", true);
			 $('#interbranch').attr('disabled', true);
		 }
		 if(disother==3)
		 {
			 $("#trans input").prop("disabled", false);
			 $("#trans input").prop("readonly", false);
			 $("#trans select").prop("disabled", false);
			 $('#transcaccgpname').attr('readonly', true);
			 
			 $('#category3').attr('disabled', false);
		    $('#category1').attr('disabled', true);
			$('#category2').attr('disabled', true);
			 $("#sub input").prop("readonly", true);
			 $("#main input").prop("readonly", true);
			 $('#interbranch').attr('disabled', false);
		 }
		 
	 }
	 if ($("#mode").val() =="E") {
		 $('#frmAccountmaster input').attr('readonly', false);
		 $('#frmAccountmaster select').attr('readonly', false);
		
		 var disother=document.getElementById("otherdis").value; 
		if(disother==1)
		 {
			 $("#main input").prop("disabled", false);
			 $("#main select").prop("disabled", false);
			 $('#category1').attr('disabled', false);
			 $('#category2').attr('disabled', true);
			 $('#category3').attr('disabled', true);
			 $("#sub input").prop("readonly", true);
			 $("#trans input").prop("readonly", true);
		     $('#interbranch').attr('disabled', true);
		 }
		 if(disother==2)
		 {
			 $("#sub input").prop("disabled", false);
			 $("#sub select").prop("disabled", false);
			 $('#subaccgpname').attr('readonly', true);
			 $('#category2').attr('disabled', false);
		     $('#category1').attr('disabled', true);
			 $('#category3').attr('disabled', true); 
			 $("#trans input").prop("readonly", true); 
			 $("#main input").prop("readonly", true);
			 $('#interbranch').attr('disabled', true);
		 }
		 if(disother==3)
		 {
			 $("#trans input").prop("disabled", false);
			 $("#trans select").prop("disabled", false);
			 $('#transcaccgpname').attr('readonly', true); 
			 $('#category3').attr('disabled', false);
		     $('#category1').attr('disabled', true);
			 $('#category2').attr('disabled', true);
			 $("#sub input").prop("readonly", true);
			 $('#currs').attr('readonly', true); 
			 $("#main input").prop("readonly", true);
			 $('#interbranch').attr('disabled', false);
		 }
		 
	 }
	 if ($("#mode").val() =="D") {
			$('#frmAccountmaster input').attr('readonly', false);			
			$('#localcurrency').attr('disabled', false);
			$('#ageingdetails').attr('disabled', false);
			$('#interbranch').attr('disabled', false);
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
			$("#trans input").prop("disabled", false);
			$("#trans select").prop("disabled", false);
			$("#main input").prop("disabled", false);
			$("#main select").prop("disabled", false);
			$("#sub input").prop("disabled", false);
			$("#sub select").prop("disabled", false);
			$('#frmAccountmaster select').attr('disabled', false);
	 }
	
	$('#docno').attr('readonly', true);
}
function funSearchLoad(){	
	changeContent('masterSearch.jsp', $('#window')); 
 }
function fundisable(){
	if (document.getElementById('category1').checked) {
		 $('#frmAccountmaster input').attr('readonly', false);
		 $("#sub input").prop("disabled", true);
		 $("#sub select").prop("disabled", true);
		 $("#trans input").prop("disabled", true);
		 $("#trans select").prop("disabled", true);
		 $("#main input").prop("disabled", false);
		 $("#main select").prop("disabled", false);
		 document.getElementById('subaccgpname').value="";
		 document.getElementById('subacccode').value="";
		 document.getElementById('subaccname').value="";
		 document.getElementById('transcaccgpname').value="";
		 document.getElementById('transacccode').value="";
		 document.getElementById('transaccname').value="";
		 $('#docno').attr('readonly', true);
		 document.getElementById('otherdis').value=1;
		 document.getElementById('radiotick').value=1;		
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText="";  
		 document.getElementById('maindel').value=1;		 
		 document.getElementById('main_account').value="mainacc";		 	
		}
	else if (document.getElementById('category2').checked) {
		 $('#frmAccountmaster input').attr('readonly', false);
		 $("#main input").prop("disabled", true);
		 $("#main select").prop("disabled", true);
		 $("#trans input").prop("disabled", true);
		 $("#trans select").prop("disabled", true);
		 $("#sub input").prop("disabled", false);
		 $("#sub select").prop("disabled", false);
		 $('#subaccgpname').attr('readonly', true);
		 $('#docno').attr('readonly', true);
		 document.getElementById('mainacccode').value="";
		 document.getElementById('mainacconame').value="";
		 document.getElementById('transcaccgpname').value="";
		 document.getElementById('transacccode').value="";
		 document.getElementById('transaccname').value="";
		 document.getElementById('otherdis').value=2;
		 document.getElementById('radiotick').value=2;
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 document.getElementById('maindel').value=2;		 
		 document.getElementById('sub_account').value="subacc";		 
		}
	else if (document.getElementById('category3').checked) {
		 $('#frmAccountmaster input').attr('readonly', false);
		 $("#main input").prop("disabled", true);
		 $("#main select").prop("disabled", true);
		 $("#sub input").prop("disabled", true);
		 $("#sub select").prop("disabled", true);
		 $("#trans input").prop("disabled", false);
		 $("#trans select").prop("disabled", false);
		 $('#transcaccgpname').attr('readonly', true);
		 document.getElementById('mainacccode').value="";
		 document.getElementById('mainacconame').value="";
		 document.getElementById('subaccgpname').value="";
		 document.getElementById('subacccode').value="";
		 document.getElementById('subaccname').value="";
		 document.getElementById('otherdis').value=3;
		 document.getElementById('radiotick').value=3;
		 $('#docno').attr('readonly', true);
		 $('#currs').attr('readonly', true);
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 document.getElementById('maindel').value=3;
		 document.getElementById('tran_account').value="tranacc";
		}
	 }
	 
function funhidden(){
	 if (document.getElementById('interbranch').checked) {
		 document.getElementById('intertick').value=1;
		$("#branch").prop("hidden", false);
	}
	else {
		document.getElementById('intertick').value="";
		$("#branch").prop("hidden", true);
	} 
}

function getHead() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var headItems = items[0].split(",");
			var headIdItems = items[1].split(",");
			var optionsauth = '';
			optionsauth += '<option value="">-- select -- </option>';
			for (var i = 0; i < headItems.length; i++) {
				optionsauth += '<option value="' + headIdItems[i] + '">'
						+ headItems[i] + '</option>';
			}
			$("select#mainaccgroup").html(optionsauth);
			 delvalueChange();
		} else {
		}
	}
	x.open("GET", "getMain.jsp", true);
	x.send();
}

function getMainac() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var mainacItems = items[0].split(",");
			var mainacIdItems = items[1].split(",");
			var optionsauth = '';
			optionsauth += '<option value=""> -- select --</option>';
			for (var i = 0; i < mainacItems.length; i++) {
				optionsauth += '<option value="' + mainacIdItems[i] + '">'
						+ mainacItems[i] + '</option>';
			}
			$("select#subaccgroup").html(optionsauth);
			$("select#tansaccgroup").html(optionsauth);
			delvalueChange();
		} 
		else {
		}
	}
	x.open("GET", "getSubTranAccmain.jsp", true);
	x.send();
}

function getAcgroup(value,check)
{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	if (check==1)
		 		{
		 		 $('#subaccgpname').val(items) ;
		 		}		 		
		 	else if (check==2)
		 		{
		 		 $('#transcaccgpname').val(items) ;
		 		}
		 }
	       else
		  {
		  }
    }
     x.open("GET","disAcgroup.jsp?subaccountgroup="+value,true);
    x.send();
   
  }
function funChkButton(){
}

function funNotify(){
if (document.getElementById('category3').checked) {
	 var currs=document.getElementById("currs").value; 
	 if(currs=="")
		 {
		 document.getElementById("errormsg").innerText=" * Select Currency";
		 return 0;
		 }
	 var ratess=document.getElementById("ratess").value; 
	 if(parseFloat(ratess)>0)
		 {
		 
		 }
	 else
		 {
		 document.getElementById("ratess").focus();
		 document.getElementById("errormsg").innerText=" * Rate Should Be Greater Than Zero";
		 return 0;
		 }
}
	 if ($("#mode").val() =="A") {
		 var radval=document.getElementById("radiosaveval").value; 
		
		 if(radval=="")
			 {
			 document.getElementById("errormsg").innerText=" *Select One Account";
			 return 0;
			 }
		 
		 var codeval=document.getElementById("codeval").value; 
		 if(codeval==1)
		 {
			 document.getElementById("errormsg").innerText="Account Code Already Exists";
		 return 0;
		 }
		 else{
			 document.getElementById("errormsg").innerText="";
			 }
	         }
	 if($("#mode").val() =="E")
		 {
		 var codeval=document.getElementById("codeval").value; 
		 if(codeval==1)
		 {
			 document.getElementById("errormsg").innerText="Account Code Already Exists";
		 return 0;
		 }
		 else{
			 document.getElementById("errormsg").innerText="";
			 }
		 }
	 if ($("#mode").val() =="view") {
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
		    $('#mainaccgroup').attr('disabled', false);
		}
	  return 1;
}

function maincheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";
 if(document.getElementById("mainacccode").value!=""){
	var code=document.getElementById("mainacccode").value;
	funtest(code);
}
else {} 
}

function subcheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";	
if(document.getElementById("subacccode").value!=""){
	var code=document.getElementById("subacccode").value;
	funtest(code);
}
else {}
}

function trancheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";
if(document.getElementById("transacccode").value!=""){
	var code=document.getElementById("transacccode").value;
	funtest(code);
}
else {}
}

   function funtest(code)
           {
	   var masterdoc=document.getElementById("docno").value;
	  
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 		 if(items!="")
		 		{
		 			document.getElementById("codeval").value=1;
		 			document.getElementById("errormsg").innerText="Account Code Already Exists";
		 			return  false;
		 			 
		 		}
		 		 else
		 			 {
		 			document.getElementById("codeval").value="";
		 			document.getElementById("errormsg").innerText="";
		 			return  true;
		 			 }
		 }
	       else
		  {
	    	   
		  }
    }
	x.open("GET", 'checkAcccode.jsp?code='+code+'&masterdoc='+masterdoc, true);
    x.send();
	}  
	
   function getbranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var headItems = items[0].split(",");
				var headIdItems = items[1].split(",");
				var optionsauth = '';
				for (var i = 0; i < headItems.length; i++) {
					optionsauth += '<option value="' + headIdItems[i] + '">'
							+ headItems[i] + '</option>';
				}
				$("select#branchone").html(optionsauth);
				if($('#interbr1').val()!="")
		 		{
		 		$('#branchone').val($('#interbr1').val());
		 		}
			} else {
			}
		}
		x.open("GET", "getbranch.jsp", true);
		x.send();
	}
	
   function getSecbranch(second)
   {
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var headItems = items[0].split(",");
				var headIdItems = items[1].split(",");
				var optionsauth = '';
				for (var i = 0; i < headItems.length; i++) {
					optionsauth += '<option value="' + headIdItems[i] + '">'
							+ headItems[i] + '</option>';
				}
				$("select#branchtwo").html(optionsauth);
				if($('#interbr2').val()!="")
				{
				$('#branchtwo').val($('#interbr2').val());
				}
			} else {
			}
		}
		x.open("GET", 'secondBranch.jsp?second='+second, true);
		x.send();
   }
   
   function delvalueChange()
   {
	  if(document.getElementById("radiotick").value==1)
		  {
		  document.getElementById("category1").checked = true;
		  }
	  else if(document.getElementById("radiotick").value==2)
		  {
		  document.getElementById("category2").checked = true;
		  }
	 else if(document.getElementById("radiotick").value==3)
	  {
	  document.getElementById("category3").checked = true;
	  }
	  
	  if($('#checksetval').val()!="")
	  {
	 $('#mainaccgroup').val($('#checksetval').val());
	  }
 
	   if($('#subchecksetval').val()!="")
	  {
	 $('#subaccgroup').val($('#subchecksetval').val());
	  }
	  if($('#tranchecksetval').val()!="")
	  {
	 $('#tansaccgroup').val($('#tranchecksetval').val());
	  }
	
	 if(document.getElementById("intertick").value==1)
	  {
	  document.getElementById("interbranch").checked = true;
	  $("#branch").prop("hidden", false);
	  }
	 else
		 {
		document.getElementById("interbranch").checked = false;
		$("#branch").prop("hidden", true);
		 }
   }
   
   function funclear1()
   {
	   document.getElementById("subchecksetval").value=="";
	   document.getElementById("tranchecksetval").value=="";
   }
   function funclear2()
   {
	   document.getElementById("checksetval").value=="";
	   document.getElementById("tranchecksetval").value=="";
   }
   function funclear3()
   {
	   document.getElementById("checksetval").value=="";
	   document.getElementById("subchecksetval").value=="";
   }

function setValues() {
	if($('#datehidden').val()){
		$("#date_accountmaster").jqxDateTimeInput('val', $('#datehidden').val());
	}
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	delvalueChange();
}

function checkreq()
{
if(document.getElementById('radiotick').value==1)
	{
	if(document.getElementById("mainacconame").value=="")
		{ 
		 document.getElementById("errormsg").innerText=" *Enter Account Name";
		 return 0;
		}
	}
else  if(document.getElementById('radiotick').value==2)
{
     if(document.getElementById("subaccname").value=="")
	{
    	 document.getElementById("errormsg").innerText=" *Enter SubAccount Name";
    	 return 0;
	}
}
else  if(document.getElementById('radiotick').value==3)
{
    if(document.getElementById("transaccname").value=="")
	{ 
    	document.getElementById("errormsg").innerText=" *Enter TraAccount Name";
    	return 0;
	}
}
else
	{
	 document.getElementById("errormsg").innerText="";
	}

}
function dismassge()
{
	document.getElementById("errormsg").innerText="";
}
	
function funExcelBtn(){
    var url=document.URL;
    var reurl=url.split("accountsmaster");
    top.addTab("ChartOfAccounts",reurl[0]+"accountsmaster/chartOfAccount.jsp");
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
    	}
    document.getElementById("errormsg").innerText="";  
    return true;
}	

</script>

</head>
<body onload="getHead();getMainac();getbranch();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAccountmaster" action="saveAccountmaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui hidden-scrollbar">

    <!-- General Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="date_accountmaster" name="date_accountmaster" value='<s:property value="date_accountmaster"/>'></div>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' style="width:120px;" tabindex="-1" readonly />
        </div>
    </div>

    <!-- Main Account Panel -->
    <div class="middle-panel" id="main_panel">
        <span class="middle-panel-title">
            <input type="radio" id="category1" name="category" value="mainaccount" onchange="fundisable();" style="margin:0 4px 0 0; vertical-align:middle;">
            <label for="category1" style="cursor:pointer; vertical-align:middle;">Main Account</label>
        </span>
        <div id="main">
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Account Group</label>
                <select name="mainaccgroup" id="mainaccgroup" style="width:250px;" value='<s:property value="mainaccgroup"/>' onchange="funclear1();">
                    <option value="-1">--Select--</option>
                </select>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Account Code</label>
                <input type="text" name="mainacccode" id="mainacccode" style="width:150px;" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" onkeypress="javascript:return isNumber (event);">
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:120px;">Account Name</label>
                <input type="text" name="mainacconame" id="mainacconame" style="flex:1; max-width:400px;" value='<s:property value="mainacconame"/>' onblur="dismassge()">
                <input type="hidden" name="main_account" id="main_account" value='<s:property value="main_account"/>' />
            </div>
        </div>
    </div>

    <!-- Sub Account Panel -->
    <div class="middle-panel" id="sub_panel">
        <span class="middle-panel-title">
            <input type="radio" id="category2" name="category" value="subaccount" onchange="fundisable();" style="margin:0 4px 0 0; vertical-align:middle;">
            <label for="category2" style="cursor:pointer; vertical-align:middle;">Sub Account</label>
        </span>
        <div id="sub">
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Main Account Group</label>
                <select name="subaccgroup" id="subaccgroup" style="width:250px;" onChange="getAcgroup(this.value,1);" onfocus="funclear2();" value='<s:property value="subaccgroup"/>'> 
                    <option value="-1">--Select--</option>
                </select>
                <input type="text" id="subaccgpname" name="subaccgpname" style="flex:1; max-width:300px; margin-left:15px;" value='<s:property value="subaccgpname"/>' tabindex="-1" readonly />
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Account Code</label>
                <input type="text" name="subacccode" id="subacccode" style="width:150px;" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" onkeypress="javascript:return isNumber (event);">
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:120px;">Account Name</label>
                <input type="text" name="subaccname" id="subaccname" style="flex:1; max-width:400px;" value='<s:property value="subaccname"/>' onblur="dismassge()" />
                <input type="hidden" name="sub_account" id="sub_account" value='<s:property value="sub_account"/>' />
            </div>
        </div>
    </div>

    <!-- Transaction Panel -->
    <div class="middle-panel" id="trans_panel">
        <span class="middle-panel-title">
            <input type="radio" id="category3" name="category" value="transaction" onchange="fundisable();" style="margin:0 4px 0 0; vertical-align:middle;">
            <label for="category3" style="cursor:pointer; vertical-align:middle;">Transaction</label>
        </span>
        <div id="trans">
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Main Account Group</label>
                <select id="tansaccgroup" name="tansaccgroup" style="width:250px;" onChange="getAcgroup(this.value,2);" onfocus="funclear3();" value='<s:property value="tansaccgroup"/>'>
                    <option value="-1">--Select--</option>
                </select>
                <input type="text" name="transcaccgpname" id="transcaccgpname" style="flex:1; max-width:300px; margin-left:15px;" value='<s:property value="transcaccgpname"/>' tabindex="-1" readonly>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Account Code</label>
                <input type="text" name="transacccode" id="transacccode" style="width:150px;" value='<s:property value="transacccode"/>' onblur="trancheck(this.value)" onkeypress="javascript:return isNumber (event);">
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:120px;">Account Name</label>
                <input type="text" name="transaccname" id="transaccname" style="flex:1; max-width:400px;" value='<s:property value="transaccname"/>' onblur="dismassge()" >
                <input type="hidden" name="tran_account" id="tran_account" value='<s:property value="tran_account"/>' />
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:120px;">Currency</label>
                <div class="input-search-container" style="width: 150px;">
                    <input type="text" name="currs" id="currs" value='<s:property value="currs"/>' placeholder="Press F3" onkeydown="getaccountdetails(event);" />
                    <svg class="magnifier-icon" onclick="if($('#mode').val()!='view' && document.getElementById('category3').checked) { $('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountGridSearch.jsp'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="lbl-right" style="width:80px; margin-left: 15px;">Rate</label>
                <input type="text" name="ratess" id="ratess" value='<s:property value="ratess"/>' onblur="funRoundRate(this.value,this.id);" onkeypress="javascript:return isNumber (event);" style="width:100px; text-align: right;"> 
            </div>
        </div>
    </div>

    <!-- Advanced / Interbranch Settings Panel -->
    <div class="middle-panel" id="advanced_panel">
        <span class="middle-panel-title">Settings</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:140px; display:flex; align-items:center; justify-content:flex-end; gap:4px;">
                <input type="checkbox" id="interbranch" name="interbranch" onchange="funhidden();" value="1" style="margin:0; width:auto; height:auto !important; cursor:pointer;" /> Inter branch Account 
            </label>
            
            <div id="branch" hidden="true" style="display:flex; align-items:center; gap:15px; margin-left:15px; flex:1;">
                <label class="lbl-right" style="width:60px;">Branch 1</label>
                <select name="branchone" id="branchone" required="required" style="width:200px;" value='<s:property value="branchone"/>' onClick="getSecbranch(this.value)">
                    <option value="0">--Select--</option> 
                </select>
                
                <label class="lbl-right" style="width:60px;">Branch 2</label>
                <select name="branchtwo" id="branchtwo" required="required" style="width:200px;" value='<s:property value="branchtwo"/>'>
                    <option value="0">--Select--</option> 
                </select>  
            </div>
        </div>
    </div>

    <!-- Hidden Fields -->
    <div style="display:none;">
        <input type="radio" name="data" value="debit" checked>Debit<br>
        <input type="radio" name="data" value="Credit">Credit
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
        <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>'> 
        <input type="hidden" id="currsid" name="currsid" value='<s:property value="currsid"/>'>
        <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>'>
        <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>'>
        <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>'>
        <input type="hidden" id="intertick" name="intertick" value='<s:property value="intertick"/>'>
        <input type="hidden" id="interbr1" name="interbr1" value='<s:property value="interbr1"/>'>
        <input type="hidden" id="interbr2" name="interbr2" value='<s:property value="interbr2"/>'>
        <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>'>
        <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>'>  
        <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>'>  
    </div>

</div>
</form>
</div>
  
<div id="accountSearchwindow"><div></div></div>

</body>
</html>