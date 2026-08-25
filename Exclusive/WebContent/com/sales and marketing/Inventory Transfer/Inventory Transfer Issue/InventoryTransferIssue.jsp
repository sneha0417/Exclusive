<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
<script type="text/javascript">
 
$(document).ready(function() {
	 getfrmBranch(2);
	$("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
	$('#sidesearchwndow').jqxWindow('close'); 
	 $('#branchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Branch Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#branchwindow').jqxWindow('close');
	
		
		 $('#locationwindow').jqxWindow({
				width : '25%',
				height : '58%',
				maxHeight : '70%',
				maxWidth : '45%',
				title : 'Location Search',
				position : {
					x : 420,
					y : 87
				},
				theme : 'energyblue',
				showCloseButton : true,
				keyboardCloseKey : 27
			});
			$('#locationwindow').jqxWindow('close');
		
			$( "#brchName" ).change(function() {
				   if(document.getElementById("mode").value=="A"){
					   
					   getfrmBranch(1);
					
				   }
				 });
			
			$( "#cmbreftype" ).change(function() {
				   if(document.getElementById("mode").value=="A"){
					   
					   if(document.getElementById("cmbreftype").value=="ILT"){
					   
					   document.getElementById("txttobranch").value= document.getElementById("txtfrmbranch").value;
						document.getElementById("branchtoid").value=document.getElementById("branchfrmid").value;
					   }
					   else{
						   document.getElementById("txttobranch").value="";
						   document.getElementById("branchtoid").value="";
					   }
					   
				   }
				 });
			
			$('#txttobranch').dblclick(function(){
				if ($("#mode").val() == "view") {
					
					return 0;
					
				}
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				 if(document.getElementById("cmbreftype").value=="IBT"){
				var branchfrmid=document.getElementById("branchfrmid").value;
			    branchSearchContent('branchSearch.jsp?branchfrmid='+branchfrmid);
				 }
				
			 });
			
			$('#txtfrmlocation').dblclick(function(){
if ($("#mode").val() == "view") {
					
					return 0;
					
				}
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				var branchid=document.getElementById("branchfrmid").value;
				var searchtype="1";
				locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype);
				
			 });
			
			
			$('#txttolocation').dblclick(function(){
if ($("#mode").val() == "view") {
					
					return 0;
					
				}  
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				var branchid=document.getElementById("branchtoid").value;
				var searchtype="2";
				locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype+'&cmbreftype='+$("#cmbreftype").val()+'&frmlocation='+document.getElementById("locationfrmid").value);
				
			 });
			
			$('#rrefno').dblclick(function(){
if ($("#mode").val() == "view") {
					
					return 0;
					
				}
				if($("#cmbreftype").val()==""){
					document.getElementById("errormsg").innerText="Select an inventory Recept Type";
					return 0;
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				$('#refnosearchwindow').jqxWindow('open');
				refsearchContent('refnosearch.jsp');
					
				 
			 });
	
	
	});
	
function productSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#sidesearchwndow').jqxWindow('open');
 		$('#sidesearchwndow').jqxWindow('setContent', data);
 
 	}); 
 	} 
	
	
	
function getLocation(event,searchtype){
	if ($("#mode").val() == "view") {
		
		return 0;
		
	}
	if(searchtype=="1"){
		var branchid=document.getElementById("branchfrmid").value;
	}
	if(searchtype=="2"){
		var branchid=document.getElementById("branchtoid").value;
	}
	
	 var x= event.keyCode;
	 if(x==114){
		 locationSearchContent('locationSearch.jsp?branchid='+branchid+'&searchtype='+searchtype+'&cmbreftype='+$("#cmbreftype").val()+'&frmlocation='+document.getElementById("locationfrmid").value);  	 }
	 else{
		 }
    	 }
    	 
function locationSearchContent(url) {
	$('#locationwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#locationwindow').jqxWindow('setContent', data);
		$('#locationwindow').jqxWindow('bringToFront');
	});
}


function getBranch(event,searchtype){
	if ($("#mode").val() == "view") {
		
		return 0;
		
	}
	if($("#cmbreftype").val()==""){
		document.getElementById("errormsg").innerText="Select an inventory Issue Type";
		return 0;
	}
	else{
		document.getElementById("errormsg").innerText="";
	}
	
	 document.getElementById("txttobranch").value="";
	 document.getElementById("branchtoid").value="";
	 //document.getElementById("cmbreftype").value="bt";
	 
	 if(document.getElementById("cmbreftype").value=="IBT"){
		 
	 
	var branchfrmid=document.getElementById("branchfrmid").value;
	 var x= event.keyCode;
	 if(x==114){
		 branchSearchContent('branchSearch.jsp?branchfrmid='+branchfrmid);  	 }
	 else{
		 }
	 }
	 else{
		 document.getElementById("txttobranch").value=document.getElementById("txtfrmbranch").value;
		 document.getElementById("branchtoid").value=document.getElementById("branchfrmid").value;
	 }
	 
   	 }
   	 
function branchSearchContent(url) {
	$('#branchwindow').jqxWindow('open');
	$.get(url).done(function(data) {
		$('#branchwindow').jqxWindow('setContent', data);
		$('#branchwindow').jqxWindow('bringToFront');
	});
}


function funReadOnly(){

	$('#frminventoryissue input').attr('readonly', true );
	
	$('#frminventoryissue select').attr('disabled', true );
	$('#date').jqxDateTimeInput({disabled: true});
	$("#jqxInvIssueGrid").jqxGrid({ disabled: true});
	//$("#jqxserviceGrid").jqxGrid({ disabled: true});

}

function funNotify(){	
	
	
	if($("#cmbreftype").val()==""){
		document.getElementById("errormsg").innerText="Select an inventory Issue Type";
		document.getElementById("cmbreftype").focus();
		return 0;
	}
	
	if($("#txtfrmbranch").val()==""){
		document.getElementById("errormsg").innerText=" Branch Should not be Blank";
		document.getElementById("txtfrmbranch").focus();
		return 0;
	}
	else if($("#txtfrmlocation").val()==""){
		document.getElementById("errormsg").innerText=" Location Should not be Blank";
		document.getElementById("txtfrmlocation").focus();
		return 0;
	}
	else if($("#txttobranch").val()==""){
		document.getElementById("errormsg").innerText=" Branch Should not be Blank";
		document.getElementById("txttobranch").focus();
		return 0;
	}
	else if($("#txttolocation").val()==""){
		document.getElementById("errormsg").innerText=" Location Should not be Blank";
		document.getElementById("txttolocation").focus();
		return 0;
	}
	else{
		document.getElementById("errormsg").innerText="";
	}
	  
	  var rows = $("#jqxInvIssueGrid").jqxGrid('getrows');
	  
	   $('#gridlength').val(rows.length);
	   
	  for(var i=0 ; i < rows.length ; i++){ 
		  
		 
	   newTextBox = $(document.createElement("input"))
	      .attr("type", "dil")
	      .attr("id", "prodg"+i)
	      .attr("name", "prodg"+i)
	      .attr("hidden", "true");
	   //alert(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::");
	   
	  newTextBox.val(rows[i].prodoc+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+rows[i].totwtkg+"::"+rows[i].kgprice+"::"+rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discper+"::"+rows[i].dis+"::"+rows[i].netotal+"::"+rows[i].specid+"::"+rows[i].outqty+"::"+rows[i].stkid+"::"+rows[i].oldqty+"::"+rows[i].foc+"::");
	  newTextBox.appendTo('form');
		    
	  }
	  
	  
  	return 1;
	}


function funRemoveReadOnly(){
	$('#date').jqxDateTimeInput({disabled: false});
	$("#jqxInvIssueGrid").jqxGrid({ disabled: false});
	//$("#jqxserviceGrid").jqxGrid({ disabled: false});
	$('#frminventoryissue select').attr('disabled', false );
		$('#txtremark').attr('readonly', false );
		$('#txtrefno').attr('readonly', false );
		$('#gridtext').attr('readonly', false );
		$('#gridtext1').attr('readonly', false );
		if ($("#mode").val() == "E") {
			$("#roundOf").val("0.0");
			$("#jqxInvIssueGrid").jqxGrid({ disabled: false});
			$("#jqxInvIssueGrid").jqxGrid('addrow', null, {});
		 
		  }
		
		if ($("#mode").val() == "A") {
			$("#prodsearchtype").val("0");
			 getfrmBranch(1);
			$("#orderValue").val("0.0");
			$("#nettotal").val("0.0");
			$("#roundOf").val("0.0");
			$("#orderValue").val("0.0");
			$('#date').val(new Date());
	 
			$("#jqxInvIssueGrid").jqxGrid('clear'); 
			$("#jqxInvIssueGrid").jqxGrid('addrow', null, {});
		}
		
	}

function getfrmBranch(type)
	{
	
	var brchid=$('#brchName').val();
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	 {
	   var items= x.responseText.trim();
	   var item = items.split('####');
		var branchid  = item[0];
		var branchname = item[2];

		document.getElementById("txtfrmbranch").value=branchname;
		document.getElementById("branchfrmid").value=branchid;
	   
	   }}
	x.open("GET","getFrmBranch.jsp?brchid="+brchid+"&type="+type,true);
	x.send();
	  
	}

function funChkButton(){
	
}

function funFocus (){
	
}

function funSearchLoad(){
	 changeContent('Mastersearch.jsp'); 
}

function setValues() {

	  if($('#hiddate').val()){
			 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
		  }

	var masterdoc_no=$('#masterdoc_no').val().trim();
	var refmasterdocno=0;
	
	 if(masterdoc_no>0){
		 
 
	 if ($('#hidcmbreftype').val() != "" || $('#hidcmbreftype').val() !=null) {
			$('#cmbreftype').val($('#hidcmbreftype').val());
		}
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
		  
		  $("#InvTransIssueGrid").load("InvTransIssueGrid.jsp?qotdoc="+masterdoc_no+"&enqdoc="+refmasterdocno+"&cond=2");
		  
	 }
	 funchkforedit();
}


function set()
{
document.getElementById("errormsg").innerText="";
}

function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  
	   var url=document.URL;

      var reurl=url.split("savetransferIssue");
      
     // $("#docno").prop("disabled", false);                
      

var win= window.open(reurl[0]+"printtransissueAction?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
   
win.focus();
	   } 
	  
	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     }
	    	
	}
 

function funchkforedit()
{



	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0)
				{
				
				 $("#btnEdit").attr('disabled', true );
				 $("#btnDelete").attr('disabled', true ); 
				 
				 
				 
				}
			else
				{
				 
				}
		  
			
			
			
		} else {
		}
	}
	x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
	x.send();    


}

</script>

<style>
	.hidden-scrollbar {
	  overflow: auto;
	  height: 530px;
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

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frminventoryissue" action="savetransferIssue" method="post" autocomplete="off">
 <jsp:include page="../../../../header.jsp"></jsp:include> 

<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"   style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date"  value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/>
  </tr>
</table>
<table width="100%" >
<tr>
<td width="50%">
<fieldset>
<legend>Inventory Transfer From</legend>
<table width="100%"  >
<tr>
    <td width="10%" align="right"> Type</td>
    <td width="27%"><select id="cmbreftype" name="cmbreftype" style="width:20%;" onchage="set()" value='<s:property value="cmbreftype"/>'>
     <option value="">--select--</option>
      <option value="IBT">Branch Trasfer</option>
      <option value="ILT">Location Transfer</option></select></td>
  </tr>
  <tr>
    <td width="21%"><div align="right">Branch</div></td>
    <td width="79%"><input type="text" id="txtfrmbranch" name="txtfrmbranch" placeholder="Press F3 to Search" style="width:50%;"  value='<s:property value="txtfrmbranch"/>'/></td>
  </tr>
  <tr>
    <td><div align="right">Location</div></td>
    <td><input type="text" id="txtfrmlocation" name="txtfrmlocation" placeholder="Press F3 to Search" style="width:50%;" onkeydown="getLocation(event,1);" value='<s:property value="txtfrmlocation"/>'/></td>
  </tr>
  
</table>

</fieldset>
</td>

<td width="50%">
<fieldset>
<legend>Inventory Transfer To</legend>
<table width="100%" >
  <tr>
    <td width="21%"><div align="right">Branch</div></td>
    <td width="79%"><input type="text" id="txttobranch" placeholder="Press F3 to Search" name="txttobranch" onkeydown="getBranch(event,2);" style="width:50%;" value='<s:property value="txttobranch"/>'/></td>
  </tr>
  <tr>
    <td><div align="right">Location</div></td>
    <td><input type="text" id="txttolocation" placeholder="Press F3 to Search" name="txttolocation" onkeydown="getLocation(event,2);" style="width:50%;" value='<s:property value="txttolocation"/>'/></td>
  </tr>
  <tr>
    <td width="10%" align="right">Remarks</td>
    <td width="27%"><input type="text" id="txtremark" name="txtremark" style="width:70%;" value='<s:property value="txtremark"/>' /></td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>
<%-- <fieldset>

<table width="100%">
  <tr>
    <td width="10%" align="right">Remarks</td>
    <td width="27%"><input type="text" id="txtremark" name="txtremark" style="width:50%;" value='<s:property value="txtremark"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset> --%><br/>

  <div id="InvTransIssueGrid"><jsp:include page="InvTransIssueGrid.jsp"></jsp:include></div><br/> 


<%-- <fieldset>
   <legend>Service</legend>
       <div id="servicegrid" ><jsp:include page="servicegrid.jsp"></jsp:include></div>
</fieldset> --%>

<%-- table width="100%">
<tr>
<td width="80%">&nbsp;<td><td width="10%" align="right"><label >Order Value :</label></td><td><input type="text" class="textbox" id="orderValue" readonly="readonly" tabindex="-1" name="orderValue" style="width:73%;" value='<s:property value="orderValue"/>'/></td>
<tr>

</table> --%>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>
<input type="hidden" name="txtdiscount" id="txtdiscount" value='<s:property value="txtdiscount"/>'>
<input type="hidden" name="txtnettotal"  id="txtnettotal" value='<s:property value="txtnettotal"/>'>
<input type="hidden"  id="orderValue"  name="orderValue"  value='<s:property value="orderValue"/>'/>
<input type="hidden" name="txtproductamt" id="txtproductamt" value='<s:property value="txtproductamt"/>'>
<input type="hidden" name="descPercentage" id="descPercentage" value='<s:property value="descPercentage"/>'>
<input type="hidden" name="prddiscount" id="prddiscount" value='<s:property value="prddiscount"/>'>
<input type="hidden" name="roundOf" id="roundOf" value='<s:property value="roundOf"/>'>

<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="refmasterdocno" name="refmasterdocno"  value='<s:property value="refmasterdocno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="servgridlen" name="servgridlen"  value='<s:property value="servgridlen"/>'/>
<input type="hidden" id="prodsearchtype" name="prodsearchtype" value='<s:property value="prodsearchtype"/>'/>

<input type="hidden" id="branchfrmid" name="branchfrmid" value='<s:property value="branchfrmid"/>'/>
<input type="hidden" id="locationfrmid" name="locationfrmid" value='<s:property value="locationfrmid"/>'/>
<input type="hidden" id="branchtoid" name="branchtoid" value='<s:property value="branchtoid"/>'/>
<input type="hidden" id="locationtoid" name="locationtoid" value='<s:property value="locationtoid"/>'/>
<input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/>
</div>
</form>
	
<div id="branchwindow">
	<div></div>
</div>	
	
<div id="locationwindow">
	<div></div>
</div>
<div id="sidesearchwndow">
	<div></div>
</div> 
	
</div>
</body>
</html>
