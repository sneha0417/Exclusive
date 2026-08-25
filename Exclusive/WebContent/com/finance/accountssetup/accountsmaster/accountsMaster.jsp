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
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">

$(document).ready(function () {    
    $("#date_accountmaster").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });   
    $('#accountSearchwindow').jqxWindow({ width: '20%', height: '50%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Currency  Search' ,position: { x: 600, y: 150 }, keyboardCloseKey: 27});
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
	 	 
	 	if($('#mode').val()!= "view" && document.getElementById('category3').checked)
		{
		 	 if(x==114){
		 	  $('#accountSearchwindow').jqxWindow('open');
		 
		 
		 	 accountSearchContent('accountGridSearch.jsp');   }
		 	 else{
		 		 }
		  } 
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);
	
		}); 
	    	}
function funFocus(){

}
 function funReset() {

} 
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
		 //alert(""+disother);
			if(disother==1)
			 {
				 $("table#main input").prop("disabled", false);
				 $("table#main input").prop("readonly", false);
				 $("table#main select").prop("disabled", false);
				 $('#category1').attr('disabled', false);
				 $('#category2').attr('disabled', true);
				 $('#category3').attr('disabled', true);
				 $("table#sub input").prop("readonly", true);
				 $("table#trans input").prop("readonly", true);
			     $('#interbranch').attr('disabled', true);
			 }
		 if(disother==2)
		 {
			 $("table#sub input").prop("disabled", false);
			 $("table#sub input").prop("readonly", false);
			 $("table#sub select").prop("disabled", false);
			 $('#subaccgpname').attr('readonly', true);
			 $('#category2').attr('disabled', false);
		 $('#category1').attr('disabled', true);
			$('#category3').attr('disabled', true);

			 $("table#trans input").prop("readonly", true);
			
			 $("table#main input").prop("readonly", true);
			$('#interbranch').attr('disabled', true);
		 }
		 if(disother==3)
		 {
			 $("table#trans input").prop("disabled", false);
			 $("table#trans input").prop("readonly", false);
			 $("table#trans select").prop("disabled", false);
			 $('#transcaccgpname').attr('readonly', true);
			 
			 $('#category3').attr('disabled', false);
		    $('#category1').attr('disabled', true);
			$('#category2').attr('disabled', true);
			 $("table#sub input").prop("readonly", true);
		
	
			 $("table#main input").prop("readonly", true);
			$('#interbranch').attr('disabled', false);
		 }
		 
	 }
	 if ($("#mode").val() =="E") {
		
		 $('#frmAccountmaster input').attr('readonly', false);
		 $('#frmAccountmaster select').attr('readonly', false);
		
		 var disother=document.getElementById("otherdis").value; 
		 //alert(""+disother);
		if(disother==1)
		 {
			 $("table#main input").prop("disabled", false);
			 $("table#main select").prop("disabled", false);
			 $('#category1').attr('disabled', false);
			 $('#category2').attr('disabled', true);
			 $('#category3').attr('disabled', true);
			 $("table#sub input").prop("readonly", true);
			 $("table#trans input").prop("readonly", true);
		     $('#interbranch').attr('disabled', true);
		 }
		 if(disother==2)
		 {
			 $("table#sub input").prop("disabled", false);
			 $("table#sub select").prop("disabled", false);
			 $('#subaccgpname').attr('readonly', true);
			 $('#category2').attr('disabled', false);
		 $('#category1').attr('disabled', true);
			 $('#category3').attr('disabled', true); 
			 $("table#trans input").prop("readonly", true); 
			 $("table#main input").prop("readonly", true);
			 $('#interbranch').attr('disabled', true);
		 }
		 if(disother==3)
		 {
			 $("table#trans input").prop("disabled", false);
			 $("table#trans select").prop("disabled", false);
			 $('#transcaccgpname').attr('readonly', true); 
			 $('#category3').attr('disabled', false);
		     $('#category1').attr('disabled', true);
			 $('#category2').attr('disabled', true);
			 $("table#sub input").prop("readonly", true);
			 $('#currs').attr('readonly', true); 
			 $("table#main input").prop("readonly", true);
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
			$("table#trans input").prop("disabled", false);
			$("table#trans select").prop("disabled", false);
			$("table#main input").prop("disabled", false);
			$("table#main select").prop("disabled", false);
			$("table#sub input").prop("disabled", false);
			$("table#sub select").prop("disabled", false);
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
		 $("table#sub input").prop("disabled", true);
		 $("table#sub select").prop("disabled", true);
		 $("table#trans input").prop("disabled", true);
		 $("table#trans select").prop("disabled", true);
		 $("table#main input").prop("disabled", false);
		 $("table#main select").prop("disabled", false);
		 document.getElementById('subaccgpname').value="";
		 document.getElementById('subacccode').value="";
		 document.getElementById('subaccname').value="";
		 document.getElementById('transcaccgpname').value="";
		 document.getElementById('transacccode').value="";
		 document.getElementById('transaccname').value="";
		 $('#docno').attr('readonly', true);
		// radiotick for tick 				
		 document.getElementById('otherdis').value=1;
		 document.getElementById('radiotick').value=1;		
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 		 
		 document.getElementById('maindel').value=1;		 
		 document.getElementById('main_account').value="mainacc";		 	
		}
	
	else if (document.getElementById('category2').checked) {
		 $('#frmAccountmaster input').attr('readonly', false);
		 $("table#main input").prop("disabled", true);
		 $("table#main select").prop("disabled", true);
		 $("table#trans input").prop("disabled", true);
		 $("table#trans select").prop("disabled", true);
		 $("table#sub input").prop("disabled", false);
		 $("table#sub select").prop("disabled", false);
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
		 $("table#main input").prop("disabled", true);
		 $("table#main select").prop("disabled", true);
		 $("table#sub input").prop("disabled", true);
		 $("table#sub select").prop("disabled", true);
		 $("table#trans input").prop("disabled", false);
		 $("table#trans select").prop("disabled", false);
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
				//alert(mainacIdItems[i]);
				optionsauth += '<option value="' + mainacIdItems[i] + '">'
						+ mainacItems[i] + '</option>';
			}
			//$("select#mainaccountgroup").html(optionsauth);
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

	
	
	//frmAccountmaster.submit();		
}

/* function checkden(tran)
{
	
	
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();

		
				if(parseInt(items)==255 || parseInt(items)==340)
					{
					
					document.getElementById("errormsg").innerText=" Transaction  ";
					return 0;
					}
				
				
				else{
				
					 
					 if ($("#mode").val() =="view") {
							$('#category1').attr('disabled', false);
							$('#category2').attr('disabled', false);
							$('#category3').attr('disabled', false);
						 $('#mainaccgroup').attr('disabled', false);
					 }
					  
					 
				$('#frmAccountmaster').submit();
					
				}
				
				
				//setValues();
			} else {
			}
		}
		x.open("GET", 'checkden.jsp?tran='+tran, true);
		x.send();
} */
function funNotify(){
	
	//alert(document.getElementById("tansaccgroup").value);
	
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
	/* 	var tran=document.getElementById("tansaccgroup").value;
		
		if(parseInt(tran)>0)
			{
			//alert("-"+tran);
			checkden(tran);
			
			}
		
		else{ */
			
	
	 
	 if ($("#mode").val() =="view") {
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
		 $('#mainaccgroup').attr('disabled', false);
	  /*  } */
	 
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
		 		//alert("1");
		 		$('#branchone').val($('#interbr1').val());
		 		}
				//getSecbranch(second);
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
		 		//alert("2");
				$('#branchtwo').val($('#interbr2').val());
				}
				//setValues();
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
	  

	  }
 	 else
 		 {
 		document.getElementById("interbranch").checked = false;
 		  
 		 
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
<jsp:include page="../../../../header.jsp"></jsp:include>
<br>
<form  id="frmAccountmaster" action="saveAccountmaster" method="post" autocomplete="off">
<fieldset width="80%">
<table width="100%" >
<tr>
<td>
 <table width="100%" >
 <tr><td width="6%" align="right">Date</td>
 <td width="31%"  align="left"><div id="date_accountmaster" name="date_accountmaster" value='<s:property value="date_accountmaster"/>'></div></td> 
	<td width="46%" align="right">Doc No.</td><td width="17%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' >
			</td></tr></table>
 <table width="100%"  >
<tr><td></td>
<td width="40%">

<fieldset style=" border: 1px solid #ccc; padding: 1em; ">
<table id="main1"><tr><td> <tr><td><input type="radio" id="category1" name="category" value="mainaccount" onchange="fundisable();"><label>Main Account</label></td>
</tr></td></tr></table>

<table width="100%" id="main" >
  <tr>
    <td width="50%" align="right"><div><label>Account Group</label></div></td>
    <td width="%"><select name="mainaccgroup" id="mainaccgroup"  style="width:92%;"  value='<s:property value="mainaccgroup"/>' onchange="funclear1();" >
      <option value="-1">--Select--</option>
    </select><%-- <input type="text" id="maindata" name="maindata" value='<s:property value="maindata"/>'> --%></td> 
    </tr>
  <tr>
     <td align="right"><div><label>Account Code</label></div></td>
    <td><input type="text" name="mainacccode" id="mainacccode" style="width:90%;" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" onkeypress="javascript:return isNumber (event);"></td>
  </tr>
  <tr>
     <td align="right"><div><label>Account Name</label></div></td>
    <td><input type="text" name="mainacconame" id="mainacconame" style="width:90%;"  value='<s:property value="mainacconame"/>' onblur="dismassge()">
    <input type="hidden" name="main_account" id="main_account"  value='<s:property value="main_account"/>' />
        </td>
  </tr>
  </table>
  </fieldset>
  
    </td>
  <td>
  
  <fieldset style=" border: 1px solid #ccc; padding: 1em; ">
  <table id="sub1"> <tr ><td><input type="radio" id="category2" name="category" value="subaccount" onchange="fundisable();"><label>Sub Account</label></td>
</tr></table>
 
 <table width="100%"  id="sub"> 
    <tr>
    <td width="20%" align="right"><div>Main account Group</div></td>
   <td width="62%"><select name="subaccgroup" id="subaccgroup"  style="width:40.5%;"  onChange="getAcgroup(this.value,1);" onfocus="funclear2();" value='<s:property value="subaccgroup"/>' > 
        <option value="-1">--Select--</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="subaccgpname" name=subaccgpname style="width:40%;" value='<s:property value="subaccgpname"/>'  />
        
        
        </td>
    </tr>
  <tr>
     <td align="right" ><div>Account Code</div></td>
    <td ><input type="text" name="subacccode" id="subacccode" style="width:40%;" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" onkeypress="javascript:return isNumber (event);"></td>
  </tr>
  <tr>
     <td align="right"><div>Account Name</div></td>
    <td ><input type="text" name="subaccname" id="subaccname" style="width:40%;" value='<s:property value="subaccname"/>' onblur="dismassge()" />
    <input type="hidden" name="sub_account" id="sub_account"  value='<s:property value="sub_account"/>' />
    </td>
  </tr>
  </table>
  </fieldset>
  
    </td> </tr>    </table>
  
 <table width="100%">
 <tr >
 <td width="60" >
 
     <fieldset style=" border: 1px solid #ccc; padding: 1em; ">
     <table id="trans1"> <tr align="center"><td><input type="radio" id="category3" name="category" value="transaction" onchange="fundisable();"><label>Transaction</label></td></tr></table>

 <table width="100%"  id="trans"   >
    <tr>  <td width="28.5%" align="right"><div>Main account Group</div></td>
   <td ><select id="tansaccgroup" name="tansaccgroup" style="width:35.5%;"  onChange="getAcgroup(this.value,2);" value='<s:property value="tansaccgroup"/>'  onfocus="funclear3();" >
        <option value="-1">--Select--</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="text" name="transcaccgpname" id="transcaccgpname" style="width:44%;"  value='<s:property value="transcaccgpname"/>' >
        </td>   </tr>
  <tr>
     <td align="right"><div>Account Code</div></td>
    <td ><input type="text" name="transacccode" id="transacccode" style="width:35%;"  value='<s:property value="transacccode"/>' onblur="trancheck(this.value)" onkeypress="javascript:return isNumber (event);"></td>
  </tr>
  <tr>
     <td align="right"><div>Account Name</div></td>
    <td ><input type="text" name="transaccname" id="transaccname" style="width:35%;"  value='<s:property value="transaccname"/>' onblur="dismassge()" >

    <input type="hidden" name="tran_account" id="tran_account"  value='<s:property value="tran_account"/>' />
    
    &nbsp; 
    Currency   <input type="text" name="currs" id="currs"  value='<s:property value="currs"/>' onkeydown="getaccountdetails(event);" />
   Rate  <input type="text" name="ratess" id="ratess"  value='<s:property value="ratess"/>' onblur="funRoundRate(this.value,this.id);" onkeypress="javascript:return isNumber (event);"  style="text-align: right;"> 
    
    </td>
  </tr>  <tr>  <td>  </td>  <td> 
 <%--  <div>
  <input type="checkbox" name="localcurrency"  id="localcurrency" value='<s:property value="localcurrency"/>' checked >local Currency
  <input type="checkbox" name="ageingdetails" id="ageingdetails" value='<s:property value="ageingdetails"/>' checked>Ageing Details
    </div> --%>
    </td>
         </tr>
  
  <tr>
  <td>
  <div width="100%">
    <div align="center">
    
        <input type="checkbox" id="interbranch" name="interbranch"  onchange="funhidden();"   value="1"/>Inter branch Account 
    
    </div>
  
    </td>     </tr>  <tr> <td></td>
  <td>
  <div  hidden="true" id="branch" >
    
        Branch <select name="branchone" id="branchone" required="required"style="width:40%;" value='<s:property value="branchone"/>' onClick="getSecbranch(this.value)">
       <option value="0">--Select--</option> 
        </select> -- 
        <select name="branchtwo" id="branchtwo" required="required"style="width:40%;" value='<s:property value="branchtwo"/>'>
       <option value="0">--Select--</option> 
        </select>  
        
    </div> </td>  </tr>
    </table>
  </fieldset>
  
  
  </td>
  <td width=30%>
  <div  hidden="true">
    <input type="radio" name="data" value="debit" checked>Debit<br>
    <input type="radio" name="data" value="Credit">Credit
  
  </div>
  
  </td></tr></table>
  </td></tr>
  <tr><td><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'></td>
  	<td><input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
  	<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
  <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>'> 
   <input type="hidden" id="currsid" name="currsid" value='<s:property value="currsid"/>'>
  
  <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>'>
  <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>'>
  <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>'>
  </td>         
  <td>
  
  <input type="hidden" id="intertick" name="intertick" value='<s:property value="intertick"/>'>
  
  <input type="hidden" id="interbr1" name="interbr1" value='<s:property value="interbr1"/>'>
  <input type="hidden" id="interbr2" name="interbr2" value='<s:property value="interbr2"/>'>
  
    <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>'>
  
  
   <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>'>
  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
  

 
  <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>'>  <!--  for delete condition chk -->
 
   <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>'>  <!-- foe code VAL -->
 

  
  </td>
  </tr>          
  </table>          
     </fieldset>
<br>
  </form>
  </div>
  
    <div id="accountSearchwindow">
	   <div></div>
	</div>
  </body>
  </html>
  