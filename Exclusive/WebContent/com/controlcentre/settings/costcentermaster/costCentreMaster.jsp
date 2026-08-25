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
    $("#date_costmaster").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });

  //  getHead();getMainac();

});
function funFocus(){
	
}
 function funReset() {
	
	
} 
function funReadOnly() {
	$('#frmCostmaster input').attr('readonly', true);
	
		
		$('#category1').attr('disabled', true);
		$('#category2').attr('disabled', true);
		$('#category3').attr('disabled', true);
		$('#frmCostmaster select').attr('disabled', true);
	
	delvalueChange();
	
}
function funRemoveReadOnly() {
	$('#frmCostmaster input').attr('readonly', true);

	$('#category1').attr('disabled', false);
	$('#category2').attr('disabled', false);
	$('#category3').attr('disabled', false);
	 if ($("#mode").val() =="A") {
		 $('#date_costmaster').val(new Date());
		
		 $('#frmAccountmaster select').attr('disabled', true);
		 
		 var disother=document.getElementById("otherdis").value; 
		 
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

 }
		 
		 
	 }
	
	 if ($("#mode").val() =="E") {
		 $('#frmCostmaster input').attr('readonly', false);
		 $('#frmCostmaster select').attr('readonly', false);
		 var disother=document.getElementById("otherdis").value; 
		 
				 if(disother==1)
			 {
					 
			 $("table#main input").prop("disabled", false);
			 $("table#main select").prop("disabled", false);
			 $('#category1').attr('disabled', false);
			 $('#category2').attr('disabled', true);
				$('#category3').attr('disabled', true);
				 $("table#sub input").prop("readonly", true);
				
				 $("table#trans input").prop("readonly", true);
				
			
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
		
	
			 $("table#main input").prop("readonly", true);
		
		 }
		 
	 }
	 if ($("#mode").val() =="D") {
			$('#frmCostmaster input').attr('readonly', false);
			
		
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
			 $("table#trans input").prop("disabled", false);
			 $("table#trans select").prop("disabled", false);
			 $("table#main input").prop("disabled", false);
			 $("table#main select").prop("disabled", false);
			 $("table#sub input").prop("disabled", false);
			 $("table#sub select").prop("disabled", false);
			$('#frmCostmaster select').attr('disabled', false);
	 }
	$('#docno').attr('readonly', true);
}
function funSearchLoad(){
	
	changeContent('masterSearch.jsp'); 
 }
function fundisable(){
	
	
	if (document.getElementById('category1').checked) {
		$('#frmCostmaster input').attr('readonly', false);
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
		 document.getElementById('radiotick').value=1;
		
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		
		 document.getElementById('maindel').value=1;
		 document.getElementById('otherdis').value=1;
		 document.getElementById('main_account').value="mainacc";
		
		}
	else if (document.getElementById('category2').checked) {
		$('#frmCostmaster input').attr('readonly', false);
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
		 
		 document.getElementById('radiotick').value=2;
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 document.getElementById('maindel').value=2;
		 document.getElementById('otherdis').value=2;
		 document.getElementById('sub_account').value="subacc";
		}
	else if (document.getElementById('category3').checked) {
		$('#frmCostmaster input').attr('readonly', false);
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
		 $('#docno').attr('readonly', true);
			document.getElementById('radiotick').value=3;
			
			 document.getElementById('radiosaveval').value=1;
			 document.getElementById("errormsg").innerText=""; 
			 document.getElementById('maindel').value=3;
			 document.getElementById('otherdis').value=3;
			 
			 document.getElementById('tran_account').value="tranacc";
			 
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
				optionsauth += '<option value="' + headIdItems[i].trim() + '">'
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
			var mainacItems = items[0].trim().split(",");
			var mainacIdItems = items[1].trim().split(",");
			var optionsauth = '';
			optionsauth += '<option value=""> -- select --</option>';
			for (var i = 0; i < mainacItems.length; i++) {
				//alert(mainacIdItems[i]);
				optionsauth += '<option value="' + mainacIdItems[i].trim() + '">'
						+ mainacItems[i].trim()+ '</option>';
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

	
	
	frmCostmaster.submit();		
}

function funNotify(){
	
	
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
			 document.getElementById("errormsg").innerText="Cost Code Already Exists";
		 return 0;
		 }
		 else{
		 document.getElementById("errormsg").innerText="";
		
		 }
		 
		 
		 var radiotick=document.getElementById("radiotick").value; 
		 if(radiotick==1)
		 {
			 
			 var mainval=document.getElementById("mainaccgroup").value;
			 if(mainval=="")
				 {
			 document.getElementById("errormsg").innerText="Select   Cost Group";
			 document.getElementById("mainaccgroup").focus();
		     return 0;
				 }
			 
			 var mainacc=document.getElementById("mainacconame").value;
			 if(mainacc=="")
				 {
			 document.getElementById("errormsg").innerText="Enter Cost Name";
			 document.getElementById("mainacconame").focus();
		     return 0;
				 }
			 
			 
			 
		 }
		 
		 else if(radiotick==2)
		 {
			 
			 var subval=document.getElementById("subaccgroup").value;
	
			 if(subval=="")
				 {
			 
			 document.getElementById("errormsg").innerText="Select  Cost Group";
			 document.getElementById("subaccgroup").focus();
		     return 0;
				 }
			 var subacc=document.getElementById("subaccname").value;
			 if(subacc=="")
				 {
			 document.getElementById("errormsg").innerText="Enter Cost Name";
			 document.getElementById("subaccname").focus();
		     return 0;
				 }
		 }
		 
		 else if(radiotick==3)
		 {
			 
		var tranval=document.getElementById("tansaccgroup").value;
			 if(tranval=="")
			 {
			 document.getElementById("errormsg").innerText=" Select  Cost Group";
			 document.getElementById("tansaccgroup").focus();
		     return 0;
			 }
			 
			 var tranacc=document.getElementById("transaccname").value;
			 if(tranacc=="")
				 {
			 document.getElementById("errormsg").innerText="Enter Cost Name";
			 document.getElementById("transaccname").focus();
		     return 0;
				 }
			 
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
		 document.getElementById("errormsg").innerText="Cost Code Already Exists";
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
	  // alert("masterdoc"+masterdoc);
	var x=new XMLHttpRequest();
	
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 	
		 	
		 		 if(items!="")
		 		{
		 			document.getElementById("codeval").value=1;
		 			document.getElementById("errormsg").innerText="Cost Code Already Exists";
		 			 
		 			 
		 		}
		 		 else
		 			 {
		 			document.getElementById("codeval").value="";
		 			document.getElementById("errormsg").innerText="";
		 			 }
		 		
		 }
	       else
		  {
	    	   
		  }
    }
	x.open("GET", 'checkAcccode.jsp?code='+code+'&masterdoc='+masterdoc, true);
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
		$("#date_costmaster").jqxDateTimeInput('val', $('#datehidden').val());
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
		
		 document.getElementById("errormsg").innerText=" Enter Account Name";
		 return 0;
		
		}
	}
else  if(document.getElementById('radiotick').value==2)
{
     if(document.getElementById("subaccname").value=="")
	{
    	 
    	 document.getElementById("errormsg").innerText=" Enter SubAccount Name";
    	 return 0;
	}
}
else  if(document.getElementById('radiotick').value==3)
{
    if(document.getElementById("transaccname").value=="")
	{ 
    	
    	document.getElementById("errormsg").innerText=" Enter TraAccount Name";
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
    var reurl=url.split("costcentermaster");
    top.addTab("ChartOfCost",reurl[0]+"costcentermaster/chartOfCost.jsp");
}
</script>

</head>


<body onload="getHead();getMainac();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<jsp:include page="../../../../header.jsp"></jsp:include>
<br>
<form  id="frmCostmaster" action="saveCostmaster" method="post" autocomplete="off">
<fieldset width="80%">
<table width="100%" >
<tr>
<td>
<!-- <div align="center" hidden="true" id="erroMsg"></div> -->
 <table width="100%" >
 <tr><td width="6%" align="right">Date</td>
 <td width="31%"  align="left"><div id="date_costmaster" name="date_costmaster" value='<s:property value="date_costmaster"/>'></div></td> 
	<td width="46%" align="right">Doc No.</td><td width="17%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' >
			</td></tr></table>
 <table width="100%"  >
<tr><td></td>
<td width="40%">
<fieldset>
<table id="main1"><tr><td> <tr><td><input type="radio" id="category1" name="category" value="mainaccount" onchange="fundisable();"><label>Main</label></td>
</tr></td></tr></table>

<table width="100%" id="main" >
  <tr>
    <td width="50%" align="right"><div><label>Cost Group</label></div></td>
    <td width="%"><select name="mainaccgroup" id="mainaccgroup"  style="width:92%;"  value='<s:property value="mainaccgroup"/>' onchange="funclear1();" >
      <option value="-1">--Select--</option>
    </select><%-- <input type="text" id="maindata" name="maindata" value='<s:property value="maindata"/>'> --%></td> 
    </tr>
  <tr>
     <td align="right"><div><label>Cost Code</label></div></td>
    <td><input type="text" name="mainacccode" id="mainacccode" style="width:90%;" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" ></td>
  </tr>
  <tr>
     <td align="right"><div><label>Cost Name</label></div></td>
    <td><input type="text" name="mainacconame" id="mainacconame" style="width:90%;"  value='<s:property value="mainacconame"/>' onblur="dismassge()">
  <input type="hidden" name="main_account" id="main_account"  value='<s:property value="main_account"/>' />
        </td>
  </tr>
  </table>
  </fieldset>
  
    </td>                 
  <td>
  
  <fieldset>
  <table id="sub1"> <tr ><td><input type="radio" id="category2" name="category" value="subaccount" onchange="fundisable();"><label>Sub</label></td>
</tr></table>
 
 <table width="100%"  id="sub"> 
    <tr>
    <td width="20%" align="right"><div>Main Cost Group</div></td>
   <td width="62%"><select name="subaccgroup" id="subaccgroup"  style="width:40.5%;"  onChange="getAcgroup(this.value,1);" onfocus="funclear2();" value='<s:property value="subaccgroup"/>' > 
        <option value="-1">--Select--</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="subaccgpname" name=subaccgpname style="width:40%;" value='<s:property value="subaccgpname"/>'  />
        
        
        </td>
    </tr>
  <tr>
     <td align="right" ><div>Cost Code</div></td>
    <td ><input type="text" name="subacccode" id="subacccode" style="width:40%;" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" ></td>
  </tr>
  <tr>
     <td align="right"><div>Cost Name</div></td>
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
 
     <fieldset>
     <table id="trans1"> <tr align="center"><td><input type="radio" id="category3" name="category" value="transaction" onchange="fundisable();"><label>Transaction</label></td></tr></table>

 <table width="100%"  id="trans" >
    <tr>  <td width="28.5%" align="right"><div>Main Cost Group</div></td>
   <td ><select id="tansaccgroup" name="tansaccgroup" style="width:35.5%;"  onChange="getAcgroup(this.value,2);"   onfocus="funclear3();" >
        <option value="-1">--Select--</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="transcaccgpname" id="transcaccgpname" style="width:35%;"  value='<s:property value="transcaccgpname"/>' >
        </td>   </tr>
  <tr>
     <td align="right"><div>Cost Code</div></td>
    <td ><input type="text" name="transacccode" id="transacccode" style="width:35%;"  value='<s:property value="transacccode"/>' onblur="trancheck(this.value)" ></td>
  </tr>
  <tr>
     <td align="right"><div>Cost Name</div></td>
    <td ><input type="text" name="transaccname" id="transaccname" style="width:35%;"  value='<s:property value="transaccname"/>' onblur="dismassge()" >
    
     <input type="hidden" name="tran_account" id="tran_account"  value='<s:property value="tran_account"/>' />
    </td>
  </tr>  <tr>  <td>  </td>  <td>
 
    </td>
         </tr>

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
  
  <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>'>
  <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>'>
  <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>'>
  </td>         
  <td>
  

    <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>'>
  
   <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>'>
   <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>'>
  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
  
    <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>'>  <!-- foe code VAL -->
  
 
  
  </td>
  </tr>          
  </table>          
     </fieldset>
<br>
  </form>
  </div>
  </body>
  </html>
  