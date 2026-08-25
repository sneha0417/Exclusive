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
   	 $("#leastpaydate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#joindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 $("#prevappdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	  
   	/* Searching Window */
   	 $('#empsearchwndow').jqxWindow({ width: '60%', height: '59%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Employee Search' ,position: { x: 300, y: 80 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#empsearchwndow').jqxWindow('close'); 
 
     $('#empid').dblclick(function(){
	  	    $('#empsearchwndow').jqxWindow('open');
	  	    empSearchContent('employeeDetailsSearch.jsp'); 
     }); 
     
     
     $('#leastpaydate').on('change', function (event) {
		   
		 if ($("#mode").val() == "A" || $("#mode").val() == "E") {  
			 
			 if(document.getElementById("cmbyear").value==""|| document.getElementById("cmbmonth").value=="") {
				 return 0;
			  }
			 
		      var payrolldate=new Date($('#leastpaydate').jqxDateTimeInput('getDate'));     
		      payrolldate.setHours(0,0,0,0);
              var year1=payrolldate.getFullYear();  
		      var cmbyear=document.getElementById("cmbyear").value;
		  
			  if(year1>cmbyear) {
			     document.getElementById("errormsg").innerText="Year Cannot be Less than Last Payroll Created On	";
			     return false; 
		      }
 
		      if(year1<cmbyear) {
	    		 var mounth1=payrolldate.getMonth()+1;
			     var cmbmonth=document.getElementById("cmbmonth").value;  
			     if(mounth1>=cmbmonth) {
				   document.getElementById("errormsg").innerText="Month Cannot be Less than Last Payroll Created On	";
			       return false; 
			     } else {   
				   document.getElementById("errormsg").innerText="";  
				 } 
			  } else {
		   		   document.getElementById("errormsg").innerText="";  
			  } 
		 }
   });
		
 });
		
   function empSearchContent(url) {
		 $.get(url).done(function (data) {
		 $('#empsearchwndow').jqxWindow('open');
		 $('#empsearchwndow').jqxWindow('setContent', data);
	}); 
	} 
	   
	function getEmployee(event){
       var x= event.keyCode;
       if(x==114){
    	   empSearchContent('employeeDetailsSearch.jsp');
       }
       else{}
       }
	   
    function funReset(){}
    
	function funReadOnly(){
		  $('#frmappraisal input').prop('readonly', true );
		  $('#change').attr('disabled', true);
		  $('#masterdate').jqxDateTimeInput({ disabled: true});
		  $('#leastpaydate').jqxDateTimeInput({ disabled: true});
		  $('#joindate').jqxDateTimeInput({ disabled: true});
		  $('#prevappdate').jqxDateTimeInput({ disabled: true});
		  $("#compensationGridID").jqxGrid({ disabled: true});
		 
		  $('#cmbdept').attr("disabled", true);
		  $('#cmbdesignation').attr("disabled", true);
		  $('#cmbcategory').attr("disabled", true);
		  $('#cmbdept').attr("disabled", true);
		  $('#cmbyear').attr("disabled", true);
		  $('#cmbmonth').attr("disabled", true);
	}

	function funRemoveReadOnly(){
		  $('#frmappraisal input').prop('readonly', true );
		  $('#masterdate').jqxDateTimeInput({ disabled: false});
		  $('#leastpaydate').jqxDateTimeInput({ disabled: false});
		  $('#joindate').jqxDateTimeInput({ disabled: true});
		  $('#prevappdate').jqxDateTimeInput({ disabled: false});
		  $('#desc').attr("readonly", false);
		  $('#change').attr('disabled', false);
		  $('#cmbdept').attr("disabled", true);
		  $('#cmbdesignation').attr("disabled", true);
		  $('#cmbcategory').attr("disabled", true);
		  $('#cmbyear').attr("disabled", false);
		  $('#cmbmonth').attr("disabled", false);
	   
		 if($("#mode").val() == "A") {
			  $("#compensationGridID").jqxGrid('clear');
		      $("#compensationGridID").jqxGrid('addrow', null, {});
		      $("#compensationGridID").jqxGrid('disabled', false);
		  	  $('#masterdate').val(new Date());
			  $('#leastpaydate').val(new Date());
			  $('#joindate').val(new Date());
			  $('#prevappdate').val(new Date());
		  }
		 
		 if($("#mode").val() == "E") {
			 
		      var docVal1=document.getElementById("docno").value; 
			  $("#comdiv").load("compensationGrid.jsp?docno="+docVal1+"&mode="+$("#mode").val()); 
			 
			  if(document.getElementById("change").checked==true) {
					 $('#cmbdept').attr("disabled", false);
					 $('#cmbdesignation').attr("disabled", false);
					 $('#cmbcategory').attr("disabled", false);
			  }
		 }
	} 
	
	
	function checkchange() {
		if(document.getElementById("change").checked==true) {
			$('#cmbdept').attr("disabled", false);
		 	$('#cmbdesignation').attr("disabled", false);
		 	$('#cmbcategory').attr("disabled", false);
		 	$('#cmbdept').attr("disabled", false);
		} else {
			$('#cmbdept').attr("disabled", true);
			$('#cmbdesignation').attr("disabled", true);
			$('#cmbcategory').attr("disabled", true);
			$('#cmbdept').attr("disabled", true);
		}
	}
	       
	function getDesignation() {
	      var x = new XMLHttpRequest();
	      x.onreadystatechange = function() {
	       if (x.readyState == 4 && x.status == 200) {
	        var items = x.responseText;
	        items = items.split('####');
	        var designationItems = items[0].split(",");
	        var designationIdItems = items[1].split(",");
	        var optionsdesignation = '<option value="">--Select--</option>';
	        for (var i = 0; i < designationItems.length; i++) {
	         optionsdesignation += '<option value="' + designationIdItems[i] + '">'
	           + designationItems[i] + '</option>';
	        }
	        $("select#cmbdesignation").html(optionsdesignation);
	        if ($('#hidcmbdesignation').val() != null) {
	         $('#cmbdesignation').val($('#hidcmbdesignation').val());
	        }
	       } else {
	       }
	      }
	      x.open("GET", "getDesignation.jsp", true);
	      x.send();
	     }
	 
	function getDepartment() {  
	      var x = new XMLHttpRequest();
	      x.onreadystatechange = function() {
	       if (x.readyState == 4 && x.status == 200) {
	        var items = x.responseText;
	        items = items.split('####');
	        var departmentItems = items[0].split(",");
	        var departmentIdItems = items[1].split(",");
	        var optionsdepartment = '<option value="">--Select--</option>';
	        for (var i = 0; i < departmentItems.length; i++) {
	         optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
	           + departmentItems[i] + '</option>';
	        }
	        $("select#cmbdept").html(optionsdepartment);
	        if ($('#hidcmbdept').val() != null) {
	         $('#cmbdept').val($('#hidcmbdept').val());
	        }
	       } else {
	       }
	      }
	      x.open("GET", "getDepartment.jsp", true);
	      x.send();
	     }
	      
	function getPayrollCategory() {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function() {
	     if (x.readyState == 4 && x.status == 200) {
	      var items = x.responseText;
	      items = items.split('####');
	      var payrollcategoryItems = items[0].split(",");
	      var payrollcategoryIdItems = items[1].split(",");
	      var optionspayrollcategory = '<option value="">--Select--</option>';
	      for (var i = 0; i < payrollcategoryItems.length; i++) {
	       optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
	         + payrollcategoryItems[i] + '</option>';
	      }
	      $("select#cmbcategory").html(optionspayrollcategory);
	      if ($('#hidcmbcategory').val() != null) {
	       $('#cmbcategory').val($('#hidcmbcategory').val());
	      }
	     } else {
	     }
	    }
	    x.open("GET", "getPayrollCategory.jsp", true);
	    x.send();
	   }     
		
	function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			
			 var url=document.URL;
		     var reurl=url.split("saveAppraisal");
		     $("#docno").prop("disabled", false);
				   
			 var win= window.open(reurl[0]+"printAppraisal?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		     win.focus();
					
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
	
	function funNotify() { 
		
		  var payrolldate=new Date($('#leastpaydate').jqxDateTimeInput('getDate'));     
		  payrolldate.setHours(0,0,0,0);
          var year1=payrolldate.getFullYear();  
		  var cmbyear=document.getElementById("cmbyear").value;
		  
		   if(year1>cmbyear) {
			    document.getElementById("errormsg").innerText="Year Cannot be Less than Last Payroll Created On Date";
			    return false; 
		   }
		   
		   if(year1<cmbyear) {
		        var mounth1=payrolldate.getMonth()+1;
	    	    var cmbmonth=document.getElementById("cmbmonth").value;  
			   
			    if(mounth1>=cmbmonth) {
				   document.getElementById("errormsg").innerText="Month Cannot be Less than Last Payroll Created On	Date";
			       return false; 
			    } else {   
				   document.getElementById("errormsg").innerText="";  
				} 
			} else {
		   			document.getElementById("errormsg").innerText="";  
			} 
		
		   var rows = $("#compensationGridID").jqxGrid('getrows');
		   $('#compensationGridlength').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "test"+i)
		       .attr("name", "test"+i)
		       .attr("hidden", "true");   
		   
		       newTextBox.val(rows[i].allowanceid+"::"+rows[i].addition+" :: "+rows[i].deduction+" :: "+rows[i].statutorydeduction+" :: "+rows[i].remarks+" :: "+rows[i].refdtype+" :: "+rows[i].revadd+" :: "+rows[i].revded+" :: "+rows[i].revstatded+" :: ");
		       newTextBox.appendTo('form');
		   }   
		   $('#joindate').jqxDateTimeInput({ disabled: false});
		   return 1;
	  } 

	function funChkButton() {}

	function funSearchLoad(){
		 changeContent('masterSearch.jsp'); 
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
		  if(document.getElementById("hidchange").value==1) {
    		  document.getElementById("change").checked = true;
    		  document.getElementById("change").value = 1;
    		  
    		  if($('#hidcmbdept').val()=="1") {
	     		  $('#cmbdept').val($('#hidcmbdept').val());
     		  } else if($('#hidcmbdept').val()=="0") {
    			   $('#hidcmbdept').val('');
    		  }
    		   
    		  if($('#hidcmbdesignation').val()=="1") {
	     		  $('#cmbdesignation').val($('#hidcmbdesignation').val());
     		  } else if($('#hidcmbdesignation').val()=="0") {
    			   $('#hidcmbdesignation').val(''); 
    		  }
    		   
    		  if($('#hidcmbcategory').val()=="1") {
	     		  $('#cmbcategory').val($('#hidcmbcategory').val());
     		  } else if($('#hidcmbcategory').val()=="0") {
    			   $('#hidcmbcategory').val("");
    		  }
    	 } else {
			   $('#hidcmbcategory').val("");
			   $('#hidcmbdesignation').val(''); 
			   $('#hidcmbdept').val('');
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
		
		 var docVal1 = document.getElementById("docno").value;
	        if(docVal1>0) {
	        	 $("#comdiv").load("compensationGrid.jsp?docno="+docVal1);
	        }
		   
 	   if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 	   }
 	   
 	   if($('#hidmasterdate').val()!="") {
		  $('#masterdate').val($('#hidmasterdate').val());
	   }
 	  
 	   if($('#hidleastpaydate').val()!="") {
		  $('#leastpaydate').val($('#hidleastpaydate').val());
	   }
 	  
 	   if($('#hidjoindate').val()!="") {
		  $('#joindate').val($('#hidjoindate').val());
	   }
 	  
 	   if($('#hidprevappdate').val()!="") {
		  $('#prevappdate').val($('#hidprevappdate').val());
	   }
 
 	   document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}

	
	
	function clearmsg() {  
		document.getElementById("errormsg").innerText="";
	}
	
</script>
<style>
.hidden-scrollbar {
  /* // overflow: auto; */
    height: 530px;
    overflow-x: hidden;
} 

</style>  
</head>
<body onload="setValues();getYear();getDepartment();getDesignation();getPayrollCategory();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmappraisal" action="saveAppraisal" autocomplete="OFF" >

<jsp:include page="../../../../header.jsp"></jsp:include><br/> 
<div class='hidden-scrollbar'>       
<fieldset>
<table width="100%">
 <tr>
 <td width="11%" align="right">Date</td> 
 <td width="8%" align="left"><div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
                     <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/></td>
 <td width="5%" align="right">Year</td>
 <td width="8%" align="left"><select id="cmbyear" name="cmbyear" style="width:80%;" value='<s:property value="cmbyear"/>' onchange="clearmsg();"> 
 <option value="">--Select--</option></select>
 <input type="hidden" id="hidcmbyear" name="hidcmbyear"  value='<s:property value="hidcmbyear"/>'/> 
 </td>
 <td width="4%" align="right">Month</td>
 <td width="11%" align="left"><select id="cmbmonth" name="cmbmonth" style="width:98%;"  value='<s:property value="cmbmonth"/>' onchange="clearmsg();">
      <option value="">--Select--</option><option value="1">January</option><option value="2">February</option><option value="3">March</option>
      <option value="4">April</option><option value="5">May</option><option value="6">June</option><option value="7">July</option>
      <option value="8">August</option><option value="9">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth"  value='<s:property value="hidcmbmonth"/>'/>
 </td>                   
 <td width="12%" align="right">Last Payroll Created On</td>
 <td width="17%" align="left"><div id='leastpaydate' name='leastpaydate' value='<s:property value="leastpaydate"/>'></div>
 <input type="hidden" id="hidleastpaydate" name="hidleastpaydate" value='<s:property value="hidleastpaydate"/>'/></td>
 <td width="10%" align="right">Doc No</td>
 <td width="14%" align="left"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>                                          
 </tr>
 </table>
<table width="81%" >
 <tr>
 <td width="59%">
 <fieldset>
 <legend>Employee Details</legend> 
 <table width="100%">
 <tr>
 <td width="21%" align="right">Employee ID</td>
 <td width="30%" align="left"><input type="text" id="empid" name="empid" placeholder="Press F3 to Search" style="width:90%;" onkeydown="getEmployee(event);" value='<s:property value="empid"/>'/>
 <input type="hidden" id="empdocno" name="empdocno" style="width:90%;" value='<s:property value="empdocno"/>'/>
 </td>
 <td width="18%" align="right">&nbsp;</td>
 <td width="31%" align="left">&nbsp;</td>
 </tr>
<tr>
 <td width="21%" align="right">Name</td>
 <td  align="left" colspan="3"><input type="text" id="empname" name="empname" placeholder="Name" style="width:87.5%;"  value='<s:property value="empname"/>'/></td>
</tr>
<tr>
 <td width="21%" align="right">Date Of Join</td>    
 <td width="30%" align="left"><div id='joindate' name='joindate' value='<s:property value="joindate"/>'></div>
 <input type="hidden" id="hidjoindate" name="hidjoindate" value='<s:property value="hidjoindate"/>'/></td>
 <td width="18%" align="right">Prve.Appraisal</td>
 <td width="31%" align="left"><div id='prevappdate' name='prevappdate' value='<s:property value="prevappdate"/>'></div>
 <input type="hidden" id="hidprevappdate" name="hidprevappdate" value='<s:property value="hidprevappdate"/>'/></td>
</tr>
<tr>
 <td width="21%" align="right">Department</td>
 <td width="30%" align="left"><input type="text" id="deprtment" style="width:90%;" name="deprtment" placeholder="Department" value='<s:property value="deprtment"/>'/>
 <input type="hidden" id="hiddeprtment" style="width:90%;" name="hiddeprtment" value='<s:property value="hiddeprtment"/>'/> </td>
 <td width="18%" align="right">Designation</td>
 <td width="31%" align="left"><input type="text" id="designation"   name="designation" placeholder="Designation" value='<s:property value="designation"/>'/>
 <input type="hidden" id="hiddesignation" style="width:90%;" name="hiddesignation" value='<s:property value="hiddesignation"/>'/></td>
</tr>
<tr>
 <td width="21%" align="right">Payroll Category</td>
 <td width="30%" align="left"><input type="text" id="category" style="width:90%;" name="category" placeholder="Payroll Category" value='<s:property value="category"/>'/>
 <input type="hidden" id="hidcategory" style="width:90%;" name="hidcategory" value='<s:property value="hidcategory"/>'/>
 </td>
</tr>
</table>
</fieldset>
</td>
<td width="41%">
 <fieldset> 
<legend><input type="checkbox" name="change" id="change" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="checkchange();">
<input type="hidden" name="hidchange" id="hidchange" value='<s:property value="hidchange"/>'>Changes In Employee Details</legend> 
<table width="100%">
<tr> <td width="27%" align="right">Department</td>
<td width="73%"><select id="cmbdept" name="cmbdept" style="width:60%;" value='<s:property value="cmbdept"/>'>  
 <option value="">--Select--</option></select> 
 <input type="hidden" id="hidcmbdept" name="hidcmbdept" style="width:60%;" value='<s:property value="hidcmbdept"/>'>
</td>
</tr>
<tr>
<td width="27%" align="right">Designation</td>
<td width="73%"><select id="cmbdesignation" name="cmbdesignation" style="width:60%;" value='<s:property value="cmbdesignation"/>'>
 <option value="">--Select--</option></select>
 <input type="hidden" id="hidcmbdesignation" name="hidcmbdesignation" style="width:60%;" value='<s:property value="hidcmbdesignation"/>'></td>
</tr>
<tr>
 <td width="27%" align="right">Payroll Category</td>
 <td><select id="cmbcategory" name="cmbcategory" style="width:60%;" value='<s:property value="cmbcategory"/>'>
 <option value="">--Select--</option></select>
 <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" style="width:60%;" value='<s:property value="hidcmbcategory"/>'>
</tr>
</table>
<br><br><br><br> 
</fieldset>
</td>
</tr>
</table>

<table width="100%">
<tr>
<td width="10.5%" align="right">Description</td>
<td width="89.5%" colspan="4" align="left"><input type="text" id="desc" name="desc" placeholder="Description" style="width:67.2%;" value='<s:property value="desc"/>'/></td>
</tr>
</table><br>

<fieldset>
<legend>Monthly Salary</legend>  
<div id="comdiv"><jsp:include page="compensationGrid.jsp"></jsp:include></div> 
</fieldset>
</fieldset>

<input type="hidden" id="compensationGridlength" name="compensationGridlength" value='<s:property value="compensationGridlength"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>

</div>
</form>

<div id="empsearchwndow">
   <div></div>
</div>
 
</div>
</body>
</html>