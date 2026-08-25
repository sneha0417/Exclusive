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

<style type="text/css">
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
	$(document).ready(function() {
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#projectinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' project Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#projectinfowindow').jqxWindow('close');
			$('#sectioninfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'section Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#sectioninfowindow').jqxWindow('close');
			$('#lchargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Labour Charge Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#lchargeinfowindow').jqxWindow('close');
			$('#echargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Equipment Charge Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
			$('#echargeinfowindow').jqxWindow('close');
			$('#sidesearchwndow').jqxWindow({ width: '30%', height: '90%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 943, y: 0 }, keyboardCloseKey: 27});
			$('#sidesearchwndow').jqxWindow('close'); 
			
			
			 $('#txtprojectname').dblclick(function(){
				   
				   	if($('#mode').val()!= "view")
				   		{
				   		$('#projectinfowindow').jqxWindow('open');
				   	    projectSearchContent('projectSearch.jsp');
				   		}
				 });
			 
			 $('#txtsectionname').dblclick(function(){
				   
				   	if($('#mode').val()!= "view")
				   		{
				   	 $('#sectioninfowindow').jqxWindow('open');
				 	  sectionSearchContent('sectionSearch.jsp');
				   		}
				 });
			 
			 
		
	});
	
	 function funReadOnly(){
			$('#btnDelete').attr('disabled', true );
			$('#frmTemplates input').attr('readonly', true );
			$('#frmTemplates select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$("#jqxInvoiceGrid").jqxGrid({ disabled: true});
			$("#equipmentDetailsGridID").jqxGrid({ disabled: true});
			$("#labourDetailsGridID").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#btnDelete').attr('disabled', true );
			$('#frmTemplates input').attr('readonly', false );
			$('#frmTemplates select').attr('disabled', false);
			$('#date').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#txtprojectname').attr('readonly', true );
			$('#txtsectionname').attr('readonly', true );
			$("#jqxInvoiceGrid").jqxGrid({ disabled: false});
			$("#equipmentDetailsGridID").jqxGrid({ disabled: false});
			$("#labourDetailsGridID").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "E") {
				$('#frmTemplates input').attr('readonly', true );
   			    $('#frmTemplates select').attr('disabled', true);
   			    $('#txtactivity').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $('#gridtext').attr('readonly', false );
   			    $('#gridtext1').attr('readonly', false );
   			    $('#gridtext').attr('disabled', false );
			    $('#gridtext1').attr('disabled', false );
   			    $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
   			    $("#equipmentDetailsGridID").jqxGrid('addrow', null, {});
   			    $("#labourDetailsGridID").jqxGrid('addrow', null, {});
   			    
   			 var summaryData1= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
     		document.getElementById("txtmatotal").value=summaryData1.sum.replace(/,/g,''); 
     		
     		var summaryData2= $("#labourDetailsGridID").jqxGrid('getcolumnaggregateddata', 'netotal1', ['sum'],true);
    		document.getElementById("txtlabtotal").value=summaryData2.sum.replace(/,/g,''); 
     		
    		var summaryData3= $("#equipmentDetailsGridID").jqxGrid('getcolumnaggregateddata', 'netotal2', ['sum'],true);
     		document.getElementById("txteqptotal").value=summaryData3.sum.replace(/,/g,'');  
   			    
   			    
			  }
			
			if ($("#mode").val() == "A") {
				$("#txtmatotal").val("0.0");
				$("#txtlabtotal").val("0.0");
				$("#txteqptotal").val("0.0");
				$('#date').val(new Date());
				$("#jqxInvoiceGrid").jqxGrid('clear');
				$("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
				$("#equipmentDetailsGridID").jqxGrid('clear');
				$("#equipmentDetailsGridID").jqxGrid('addrow', null, {});
				$("#labourDetailsGridID").jqxGrid('clear');
				$("#labourDetailsGridID").jqxGrid('addrow', null, {}); 
			}
			
	 }
	 
	 function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#sidesearchwndow').jqxWindow('open');
      		$('#sidesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      	} 
	 
	 function getProjects(event){
		 
		 var x= event.keyCode;
  		 if(x==114){
		 
		  $('#projectinfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        projectSearchContent('projectSearch.jsp');
	     	 }
  		 else{
  			 
  		 }
	 }
	     	 
	function projectSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#projectinfowindow').jqxWindow('setContent', data);

	            }); 
	  	}
	
	function getlcharge(rowBoundIndex){
		 
		  $('#lchargeinfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        lchargeSearchContent('chargeSearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	
	function lchargeSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#lchargeinfowindow').jqxWindow('setContent', data);

		            }); 
		  	}
	  	
	
	function getecharge(rowBoundIndex){
		 
		  $('#echargeinfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        echargeSearchContent('equipchargeSearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	
	function echargeSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#echargeinfowindow').jqxWindow('setContent', data);

		            }); 
		  	}
	  	
	  	
	function getSection(event){
		
		var x= event.keyCode;
 		 if(x==114){
		  $('#sectioninfowindow').jqxWindow('open');

	// $('#accountWindow').jqxWindow('focus');
	      sectionSearchContent('sectionSearch.jsp');
	   	 }
 		 else{
 			 
 		 }
	}
	   	 
	function sectionSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#sectioninfowindow').jqxWindow('setContent', data);

	          	}); 
		}
	 
	function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	} 
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   /* $(function(){
	        $('#frmCashPayment').validate({
	                rules: {
	                txtfromaccid:"required",
	                txtfromamount:{"required":true,number:true},
	                txttoamount:{number:true},
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtfromaccid:" *",
	                 txtfromamount:{required:" *",number:"Invalid"},
	                 txttoamount:{number:"Invalid"},
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); */
	   
	        function funNotify(){
	        	
	        	
	        	if($('#txtprojectname').val()=="")
	        	{
	        	document.getElementById("errormsg").innerText="select Project";
	        	return 0;
	        	}
	        	
	        	if($('#txtsectionname').val()=="")
	        	{
	        	document.getElementById("errormsg").innerText="select Section";
	        	return 0;
	        	}
	        	
	        	if($('#txtactivity').val()=="")
	        	{
	        	document.getElementById("errormsg").innerText="Enter activity";
	        	return 0;
	        	}
	        	document.getElementById("errormsg").innerText="";
	        	
	        	 var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');
	             var rows2 = $("#labourDetailsGridID").jqxGrid('getrows');
	        	 var rows3 = $("#equipmentDetailsGridID").jqxGrid('getrows');
	        	

	        	 $('#matgridlen').val(rows1.length);
	        	 $('#labgridlen').val(rows2.length);
	        	 $('#eqgridlen').val(rows3.length);
	        	    
	        	 for(var i=0 ; i < rows1.length ; i++){
	        		 
	        			
	        		    newTextBox = $(document.createElement("input"))
	        		       .attr("type", "dil")
	        		       .attr("id", "mate"+i)
	        		       .attr("name", "mate"+i)
	        		       .attr("hidden", "true"); 
	        		    
	        		   newTextBox.val(rows1[i].desc1+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].margin+" :: "+rows1[i].netotal+" :: ");
	        		   newTextBox.appendTo('form');
	        		  
	        				}	 
	        	 
	        	 
	        	  for(var i=0 ; i < rows2.length ; i++){
	        			
	        		  
	        		    newTextBox = $(document.createElement("input"))
	        		       .attr("type", "dil")
	        		       .attr("id", "lab"+i)
	        		       .attr("name", "lab"+i)
	        		       .attr("hidden", "true"); 
	       
	        		   newTextBox.val(rows2[i].docno+" :: "+rows2[i].desc2+" :: "+rows2[i].hrs+" :: "+rows2[i].min+" :: "+rows2[i].rate+" :: "+rows2[i].total1+" :: "+rows2[i].margin1+" :: "+rows2[i].netotal1+" :: ");
	        		
	        		   newTextBox.appendTo('form');
	        		  
	        				}
	        	  
	        		
	        	   for(var i=0 ; i < rows3.length ; i++){
	        			
	        		    newTextBox = $(document.createElement("input"))
	        		       .attr("type", "dil")
	        		       .attr("id", "equip"+i)
	        		       .attr("name", "equip"+i)
	        		       .attr("hidden", "true"); 
	        		    
	        		   newTextBox.val(rows3[i].docno+" :: "+rows3[i].desc1+" :: "+rows3[i].hrs2+" :: "+rows3[i].min2+" :: "+rows3[i].rate2+" :: "+rows3[i].total2+" :: "+rows3[i].margin2+" :: "+rows3[i].netotal2+" :: ");
	        		
	        		   newTextBox.appendTo('form');
	        		  
	        				}
	        			
	        	
	        		return 1;
	        } 

	  
	  
	  function setValues(){
		  
		  var docno=$("#masterdoc_no").val();
		  
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  } 
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  if(docno>0){
				 $("#materialDiv").load("materialDetailsGrid.jsp?docno="+docno);
				 $("#labourDiv").load("labourDetailsGrid.jsp?docno="+docno);
				 $("#equipmentsDiv").load("equipmentDetailsGrid.jsp?docno="+docno);
				 
			}
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		}
	  
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveServiceReport");
			     $("#docno").prop("disabled", false);
					  
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
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
<form id="frmTemplates" action="saveTemplates" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'>
<input type="text" name="gridtext" id="gridtext"  style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
 <input type="text" name="gridtext1" id="gridtext1"  style="width:0%;height:0%;"  class="textbox" value='<s:property value="gridtext1"/>' />
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno" style="width:50%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="4%" align="right">Project</td>
    <td width="33%"><input type="text" id="txtprojectname" name="txtprojectname" onKeyDown="getProjects(event);" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtprojectname"/>'  onkeydown="getProject(event);"/>
    <input type="hidden" id="txtprojectid" name="txtprojectid" value='<s:property value="txtprojectid"/>'/></td>
    <td width="7%" align="right">Section</td>
    <td width="22%"><input type="text" id="txtsectionname" name="txtsectionname" onKeyDown="getSection(event);" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txtsectionname"/>'  onkeydown="getSection(event);"/>
    <input type="hidden" id="txtsectionid" name="txtsectionid" value='<s:property value="txtsectionid"/>'/></td>
    <td width="8%" align="right">Activity</td>
    <td width="26%"><input type="text" id="txtactivity" name="txtactivity" style="width:70%;" value='<s:property value="txtactivity"/>'/></td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:99%;" value='<s:property value="txtdescription"/>'/></td>
    <td align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Net Total :</td>
    <td align="left"><input type="text" class="textbox" id="txtnettotal" name="txtnettotal" style="width:40%;text-align: right;" value='<s:property value="txtnettotal"/>' tabindex="-1"/></td>
  </tr>
</table>
</fieldset>

<fieldset><legend>Material Details</legend>
<div id="materialDiv"><jsp:include page="materialDetailsGrid.jsp"></jsp:include></div>
</fieldset>

<fieldset><legend>Labour Details</legend>
<div id="labourDiv"><jsp:include page="labourDetailsGrid.jsp"></jsp:include></div>
</fieldset>

<fieldset><legend>Equipments Details</legend>
<div id="equipmentsDiv"><jsp:include page="equipmentDetailsGrid.jsp"></jsp:include></div>
</fieldset>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>

<input type="hidden" id="txtmatotal" name="txtmatotal"  value='<s:property value="txtmatotal"/>'/>
<input type="hidden" id="txtlabtotal" name="txtlabtotal"  value='<s:property value="txtlabtotal"/>'/>
<input type="hidden" id="txteqptotal" name="txteqptotal"  value='<s:property value="txteqptotal"/>'/>


<input type="hidden" id="eqgridlen" name="eqgridlen"  value='<s:property value="eqgridlen"/>'/>
<input type="hidden" id="labgridlen" name="labgridlen"  value='<s:property value="labgridlen"/>'/>
<input type="hidden" id="matgridlen" name="matgridlen"  value='<s:property value="matgridlen"/>'/>
</div>
<div id="projectinfowindow">
   <div ></div>
</div>
<div id="sectioninfowindow">
   <div ></div>
</div>
<div id="sidesearchwndow">
   <div ></div> 
</div>
<div id="lchargeinfowindow">
   <div ></div>
</div>
<div id="echargeinfowindow">
   <div ></div>
</div>
</form>
	
</div>
</body>
</html>
