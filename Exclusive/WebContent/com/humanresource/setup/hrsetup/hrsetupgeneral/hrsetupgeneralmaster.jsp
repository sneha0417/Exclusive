<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../../includes.jsp"></jsp:include> 

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

/* Specific ID styling from original */
#convformula, #normalrate, #ot, #holidayot {
    text-transform: uppercase;
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

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

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
	 	document.getElementById("formdet").innerText="HR Setup(HRS)";
		document.getElementById("formdetail").value="HR Setup";
		document.getElementById("formdetailcode").value="HRS";
		window.parent.formCode.value="HRS"; 
		window.parent.formName.value="HR Setup";
		
        /* Formatted jqxDateTimeInput heights to match modern UI 24px */
 	 	$("#masterdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});    
 	 	$("#validfromdate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});   
	 	$("#lastreviseddate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});   
 	 	$("#workingtime").jqxDateTimeInput({ width: '80px', height: 24, formatString:'HH:mm', showCalendarButton: false, theme: 'energyblue'}); 
 	 	
        /* force internal alignment AFTER render */
        setTimeout(function () {
            $("#masterdate, #validfromdate, #lastreviseddate, #workingtime").find("input").css({
                "margin-top": "0px",
                "line-height": "24px",
                "font-size": "12px", 
                "font-family": "Arial, sans-serif", 
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#masterdate, #validfromdate, #lastreviseddate, #workingtime").find(".jqx-action-button").css({
                "top": "0px",
                "height": "24px"
            });
        }, 0);
 	
      	$('#formulawindow').jqxWindow({ width: '45%', height: '54%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Salary Calculation Formula' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27,theme: 'energyblue', showCloseButton: true});
	 	$('#formulawindow').jqxWindow('close');
	 	
	 	$('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	$('#accountSearchwindow').jqxWindow('close');
	 	
	 	$('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#costTypeSearchGridWindow').jqxWindow('close');
		
		$('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#costCodeSearchWindow').jqxWindow('close');
	
   		getCategory();getleave();
     
	 	$('#convformula').dblclick(function(){
	  	if($('#mode').val()!= "view") {
		  	    $('#formulawindow').jqxWindow('open');
		  		var id="convformula";
		  	    formulaSearchContent('formula.jsp?id='+id);
	  	} 
	  });   
	  
   	
	 $('#normalrate').dblclick(function(){
		  	if($('#mode').val()!= "view") {
			  	    $('#formulawindow').jqxWindow('open');
		    		var id="normalrate";
			  	    formulaSearchContent('formula.jsp?id='+id);
		      } 
		});   
		  
	 $('#ot').dblclick(function(){
		  	if($('#mode').val()!= "view") {
			  	    $('#formulawindow').jqxWindow('open');
		    	    var id="ot";
			  	    formulaSearchContent('formula.jsp?id='+id);
		    	}  
		});   
		  
	  $('#holidayot').dblclick(function(){
		 	if($('#mode').val()!= "view") {
			  	    $('#formulawindow').jqxWindow('open');
		    		var id="holidayot";
			  	    formulaSearchContent('formula.jsp?id='+id);
		      } 
		 });   
	  
	});
       
	function formulaSearchContent(url) {
    	$.get(url).done(function (data) {
	   		$('#formulawindow').jqxWindow('setContent', data);
	}); 
	}

	function accountSearchContent(url) {
		if($('#mode').val()!="view") {   
			$.get(url).done(function (data) {
	 		$('#accountSearchwindow').jqxWindow('open');
			$('#accountSearchwindow').jqxWindow('setContent', data);
		}); 
  	}
	}
	
	function costTypeSearchContent(url) {
    	$('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}

	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
 
	function getconfor(event){
	 	var x= event.keyCode;
		if($('#mode').val()!="view") {  
	 	if(x==114){
		    $('#formulawindow').jqxWindow('open');
		  	var id="convformula";
		  	formulaSearchContent('formula.jsp?id='+id);
	 } else{}
		 }  
	 }
 
	function getnr(event){
		var x= event.keyCode;
		if($('#mode').val()!="view") {  
	 	if(x==114){
		  $('#formulawindow').jqxWindow('open');
  		  var id="normalrate";
	  	  formulaSearchContent('formula.jsp?id='+id);
	 } else{}
	    }  
	 }
	
	function getot(event){
	 	var x= event.keyCode;
	  	if($('#mode').val()!="view") { 
	 	if(x==114){
		  $('#formulawindow').jqxWindow('open');
  		  var id="ot";
	  	  formulaSearchContent('formula.jsp?id='+id);
	 } else{}
		  }  
	 }
 
	function getholyot(event){
	 	var x= event.keyCode;
   		if($('#mode').val()!="view") {  
		if(x==114){
		  $('#formulawindow').jqxWindow('open');
  		  var id="holidayot";
	  	  formulaSearchContent('formula.jsp?id='+id);
	 } else{}
		  } 
	 }
 
    function funReset(){ }
    
	function funReadOnly(){
		$('#masterdate').jqxDateTimeInput({ disabled: true});
	    $('#validfromdate').jqxDateTimeInput({ disabled: true});
	    $('#lastreviseddate').jqxDateTimeInput({ disabled: true});
	    $('#workingtime').jqxDateTimeInput({ disabled: true});
		$('#frmhrsetups input').attr('readonly', true );
		$('#frmhrsetups select').attr('disabled', true);
	    $('#mon').attr('disabled', true);
	    $('#tue').attr('disabled', true);
	    $('#wed').attr('disabled', true);
	    $('#thu').attr('disabled', true);
	    $('#fri').attr('disabled', true);
	    $('#sat').attr('disabled', true);
	    $('#sun').attr('disabled', true);
	    $('#leaveid').attr('disabled', true);
	    $('#cmbcategory').attr('disabled', true);
	    $('#carryforward').attr('disabled', true);
	}
	
	function funRemoveReadOnly(){
		$('#masterdate').jqxDateTimeInput({ disabled: false});
	    $('#validfromdate').jqxDateTimeInput({ disabled: false});
	    $('#lastreviseddate').jqxDateTimeInput({ disabled: false});
	    $('#workingtime').jqxDateTimeInput({ disabled: false});
		$('#frmhrsetups input').attr('readonly', false );
		$('#frmhrsetups select').attr('disabled', false);
	    $('#mon').attr('disabled', false);
	    $('#tue').attr('disabled', false);
	    $('#wed').attr('disabled', false);
	    $('#thu').attr('disabled', false);
	    $('#fri').attr('disabled', false);
	    $('#sat').attr('disabled', false);
	    $('#sun').attr('disabled', false);
	    $('#leaveid').attr('disabled', false);
	    $('#cmbcategory').attr('disabled', false);
	    $('#carryforward').attr('disabled', false);
	    $('#convformula').attr('readonly', true );
	    $('#normalrate').attr('readonly', true );
	    $('#ot').attr('readonly', true );
	    $('#holidayot').attr('readonly', true );
	    
		 if ($("#mode").val() == "A") {
    		  $("#termibeni").load("terminationbenefitcondtiongrid.jsp");
    		  $("#resiggrid").jqxGrid('clear');
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('clear');
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid({ disabled: false}); 
		      $("#trmigrid").jqxGrid({ disabled: false}); 
    	      $("#accset").load("accountsetupgrid.jsp"); 
		 }
		 
		 if ($("#mode").val() == "E") {
             $("#resiggrid").jqxGrid({ disabled: false}); 
			 $("#trmigrid").jqxGrid({ disabled: false}); 
			 $("#trmigrid").jqxGrid('addrow', null, {});
			 $("#resiggrid").jqxGrid('addrow', null, {});
			  
			 $("#accountsetup").jqxGrid({ disabled: false}); 
			 var docVal1 = document.getElementById("docno").value;
			 $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1+"&modeval="+"E");
		 }
	}
 
	function funNotify(){	
		  var z=0;
		  var rows = $("#benifitsgrid").jqxGrid('getrows');      
		  var selectedrows=$("#benifitsgrid").jqxGrid('selectedrowindexes');
			 
			$('#benigridlength').val(selectedrows.length);
		    for (var i = 0; i < rows.length; i++) {
			      for(var j=0;j<selectedrows.length;j++){
			       if(selectedrows[j]==i){
			    	   newTextBox = $(document.createElement("input"))
			    	   .attr("type", "dil")
				       .attr("id", "trbenitest"+z)
				       .attr("name", "trbenitest"+z)
				       .attr("hidden", "true");  
				    
				   newTextBox.val(rows[i].allowanceid+" :: ");
				   newTextBox.appendTo('form');
				   z++;
			       }
			      }
			   }
	   
		var rows = $("#trmigrid").jqxGrid('getrows');      
	    $('#trmigridlength').val(rows.length);
	    for(var i=0;i<rows.length;i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "termitest"+i)
		       .attr("name", "termitest"+i)
		       .attr("hidden", "true");  
	    
	   		newTextBox.val(rows[i].hidyears+" :: "+rows[i].days+" :: "); 
	   		newTextBox.appendTo('form');
	   }
	   
		var rows = $("#resiggrid").jqxGrid('getrows');
	    $('#resiggridlength').val(rows.length);
	    for(var i=0;i<rows.length;i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "resigtest"+i)
		       .attr("name", "resigtest"+i)
		       .attr("hidden", "true");  
	    
	    	newTextBox.val(rows[i].hidyears+" :: "+rows[i].days+" :: "); 
	    	newTextBox.appendTo('form');
	   }
	    
		var rows = $("#accountsetup").jqxGrid('getrows');
	    $('#accountsetupgridlength').val(rows.length);
	   	for(var i=0;i<rows.length;i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "acnotest"+i)
		       .attr("name", "acnotest"+i)
		       .attr("hidden", "true");  
	    
	   		newTextBox.val(rows[i].allowanceid+":: "+rows[i].acno+":: "+rows[i].costtype+":: "+rows[i].costcode);
	   		newTextBox.appendTo('form');
	   }
		return 1;
	} 

	function funChkButton() { }

	function funSearchLoad(){
		 changeContent('mastersearch.jsp'); 
	}
     
		
	function funFocus(){
		$('#masterdate').jqxDateTimeInput('focus');		 
	}
	 
	function setValues() {
		   
		if($('#hidmasterdate').val()){
			$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
		}
		   
		if($('#hidvalidfromdate').val()){
			$("#validfromdate").jqxDateTimeInput('val', $('#hidvalidfromdate').val());
		}
		   
		if($('#hidlastreviseddate').val()){
			$("#lastreviseddate").jqxDateTimeInput('val', $('#hidlastreviseddate').val());
		}
		   
		if($('#hidworkingtime').val()){
			$("#workingtime").jqxDateTimeInput('val', $('#hidworkingtime').val());
		}
		   
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
      	
    	  var docVal1 = document.getElementById("docno").value;
        	if(docVal1>0) {
        		 $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1);
        	     $("#trimi").load("terminationdetailsgrid.jsp?docno="+docVal1);
        	     $("#resig").load("resignationdetailsgrid.jsp?docno="+docVal1);
        	     $("#accset").load("accountsetupgrid.jsp?docno="+docVal1);
        		}
      	
      	   var weakoff= document.getElementById("hidweakoff").value; 
      	   	if(weakoff!="") {
           		var arr = weakoff.split(",");
           		for(var i=0;i<=arr.length-1;i++) {
	           		if(arr[i]=='1') {
    		       		 document.getElementById("mon").checked = true;
          				 document.getElementById("mon").value=1;
           			}
	           		if(arr[i]=='2') {
		       			document.getElementById("tue").checked = true;
       					document.getElementById("tue").value=1;
       			    }
	           		if(arr[i]=='3') {
       					document.getElementById("wed").checked = true;
       		 			document.getElementById("wed").value=1;
	       			}
    	       		if(arr[i]=='4') {
		       			document.getElementById("thu").checked = true;
       					document.getElementById("thu").value=1;
       			    }
           			if(arr[i]=='5') {
		       			document.getElementById("fri").checked = true;
       			 	    document.getElementById("fri").value=1;
       			    }
           			if(arr[i]=='6') {
		       			document.getElementById("sat").checked = true;
       				    document.getElementById("sat").value=1;
       			    }
           			if(arr[i]=='7') {
		       			document.getElementById("sun").checked = true;
       				    document.getElementById("sun").value=1;
       				}
           		}
      		 }

      	   	var carryforward=document.getElementById("hidcarryforward").value;
         	if(parseInt(carryforward)==1) {
         	 	document.getElementById("carryforward").checked = true;
    		 	document.getElementById("carryforward").value=1;
         	} else {
         	 	document.getElementById("carryforward").checked = false;
    		 	document.getElementById("carryforward").value=0;
         	}
	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				items = items.split('***');
				var branchItems = items[0].split(",");
				var branchIdItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i] + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionsbranch);
				
				  if ($('#hidcatval').val() != null) {
					$('#cmbcategory').val($('#hidcatval').val());
				  }  
			
			} else {}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}
	  
	function getleave() {
	    var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				items = items.split('***');
				var branchItems = items[0].split(",");
				var branchIdItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i] + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#leaveid").html(optionsbranch);
				
				  if ($('#hidleaveid').val() != null) {
					$('#leaveid').val($('#hidleaveid').val());
				   }  
			} else { }
		}
		x.open("GET", "getleaveid.jsp", true);
		x.send();
     }
	
	function isNumber(evt) {
     	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
     	if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
  	   		document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	        return false;
     	}
     	document.getElementById("errormsg").innerText="";  
     	return true;
	}	
	
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmhrsetups" action="saveHrsetup" autocomplete="OFF" >

<jsp:include page="../../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
    
    <!-- General Info -->
    <div class="middle-panel">
        <span class="middle-panel-title">For Days in Year</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
                <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="docno" style="width:120px;" tabindex="-1" value='<s:property value="docno"/>' readonly/>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:80px;">Valid From</label>
            <div style="width: 125px;">
                <div id='validfromdate' name='validfromdate' value='<s:property value="validfromdate"/>'></div>
                <input type="hidden" id="hidvalidfromdate" name="hidvalidfromdate" value='<s:property value="hidvalidfromdate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:110px; margin-left:15px;">Last Revised On</label>
            <div style="width: 125px;">
                <div id='lastreviseddate' name='lastreviseddate' value='<s:property value="lastreviseddate"/>'></div>
                <input type="hidden" id="hidlastreviseddate" name="hidlastreviseddate" value='<s:property value="hidlastreviseddate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:110px; margin-left:15px;">PayRoll Category</label>
            <select name="cmbcategory" id="cmbcategory" style="width:150px;" value='<s:property value="cmbcategory"/>'>
                <option value="">-- select -- </option>
            </select>
            
            <label class="lbl-right" style="width:110px; margin-left:15px;">Working Hours/Day</label>
            <div style="width: 80px;">
                <div id='workingtime' name='workingtime' value='<s:property value="workingtime"/>'></div>
                <input type="hidden" id="hidworkingtime" name="hidworkingtime" value='<s:property value="hidworkingtime"/>'/>
            </div>
        </div>
        
        <div class="field-row">
            <label class="lbl-right" style="width:130px;">Annual Leave: Leave ID</label>
            <select name="leaveid" id="leaveid" style="width:150px;" value='<s:property value="leaveid"/>'>
                <option value="">-- select --</option>
            </select>
            
            <label class="lbl-right" style="width:110px; margin-left:15px;">Weekly Off</label>
            <div style="display:flex; align-items:center; gap:8px;">
                <label style="display:flex; align-items:center; gap:4px; margin:0; cursor:pointer;"><input type="checkbox" id="mon" name="mon" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Mon</label>
                <label style="display:flex; align-items:center; gap:4px; margin:0; cursor:pointer;"><input type="checkbox" id="tue" name="tue" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Tue</label>
                <label style="display:flex; align-items:center; gap:4px; margin:0; cursor:pointer;"><input type="checkbox" id="wed" name="wed" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Wed</label>
                <label style="display:flex; align-items:center; gap:4px; margin:0; cursor:pointer;"><input type="checkbox" id="thu" name="thu" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Thu</label>
                <label style="display:flex; align-items:center; gap:4px; margin:0; cursor:pointer;"><input type="checkbox" id="fri" name="fri" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Fri</label>
                <label style="display:flex; align-items:center; gap:4px; margin:0; cursor:pointer;"><input type="checkbox" id="sat" name="sat" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Sat</label>
                <label style="display:flex; align-items:center; gap:4px; margin:0; cursor:pointer;"><input type="checkbox" id="sun" name="sun" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Sun</label>
            </div>
            
            <label style="display:flex; align-items:center; gap:4px; margin-left:15px; font-weight:bold; cursor:pointer;">
                <input type="checkbox" id="carryforward" name="carryforward" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width:auto; height:auto !important;"> Carry Forward
            </label>
        </div>
        
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:130px;">Eligible Days</label>
            <input type="text" id="eligibledays" name="eligibledays" style="width:150px;" onkeypress="javascript:return isNumber (event)" value='<s:property value="eligibledays"/>' >
            
            <label class="lbl-right" style="width:80px; margin-left:15px;">In a Year</label>
            <input type="text" id="forworkingdays" name="forworkingdays" style="width:100px;" onkeypress="javascript:return isNumber (event)" value='<s:property value="forworkingdays"/>' >
        </div>
    </div>

    <div style="display:flex; gap:15px; margin-bottom: 15px;">
        <!-- Terminal Benefits Area -->
        <div class="middle-panel" style="flex:1.5; margin-bottom:0;">
            <span class="middle-panel-title">Terminal Benefits</span>
            <div id="termibeni" class="grid-container" style="border:none;">
                <jsp:include page="terminationbenefitcondtiongrid.jsp"></jsp:include>
            </div>
        </div>

        <div style="flex:1; display:flex; flex-direction:column; gap:15px;">
            <div class="middle-panel" style="margin-bottom:0; flex:1;">
                <span class="middle-panel-title">Termination Details</span>
                <div id="trimi" class="grid-container" style="border:none;">
                    <jsp:include page="terminationdetailsgrid.jsp"></jsp:include>
                </div>
            </div>
            <div class="middle-panel" style="margin-bottom:0; flex:1;">
                <span class="middle-panel-title">Resignation Details</span>
                <div id="resig" class="grid-container" style="border:none;">
                    <jsp:include page="resignationdetailsgrid.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>
    
    <div style="display:flex; gap:15px;">
        <!-- Salary Calculation Formula (Hrs) -->
        <div class="middle-panel" style="flex:1; margin-bottom:0;">
            <span class="middle-panel-title">Salary Calculation Formula (Hrs)</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:200px;">Conversion Formula Month To Day</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="convformula" name="convformula" readonly="readonly" placeholder="Press F3" value='<s:property value="convformula"/>' onkeydown="getconfor(event);">
                    <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#formulawindow').jqxWindow('open'); formulaSearchContent('formula.jsp?id=convformula'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:200px;">Rate per Hour</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="normalrate" name="normalrate" readonly="readonly" placeholder="Press F3" value='<s:property value="normalrate"/>' onkeydown="getnr(event);" > 
                    <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#formulawindow').jqxWindow('open'); formulaSearchContent('formula.jsp?id=normalrate'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            <div class="field-row">
                <label class="lbl-right" style="width:200px;">OT</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="ot" name="ot" readonly="readonly" placeholder="Press F3" value='<s:property value="ot"/>' onkeydown="getot(event);" > 
                    <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#formulawindow').jqxWindow('open'); formulaSearchContent('formula.jsp?id=ot'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:200px;">Holiday OT</label>
                <div class="input-search-container" style="flex:1;">
                    <input type="text" id="holidayot" name="holidayot" readonly="readonly" placeholder="Press F3" value='<s:property value="holidayot"/>' onkeydown="getholyot(event);"> 
                    <svg class="magnifier-icon" onclick="if($('#mode').val()!='view') { $('#formulawindow').jqxWindow('open'); formulaSearchContent('formula.jsp?id=holidayot'); }" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
            </div>
        </div>
        
        <!-- Account Setup -->
        <div class="middle-panel" style="flex:1.5; margin-bottom:0;">
            <span class="middle-panel-title">Account Setup</span>  
            <div id="accset" class="grid-container" style="border:none;">
                <jsp:include page="accountsetupgrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
 
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="hidcatval" name="hidcatval" value='<s:property value="hidcatval"/>'/>
        <input type="hidden" id="hidleaveid" name="hidleaveid" value='<s:property value="hidleaveid"/>'/>
        <input type="hidden" id="hidweakoff" name="hidweakoff" value='<s:property value="hidweakoff"/>'/>
        <input type="hidden" id="hidcarryforward" name="hidcarryforward" value='<s:property value="hidcarryforward"/>'/>
        <input type="hidden" id="benigridlength" name="benigridlength" value='<s:property value="benigridlength"/>'/>
        <input type="hidden" id="trmigridlength" name="trmigridlength" value='<s:property value="trmigridlength"/>'/>
        <input type="hidden" id="resiggridlength" name="resiggridlength" value='<s:property value="resiggridlength"/>'/>
        <input type="hidden" id="accountsetupgridlength" name="accountsetupgridlength" value='<s:property value="accountsetupgridlength"/>'/>
    </div>
    
</div>
</form>

<div id="formulawindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>  
<div id="costTypeSearchGridWindow"><div></div></div> 
<div id="costCodeSearchWindow"><div></div></div> 

</div>
</body>
</html>