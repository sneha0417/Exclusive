<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;
}
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>
<script type="text/javascript">
 $(document).ready(function () {
	 
   	$("#estmDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});

     ///ans
     $('#currencysearchwindow').jqxWindow({ width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Currency Search' ,position: { x: 500, y: 120 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#currencysearchwindow').jqxWindow('close');
     $('#refnosearchwindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Enquiry Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#refnosearchwindow').jqxWindow('close');
	 $('#unitsearchwindow').jqxWindow({width: '20%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%', title: 'Unit Search',position: { x: 500, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#unitsearchwindow').jqxWindow('close');
	 $('#vendorsearchwindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vendor Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#vendorsearchwindow').jqxWindow('close');
	 $('#calculatewindow').jqxWindow({width: '40%', height: '48%',  maxHeight: '60%' ,maxWidth: '41%' , title: 'Calculate',position: { x: 10, y: 180 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#calculatewindow').jqxWindow('close');
	 
	 $("#refno").dblclick(function(){
		 refnoSearchContent("refnoSearch.jsp");
	 });
	 
 });
 function searchRefno(){
	 var x= event.keyCode;
	 if(x==114){
		 refnoSearchContent("refnoSearch.jsp");
	 }
 }
 function refnoSearchContent(url) {
	 	$('#refnosearchwindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#refnosearchwindow').jqxWindow('setContent', data);
		$('#refnosearchwindow').jqxWindow('bringToFront');
	}); 
 }
 //ans2-end
 
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
				 $("#btnSavedata").hide();
				 $("#jqxEstimation").jqxGrid({ disabled: true});
			 }
			 else
			 {
				 $("#jqxEstimation").jqxGrid({ disabled: false});
				 $('#btnSavedata').show();
			 }
		 } 
		 else {
		 }
	 }
	 x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
	 x.send();    
 }
    function funReset(){
		//$('#frmEstimation')[0].reset(); 
	}
	function funReadOnly(){
		$('#frmEstimation input').prop('readonly', true );
		$('#frmEstimation textarea').attr('readonly', true );
		$('#frmEstimation select').attr('disabled', true);
		$('#refno').attr('disabled', true);
// 		$('#btnCalculate').attr('disabled', true);
		$('#estmDate').jqxDateTimeInput({ disabled: true});
	    $("#jqxEstimation").jqxGrid({ disabled: true});
	    if(document.getElementById("masterdoc_no").value>0)
		{
	    	funchkforedit();
		}
		$("#estmdiv").hide();
	}
	function funRemoveReadOnly(){
		$('#frmEstimation input').attr('readonly', true );
		$('#frmEstimation textarea').attr('readonly', false );
		$('#frmEstimation select').attr('disabled', false);
		$('#refno').attr('disabled', false);
		$('#btnCalculate').attr('disabled', false);
		$('#estmDate').jqxDateTimeInput({ disabled: false});
		$("#jqxEstimation").jqxGrid({ disabled: false}); 
		$("#jqxEnquiry").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		$("#estmdiv").hide();
		$('#txtRemarks').attr('readonly', false );
		
		$("#estmdiv").hide();
		
		$("#jqxEstimation").jqxGrid('clear');
		if ($("#mode").val() == "A") {
			$('#estmDate').val(new Date());
			$("#jqxEnquiry").jqxGrid('clear');
			$("#jqxEstimation").jqxGrid('clear');
		    $("#jqxEstimation").jqxGrid('addrow', null, {});
		}
		if ($("#mode").val() == "E") {
			if(document.getElementById("txtradio").value==1){
				$('#r2').attr('disabled', true);	
			}
			else{
				$('#r1').attr('disabled', true);
			}
		}
	}
	function funFocus(){
		$("#refno").focus();
	}
	function funSearchLoad(){
		 changeContent('mastersearch.jsp'); 
		 
	}
 
	function setValues() {
   		if($('#hidestmDate').val()){
   			
			$("#estmDate").jqxDateTimeInput('val', $('#hidestmDate').val());
		}
   		var docVal1 = document.getElementById("masterdoc_no").value;
   		if(docVal1>0)
   		{
   			funchkforedit();
   			var indexVal2 = document.getElementById("masterdoc_no").value;
   			$("#enqdiv").load("reqDetails.jsp?enqrdocno="+indexVal2);
   		}
   		if($('#msg').val()!=""){
   			$.messager.alert('Message',$('#msg').val());
   		}
   		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";	
   		$("#enqdiv").load('reqDetails.jsp?enqrdocno='+document.getElementById("hidrefno").value);
	
	}
        
	function funNotify(){
		return 1;
	}
	
	function funSave(){
		 var rows = $("#jqxEstimation").jqxGrid('selectedrowindexes');
 		  var length=rows.length;
 		 if(length==0){
   	    	$.messager.alert('Message','Choose a document','warning');
 		 }
   	    else{
 		  $.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
 		     if (r){ 
 			  	   var gridarray=new Array();
 			  	    for(var i = 0; i < rows.length; i++)
 			  	    {
 			  	        gridarray[i]=($('#enqdoc').val()+"::"+$('#masterdoc_no').val()+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'srvdocno')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'curid')
 			  	        +"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'rate')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'price')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'qty')
 			  	        +"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'unitid')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'total')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'basetotal')
 			  	        +"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'billing')+"::"+$("#jqxEstimation").jqxGrid('getcellvalue',rows[i],'vndid')+"::");
 			  	    }
 			  	    saveData(gridarray);
 		     }
 		  });
   	    }
	}
	function saveData(gridarray){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				if(parseInt(items)=="11")  
				{ 
					$.messager.alert('Message', '  ASSIGNMENT ALREADY DONE ','warning');
					$('#jqxEstimation').jqxGrid('clear');
				}
				else if(parseInt(items)=="0")  
				{ 
					$.messager.alert('Message', '  Record Successfully Updated ','info');
					$('#jqxEstimation').jqxGrid('clear');
				}
				else
				{
					$.messager.alert('Message', '  Not Updated  ','warning');
				}
			}
		}
		x.open("GET","estmSave.jsp?gridarray="+gridarray+"&docno="+$('#masterdoc_no').val()+"&enqdocno="+$('#enqdoc').val(),true);    
		x.send();
	}
	
	function funCalculate(rowindex1,enqddoc,mode){
	 	$('#calculatewindow').jqxWindow('open');
		$.get('calcGrid.jsp?rowindex='+rowindex1+'&enqddoc='+enqddoc+'&mode='+mode).done(function (data) {
			$('#calculatewindow').jqxWindow('setContent', data);
			$('#calculatewindow').jqxWindow('bringToFront');
		}); 
	}
	
	function funPrintBtn(){
		 if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			 var url=document.URL;
			 var reurl;
			 if( url.indexOf('savecargoEstimation') >= 0){
				 reurl=url.split("savecargoEstimation");
			 }else {
				 reurl=url.split("estimation.jsp");
			 }
			 $("#docno").prop("disabled", false);                
			 var dtype=$('#formdetailcode').val();
			 var brhid='<%=session.getAttribute("BRANCHID").toString()%>';
			 var win= window.open(reurl[0]+"printEstimation?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=yes,toolbar=yes");
			 win.focus();
		 
		 }
		 else {
  	      $.messager.alert('Message','Select a Document....!','warning');
  	      return false;
  	     }
	 }
	
</script>
</head>
<body width="100%" onload="setValues()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEstimation" action="savecargoEstimation" autocomplete="OFF" >
<jsp:include page="../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
 <fieldset>
<table width="100%" >                        
  <tr>
    <td width="11%" align="right">Date</td>
    <td width="11%"><div id="estmDate" name="estmDate" value='<s:property value="estmDate"/>'></div>  
    <input type="hidden" name="hidestmDate" id="hidestmDate" value='<s:property value="hidestmDate"/>'></td>
    <td width="17%" align="right">Ref Type</td>
    <td width="6%"><select name="cmbreftype" id="cmbreftype" style="width:100%">
    <option value="ENQ">ENQ</option></select>
    </td>
    <td width="4%" align="right">Ref No.</td>
    <td width="22%"><input type="text" name="refno" id="refno" value='<s:property value="refno"/>' placeholder="Press F3 to search" readonly onkeydown="searchRefno(event);" />
    <input type="hidden" name="hidrefno" id="hidrefno" value='<s:property value="hidrefno"/>'></td>
    <td width="12%" align="right">Doc No</td>
    <td width="17%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' /></td>
  </tr>
       
  <tr>
    <td align="right">Client</td>     
    <td colspan="5"><input type="text" id="txtclient" name="txtclient" value='<s:property value="txtclient"/>'>
		
		<input type="text" id="txtclientname" name="txtclientname" style="width: 40%;" value='<s:property value="txtclientname"/>' ></td>
    
  </tr>
 
 </table>
  <table width="100%" >
   <tr>
    <td width="10.8%" align="right">Address</td>
    <td><input type="text" id="txtaddress" name="txtaddress" style="width:70%;" value='<s:property value="txtaddress"/>'></td>


  </tr>
  </table>
  <table  width="100%">
  <tr>
    <td align="right" width="10.8%">MOB</td>
    <td width="33.2%" ><input type="text" id="txtmobile" name="txtmobile" style="width:68.7%;" value='<s:property value="txtmobile"/>' ></td>
    <td align="right" width="3%" >Email</td>
    <td > <input type="email" id="txtemail" name="txtemail" style="width: 49.2%;" value='<s:property value="txtemail"/>' ></td>
  </tr>
  </table>
  <table  width="100%">
  <tr>
  <td align="right" width="10.8%">Remarks</td> 
    <td colspan="3">
    <input type="text" id="txtRemarks" name="txtRemarks" style="width:69.9%;" value='<s:property value="txtRemarks"/>'></td>
  </tr>
</table>  
</fieldset>           
<br/>
<fieldset>
<table width="100%">

<tr><td>
<div id="enqdiv"><jsp:include page="reqDetails.jsp"></jsp:include></div>
</td></tr>
</table>
</fieldset>
<br/>

<div id="estmdiv" hidden="hidden">
<fieldset>
<table width="100%">
<tr><td align="center">
<input type="button" name="btnSavedata" id="btnSavedata" value="Save" class="myButton" onclick="funSave();">
</td></tr>
<tr><td>
<div id="estdiv"><jsp:include page="estmgrid.jsp"></jsp:include></div>
</td></tr>
</table>
</fieldset>
</div>

<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" name="enqdoc" id="enqdoc" value='<s:property value="enqdoc"/>' />
<input type="hidden" name="enqdtype" id="enqdtype" value='<s:property value="enqdtype"/>' />
<input type="hidden" id="enqgridlenght" name="enqgridlenght" />
<input type="hidden" name="gridval" id="gridval" value='<s:property value="gridval"/>' />  
<input type="hidden" name="forradiochk" id="forradiochk" value='<s:property value="forradiochk"/>' />  
<input type="hidden" name="brandval" id="brandval" value='<s:property value="brandval"/>' />  
<input type="hidden" name="fromdatesval" id="fromdatesval" value='<s:property value="fromdatesval"/>' />  
<input type="hidden" name="todateval" id="todateval" value='<s:property value="todateval"/>' />  
<input type="hidden" name="txtradio" id="txtradio" value='<s:property value="txtradio"/>' /> 
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>

<div id="currencysearchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>
<div id="unitsearchwindow">
   <div ></div>
</div>
<div id="vendorsearchwindow">
   <div ></div>
</div>
<div id="calculatewindow">
   <div ></div>
</div>
</div>
</body>
</html>