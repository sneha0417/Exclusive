<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function() {
	//document.getElementById("btnEdit").disabled=true;  
	//document.getElementById("btnDelete").disabled=true;
	 $('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#assetwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Asset Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#assetwindow').jqxWindow('close');
	   
	   
$("#date").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#fromdate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#todate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$('#client').dblclick(function(){
    $('#clientwindow').jqxWindow('open');
$('#clientwindow').jqxWindow('focus');
clientSearchContent('masterClientSearch.jsp');
});
});





/* function getClient(event){
	 var x= event.keyCode;
     if(x==114){
    	 $('#clientwindow').jqxWindow('open');
    	 $('#clientwindow').jqxWindow('focus');
    	 clientSearchContent('masterClientSearch.jsp');
     }
     else{
      }
} */





function funSearchLoad(){
	 changeContent('mainSearch.jsp', $('#window')); 
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function assetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#assetwindow').jqxWindow('setContent', data);

}); 
}

function detailSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#detailwindow').jqxWindow('setContent', data);

}); 
}
function funChkButton(){
	
}
function funReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: true}); 
	 $('#assetInvoiceGrid').jqxGrid({ disabled: true}); 
		$('#frmAssetInvoice input').attr('readonly', true );
		 $('#frmAssetInvoice select').attr('disabled', true );
		 $('#frmAssetInvoice textarea').attr('readonly', true );
		 $('#btncalculate').prop('disabled',true);

}
function funRemoveReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $('#assetInvoiceGrid').jqxGrid({ disabled: false}); 
		$('#frmAssetInvoice input').attr('readonly', false );
		 $('#frmAssetInvoice select').attr('disabled', false );
		 $('#frmAssetInvoice textarea').attr('readonly', false );
		 $('#btncalculate').prop('disabled',false);
		 $('#client').prop('readonly',true);
		 $('#clientname').prop('readonly',true);
		 $('#docno').prop('readonly',true);
		 $('#vocno').prop('readonly',true);
		 if(document.getElementById("mode").value=='A'){
			 $("#assetInvoiceGrid").jqxGrid('clear');
			 $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
		 }
}
function funFocus(){
	//document.getElementById("client").focus();
}
function setValues(){
funSetlabel();
	
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 if ($('#hidcmbtype').val() != null) {
			$('#cmbtype').val($('#hidcmbtype').val());
		}
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	if(document.getElementById("docno").value!=""){
		document.getElementById("brchName").disabled=false;
		$('#assetInvoicediv').load('assetInvoiceGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("hidbranch").value+'&id=1');
		
	}
}
function funNotify(){
	if(document.getElementById("cmbtype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Type is Mandatory";
		document.getElementById("cmbtype").focus();
		return 0;
	}
	var rows = $("#assetInvoiceGrid").jqxGrid('getrows');
	if(!((rows[0].assetno=="undefined") || (rows[0].assetno==null) || (rows[0].assetno==""))){
	
		var rowlength=0;
		for(var i=0 ; i < rows.length ; i++){
		
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "test"+i)
		    .attr("name", "test"+i)
		    .attr("hidden", "true");
			if(rows[i].assetno!="" && rows[i].assetno!="undefined" && rows[i].assetno!=null){
				
		newTextBox.val(rows[i].assetno+"::"+rows[i].assetname+"::"+rows[i].salesprice+"::"+rows[i].dep_posted+"::"+rows[i].pur_value+"::"+rows[i].acc_dep+"::"+rows[i].cur_dep+"::"+rows[i].net_pl+"::"+rows[i].netbook);
		
		newTextBox.appendTo('form');
		rowlength++;
			}
			
			//alert("ddddd"+$("#test"+i).val());
		}
		
		$('#gridlength').val(rowlength);
		
	}
 return 1;	
}


function funCalculate(){

	var date=$('#date').jqxDateTimeInput('val');
	
	var rows=$('#assetInvoiceGrid').jqxGrid('getrows');
	var temp=0;
	for(var i=0;i<rows.length;i++){
		var asset=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetid');
		var assetno=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetno');
		temp=1;
		document.getElementById("errormsg").innerText="";
		if(asset=="" || asset=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Asset is Mandatory";
			$('#assetInvoiceGrid').jqxGrid('selectcell', i, 'assetid');
			return false;
		}
		 /* var salesprice=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'salesprice');
		if(salesprice=="" || salesprice=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Sales Price is Mandatory";
			$('#assetInvoiceGrid').jqxGrid('selectcell', i, 'salesprice');
			return false; 
		}
		 */
		if(document.getElementById("errormsg").innerText=="" && asset!="" && asset!="undefined" && asset!=null){
			getCalData(assetno,0,i,date);
		}
			
	}
	if(temp==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Asset";
		return false;
	}
	
}


function getCalData(asset,salesprice,row,date){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items=items.split("::");
			
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'dep_posted',items[0]); 
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'pur_value',items[1]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'acc_dep',items[2]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'cur_dep',items[3]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'net_pl',items[4]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'netbook',items[5]);
			document.getElementById("days").value=items[3];
		} else {
		}
	}
	x.open("GET", "getCalData.jsp?asset="+asset+"&salesprice="+salesprice+"&date="+date, true);
	x.send();
}

function funPrintBtn() {
	   if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
		 $.messager.alert('Warning','Select a Document');
		 return false;
	}
	 var url=document.URL;

		 var reurl=url.split("com/");	 
	 	 var win= window.open(reurl[0]+"com/fixedassets/assets/assetdisposal/printAssetDisposal.action?docno="+document.getElementById("docno").value+"&trno="+document.getElementById("trno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		 win.focus();      
	 
	 }


</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAssetDisposal" action="saveAssetDisposal" autocomplete="off" >

	<jsp:include page="../../../../header.jsp" />
	<br/> 

<fieldset>
<table width="100%" >
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="8%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
    <td width="30%">&nbsp;</td>
    <td width="5%">&nbsp;</td>
    <td width="6%">&nbsp;</td>
    <td width="10%" align="right">Doc No</td>
    <td width="8%" align="left"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1"  readonly></td>
    <td width="27%" align="left">&nbsp;</td>
  </tr>
  
  
  
  
  <%-- <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="client" id="client" value='<s:property value="client"/>' readonly placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
    <td colspan="3" align="left"><input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' style="width:99%;" readonly></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
   --%>
  
  
  
  
  <tr>
    <td al align="right">Description</td>
    <td colspan="2" align="left"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:97.5%;"></td>
    <td align="left">Type</td>
    <td align="left"><select name="cmbtype" id="cmbtype" >
      <option value="">--Select--</option>
      <!-- <option value="S">Sale</option> -->
      <option value="L">Total Loss</option>
    </select></td>
    <td align="center"><input type="button" name="btncalculate" id="btncalculate" class="myButton" onclick="funCalculate();" value="Calculate"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td  align="right">&nbsp;</td>
    <td colspan="6" align="left"><div id="assetInvoicediv"><jsp:include page="assetInvoiceGrid.jsp"></jsp:include></div></td>

    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' hidden=true></div>
    <div id="todate" name="todate" value='<s:property value="todate"/>' hidden=true></div>
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
    <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'> 
    <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
     <input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
     <input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
     <input type="hidden" name="days" id="days" value='<s:property value="days"/>'>
     <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1"  readonly>
  </tr>
</table>
</fieldset>
</form>
<div id=clientwindow>
   <div ></div>
</div>
<div id="assetwindow">
   <div ></div>
</div>
</div>
</body>
</html>
