<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include> 
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">

 $(document).ready(function () {
	 
   	  $("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	  
   	  /* Searching Window */
   	  $('#empsearchwndow').jqxWindow({width: '60%', height: '59%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Employee Search',position: { x: 300, y: 80 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
      $('#empsearchwndow').jqxWindow('close'); 
      
      $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#accountDetailsWindow').jqxWindow('close');
	  
	  $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#costTypeSearchGridWindow').jqxWindow('close');
	 
	  $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	  $('#costCodeSearchWindow').jqxWindow('close');
	  
  }); 
    
    function empSearchContent(url) {
		 $.get(url).done(function (data) {
		 $('#empsearchwndow').jqxWindow('open');
		 $('#empsearchwndow').jqxWindow('setContent', data);
		}); 
	} 

    function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
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
    
    function funReset(){}
    
	function funReadOnly(){
		 $('#frmalw input').prop('readonly', true );
		 $('#frmalw select').prop('disabled', true );
		 $('#masterdate').jqxDateTimeInput({ disabled: true});
		 $("#descdetailsGrid").jqxGrid({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		 $('#frmalw input').prop('readonly', false );
		 $('#frmalw select').prop('disabled', false );
		 $('#masterdate').jqxDateTimeInput({ disabled: false});
		 $('#docno').attr("readonly", true);
		 $("#descdetailsGrid").jqxGrid({ disabled: false});
		   
		 if ($("#mode").val() == "A") {
			   $('#masterdate').val(new Date());
			   $("#descdetailsGrid").jqxGrid('clear');
			   $("#descdetailsGrid").jqxGrid('addrow', null, {}); 
		 }
		   
		 if ($("#mode").val() == "E") {
			   $("#descdetailsGrid").jqxGrid('addrow', null, {});
		 }
	}
	       
	function funNotify(){
	 
		   if(document.getElementById("cmbyear").value=="") {
			   document.getElementById("errormsg").innerText="Select Year";
			   document.getElementById("cmbyear").focus();
			   return 0;
		   }
		   
		   if(document.getElementById("cmbmonth").value=="") {
			   document.getElementById("errormsg").innerText="Select Month";
			   document.getElementById("cmbmonth").focus();
			   return 0;
		   }
		   
		   /* Addition and Deduction Grid  Saving*/
	  		  var rows = $("#descdetailsGrid").jqxGrid('getrows');
	  		  var length=0;
			  for(var i=0 ; i < rows.length ; i++){
				    var chk=rows[i].empdoc;
				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				    	var chks=rows[i].acno;
				    	if(typeof(chks) == "undefined" || typeof(chks) == "NaN" || chks == "") {
				    		document.getElementById("errormsg").innerText="Invalid Account for "+rows[i].empname;
				    		return 0;
				    	}
	  					newTextBox = $(document.createElement("input"))
	  				    .attr("type", "dil")
	  				    .attr("id", "test"+length)
	  				    .attr("name", "test"+length)
	  				    .attr("hidden", "true");
	  					length=length+1;
	  					
	  				newTextBox.val(rows[i].empdoc+":: "+rows[i].addition+":: "+rows[i].deduction+":: "+rows[i].remarks+":: "+rows[i].atype+":: "+rows[i].acno+":: "+rows[i].costtype+":: "+rows[i].costcode);
	  				newTextBox.appendTo('form');
	  			  }
			   }
			   $('#descdetailsGridlenght').val(length);
	  	   /* Addition and Deduction Grid  Saving Ends*/
	  	 	
	  	   document.getElementById("errormsg").innerText="";
	  	   
		return 1;
	} 

	function funChkButton() {}

	function funSearchLoad(){
		 changeContent('alwMainSearch.jsp'); 
	}
		
	function funFocus(){
		$('#masterdate').jqxDateTimeInput('focus'); 
	}
	 
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if ($('#hidcmbyear').val() != null) {
						$('#cmbyear').val($('#hidcmbyear').val());
					}
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
 
	function setValues() {
		   
	  	    if($('#hidmasterdate').val()!="") {
	 		  $('#masterdate').val($('#hidmasterdate').val());
	 		}
		  
		    if($('#hidcmbyear').val()!="") {
 		  		$('#cmbyear').val($('#hidcmbyear').val());
 		    } else {
			    $('#cmbyear').val('');
			}
		   
		    if($('#hidcmbmonth').val()!="") {
 		  		$('#cmbmonth').val($('#hidcmbmonth').val());
 		    } else {
			   $('#cmbmonth').val('');
			}
		    
		    if($('#msg').val()!=""){
		 		$.messager.alert('Message',$('#msg').val());
		 	}

		 	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 	funSetlabel();
		 	
		 	 var docVal1 = document.getElementById("docno").value;
	      	 if(docVal1>0) {
	      		  $("#desdet").load("empdetails.jsp?docno="+docVal1);
	      	 }
	}
	
	function clearmsg() {   
		document.getElementById("errormsg").innerText="";
	}
	
function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {

			 $("#docno").prop("disabled", false);
			 $("#formdetailcode").prop("disabled", false);
			 
			var docno=$('#docno').val();
	  		var dtype=$('#formdetailcode').val();
	     	var brhid=<%= session.getAttribute("BRANCHID").toString()%>
	  		var url=document.URL;
	  		var reurl=url.split("com/"); 
	     
	  		
	  		 var win= window.open(reurl[0]+"printAddDeduct?docno="+docno+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				  win.focus(); 
	  			 
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		} 
}

	
</script>
</head>
<body onload="setValues();getYear();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmalw" action="saveAddDeduct" autocomplete="OFF" >
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<table width="100%">
<tr>
 <td width="10%" align="right">Date</td>
 <td width="20%" align="left"><div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
                     <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/></td>
 <td width="10%" align="right">Ref No</td>
 <td width="10%" align="left"> <input type="text" id="refno" name="refno" placeholder="Ref No" value='<s:property value="refno"/>'/></td>
 <td width="20%">&nbsp;</td>          
 <td width="10%" align="right">Doc No</td>
 <td width="20%" align="left"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>                                          
</tr>
</table>

  <div class="panel panel-default">
    <div class="panel-heading">Effect In</div>
    <div class="panel-body">
<table width="100%">
<tr>
 <td width="9%" align="right">Year</td>
 <td width="21%" align="left"><select id="cmbyear" name="cmbyear" style="width:50%;" value='<s:property value="cmbyear"/>' onchange="clearmsg();">
 <option value="">--Select--</option></select>
 <input type="hidden"  id="hidcmbyear" name="hidcmbyear"  value='<s:property value="hidcmbyear"/>'></td>
 <td width="10%" align="right">Month</td>
 <td width="10%" align="left"><select id="cmbmonth" name="cmbmonth" style="width:98%;"  value='<s:property value="cmbmonth"/>' onchange="clearmsg();">
      <option value="">--Select--</option><option value="1">January</option><option value="2">February</option><option value="3">March</option>
      <option value="4">April</option><option value="5">May</option><option value="6">June</option><option value="7">July</option>
      <option value="8">August</option><option value="9">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth"  value='<s:property value="hidcmbmonth"/>'/></td>
 <td width="20%">&nbsp;</td>          
 <td width="10%" align="right">&nbsp;</td>
 <td width="20%" align="left">&nbsp;</td>                     
</tr>
<tr>
 <td width="9%" align="right">Description</td>
 <td align="left" colspan="4">
      <input type="text" id="desc" name="desc" placeholder="Description" style="width:90%;" value='<s:property value="desc"/>'/>
 </td>
 <td width="10%" align="right">&nbsp;</td>
 <td width="20%" align="left">&nbsp;</td> 
</tr>
</table>
 </div></div>

<div id="desdet" ><jsp:include page="empdetails.jsp"></jsp:include></div>

 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="descdetailsGridlenght" name="descdetailsGridlenght"  value='<s:property value="descdetailsGridlenght"/>'/>
</form>

<div id="empsearchwndow">
   <div></div>
</div>
<div id="accountDetailsWindow">
   <div></div>
</div>
<div id="costTypeSearchGridWindow">
	<div></div>
</div> 
<div id="costCodeSearchWindow">
	<div></div>
</div> 

</div>
</body>
</html>