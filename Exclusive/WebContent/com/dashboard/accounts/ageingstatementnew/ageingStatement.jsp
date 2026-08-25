<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

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
#tabledata{
	display:none;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtaccid').dblclick(function(){
		      if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 });
		
	});
	
	function funExportBtn(){
	    //JSONToCSVConvertor(data, 'AgeingStatement', true);
		$("#ageingStatementDiv").excelexportjs({
			containerid: "ageingStatementDiv",
			datatype: 'json', 
			dataset: null, 
			gridId: "ageingStatement", 
			columns: getColumns("ageingStatement") , 
			worksheetName: "Ageing Statement"
		});

	}
	
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getSalesPerson() {
		// alert(document.getElementById("lbldetailname").innerText);
		 if(document.getElementById("lbldetailname").innerText=="Current Ageing"){
			$('#uptodate').jqxDateTimeInput({disabled: true});
		 }
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesagentItems = items[0].split(",");
				var salesagentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesagentItems.length; i++) {
					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
							+ salesagentItems[i] + '</option>';
				}
				$("select#cmbsalesperson").html(optionssalesagent);
				if ($('#hidcmbsalesperson').val() != null) {
					$('#cmbsalesperson').val($('#hidcmbsalesperson').val());
				}
			} else {
			}
		}
		x.open("GET", "getSalesPerson.jsp", true);
		x.send();
	}
  
   function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionscategory);
				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
			} else {
			}
		}
		x.open("GET", "getCategory.jsp?type="+$('#cmbtype').val(), true);
		x.send();
	}
	
	function changelevel1(){ 
	   var level1to=$('#txtlevel1to').val();
	   var level2to=$('#txtlevel2to').val();
	   var level1from=$('#txtlevel1from').val();
	   if(level2to!=""){
	   if(parseInt(level1to)>parseInt(level2to) || parseInt(level1to)<parseInt(level1from)){
			 $.messager.alert('Message','Not a Valid Range.','warning');
			 $('#txtlevel1to').val('');
			 return 0;
		 }
	   }
	   
	   if(level1to!=""){
		   $('#txtlevel2from').val(parseInt(level1to)+1);
		   }
	    else{
		   $('#txtlevel2from').val('');
		   }
	}
	
	function changelevel2(){
		 var level2to=$('#txtlevel2to').val();
		 var level3to=$('#txtlevel3to').val();
		 var level2from=$('#txtlevel2from').val();
		 if(level3to!=""){
		 if(parseInt(level2to)>parseInt(level3to) || parseInt(level2to)<parseInt(level2from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel2to').val('');
				return 0;
			 }
		 }
		 
		if(level2to!=""){
			   $('#txtlevel3from').val(parseInt(level2to)+1);
			   }
		   else{
			   $('#txtlevel3from').val('');
			   } 
		
	}
	
	function changelevel3(){
		var level3to=$('#txtlevel3to').val();
		var level4to=$('#txtlevel4to').val();
		var level3from=$('#txtlevel3from').val();
		if(level4to!=""){
		 if(parseInt(level3to)>parseInt(level4to) || parseInt(level3to)<parseInt(level3from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel3to').val('');
				return 0;
			 }
		}
		 
		if(level3to!=""){
			   $('#txtlevel4from').val(parseInt(level3to)+1);
			   }
		     else{
			   $('#txtlevel4from').val('');
			   } 
	}
	
	function changelevel4(){
		var level4to=$('#txtlevel4to').val();
		var level4from=$('#txtlevel4from').val();
		if(level4to!=""){
		 if(parseInt(level4to)<parseInt(level4from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel4to').val('');
				return 0;
			 }
		}
		
		if(level4to!=""){
			   $('#txtlevel5from').val(parseInt(level4to)+1);
			   }
		    else{
			   $('#txtlevel5from').val('');
			   } 
	}
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
		  if($('#cmbtype').val()==''){
    		  $.messager.alert('Message','Please Choose Account Type.','warning');
    		  return 0;
    	  }
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	
	function funOutStandingStatement(){
		 var accno = $('#txtacountno').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		
  	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");
	        
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAgeingOutstandingsStatement?&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
			funGetOutstandingTable();  
	     }
	    else {
	    	$.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
		}
	   }
	
	function funauditletterprint(){
		 var accno = $('#txtacountno').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		
 	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");
	        
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAuditconfirmationletternew?balance="+document.getElementById("txtbalance").value.replace(',','')+"&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val(),+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
			  
	     }
	    else {
	    	$.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
		}
	   }
	
	
	
	function funSendingEmail() {  
		
	    var email = document.getElementById("txtaccemail").value;
	    var level1from = $('#txtlevel1from').val();
		var level1to = $('#txtlevel1to').val();
		var level2from = $('#txtlevel2from').val();
		var level2to = $('#txtlevel2to').val();
		var level3from = $('#txtlevel3from').val();
		var level3to = $('#txtlevel3to').val();
		var level4from = $('#txtlevel4from').val();
		var level4to = $('#txtlevel4to').val();
		var level5from = $('#txtlevel5from').val();
	    var res;var part1;var part2;var dotsplt;
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	    
	   if ($("#txtacountno").val().trim()=="" || typeof($("#txtacountno").val().trim())=="undefined" || typeof($("#txtacountno").val().trim())=="NaN") {
		    $('#txtacountno').val('');
		    $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
	  } else  if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.indexOf("@")<0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.split('@').length!=2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.length==0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.split(" ").length>2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(part2.split(".").length<2) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[0].length==0 ) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else {
 		
		    $("#overlay, #PleaseWait").show();
		   
	 		$.ajaxFileUpload ({  
	    	    	
	    	    	  url: 'printAgeingOutstandingsStatement.action?acno='+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email='+$('#txtaccemail').val()+'&print=0',  
	    	          secureuri:false,//false  
	    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	    	          dataType: 'string',// json  
	    	          success: function (data, status) {  
	
	    	             if(status=='success'){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','E-Mail Send Successfully');
	    	              }
	    	             if(status=='error'){
	    	            	 $("#overlay, #PleaseWait").hide();
	    	            	 $.messager.alert('Message','E-Mail Sending failed');
	    	             }
	    	             
	    	              $("#testImg").attr("src",data.message);
	    	              if(typeof(data.error) != 'undefined')  
	    	              {  
	    	                  if(data.error != '')  
	    	                  {  
	    	                      alert(data.error);  
	    	                  }else  
	    	                  {  
	    	                      alert(data.message);  
	    	                  }  
	    	              }  
	    	          },  
	    	           error: function (data, status, e)
	    	          {  
	    	              alert(e);  
	    	          }  
	    	      }) 
	    	     return false;
 		
		  } 
      }
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
	} 
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var clientstatus = $('#cmbclientstatus').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 var check=1;
		 
		 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 if(level1from==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level1to==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level2from==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level2to==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level3from==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
		 if(level3to==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
		 if(level4from==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level4to==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level5from==''){$.messager.alert('Message','Level 5 is Mandatory.','warning');return 0;}
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#ageingStatementDiv").load("ageingStatementGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to
				 +'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&clientstatus='+clientstatus+'&check='+check);
		 
		}
	
	
		function funGetOutstandingTable() {
		$("#overlay, #PleaseWait").show();
		var acno=document.getElementById("txtacountno").value;
		var atype=document.getElementById("cmbtype").value;
		var accno = $('#txtacountno').val();
		var level1from = $('#txtlevel1from').val();
		var level1to = $('#txtlevel1to').val();
		var level2from = $('#txtlevel2from').val();
		var level2to = $('#txtlevel2to').val();
		var level3from = $('#txtlevel3from').val();
		var level3to = $('#txtlevel3to').val();
		var level4from = $('#txtlevel4from').val();
		var level4to = $('#txtlevel4to').val();
		var level5from = $('#txtlevel5from').val();
		var branch=document.getElementById("cmbbranch").value;
		var uptoDate=$("#uptodate").jqxDateTimeInput('val');
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				$("#overlay, #PleaseWait").hide();
				$('#ageingStatementDiv').append($.parseHTML(items.split("::")[0]));
				$("#ageingStatementDiv").excelexportjs({
					containerid: "tabledata",
					datatype: 'table', 
					dataset: $.parseHTML(items.split("::")[0]),
					worksheetName: items.split("::")[1]
				});
				
			} else {
			}
		}
		x.open("GET", "getOutstandingTable.jsp?acno="+acno+"&atype="+atype+"&level1from="+level1from+"&level1to="+level1to+"&level2from="+level2from+"&level2to="+level2to+"&level3from="+level3from+"&level3to="+level3to+"&level4from="+level4from+"&level4to="+level4to+"&level5from="+level5from+"&branch="+branch+"&uptoDate="+uptoDate+"&email=Nil&print=1", true);
		x.send();
	}
</script>
</head>
<body onload="getBranch();getSalesPerson();getCategory();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">Up To</label></td>
     <td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"><select id="cmbtype" name="cmbtype" style="width:40%;" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
    <option value="" >--Select--</option><option value="AR" selected>AR</option><option value="AP">AP</option></select></td></tr>
    <tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td></tr> 
	<tr><td align="right"><label class="branch">Sales Person</label></td>
	<td><select id="cmbsalesperson" name="cmbsalesperson" style="width:100%;" value='<s:property value="cmbsalesperson"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Category</label></td>
	<td><select id="cmbcategory" name="cmbcategory" style="width:100%;" value='<s:property value="cmbcategory"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Status</label></td><td align="left"><select id="cmbclientstatus" style="width:70%;" name="cmbclientstatus"  value='<s:property value="cmbclientstatus"/>'>
	 <option value=''>-- Select --</option><option value='0'>Active</option><option value='1'>Litigation</option><option value='2'>Dispute</option><option value='3'>Bad Debts</option></select>
	 <input type="hidden" id="hidcmbclientstatus" name="hidcmbclientstatus" value='<s:property value="hidcmbclientstatus"/>'/></td></tr>
	<tr><td align="right"><label class="branch">Level 1</label></td>
	<td align="left"><input type="text" id="txtlevel1from" name="txtlevel1from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='0'/>&nbsp;-&nbsp;
	<input type="text" id="txtlevel1to" name="txtlevel1to" style="width:20%;height:20px;text-align: center;" onblur="changelevel1();" value='30'/></td></tr>
	<tr><td align="right"><label class="branch">Level 2</label></td>
	<td align="left"><input type="text" id="txtlevel2from" name="txtlevel2from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='31'/>&nbsp;-&nbsp;
	<input type="text" id="txtlevel2to" name="txtlevel2to" style="width:20%;height:20px;text-align: center;" onblur="changelevel2();" value='60'/></td></tr>
	<tr><td align="right"><label class="branch">Level 3</label></td>
	<td align="left"><input type="text" id="txtlevel3from" name="txtlevel3from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='61'/>&nbsp;-&nbsp;
	<input type="text" id="txtlevel3to" name="txtlevel3to" style="width:20%;height:20px;text-align: center;" onblur="changelevel3();" value='90'/></td></tr>
	<tr><td align="right"><label class="branch">Level 4</label></td>
	<td align="left"><input type="text" id="txtlevel4from" name="txtlevel4from" style="width:20%;height:20px;text-align: center;" readonly="readonly" value='91'/>&nbsp;-&nbsp;
	<input type="text" id="txtlevel4to" name="txtlevel4to" style="width:20%;height:20px;text-align: center;" onblur="changelevel4();" value='120'/></td></tr>
	<tr><td align="right"><label class="branch">Level 5</label></td>
	<td align="left"><input type="text" id="txtlevel5from" name="txtlevel5from" style="width:20%;height:20px;text-align: center;" value='121'/>&nbsp;>=</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><center><button class="myButton" type="button" id="btnIndividual" name="btnIndividual" onclick="funOutStandingStatement();">Outstanding Statement</button></center></td></tr>
	<tr><td colspan="2"><center><button class="myButton" type="button" id="btnIndividual" name="btnIndividual" onclick="funauditletterprint();">Audit Balance Confirmation Letter</button></center></td></tr>
	<tr><td colspan="2"><input type="hidden" id="txtacountno" name="txtacountno" style="width:100%;height:20px;" value='<s:property value="txtacountno"/>'/>
	<input type="hidden" id="txtaccemail" name="txtaccemail" value='<s:property value="txtaccemail"/>'/>
	<input type="hidden" id="txtbalance" name="txtbalance" value='<s:property value="txtbalance"/>'/>
	<input type="hidden" id="txtbranch" name="txtbranch" style="width:100%;height:20px;" value='<s:property value="txtbranch"/>'/></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="ageingStatementDiv"><jsp:include page="ageingStatementGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

<table width="100%">
<tr>
		<td width="50%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Net Total :&nbsp;</td>
        <td width="50%" align="left"><input type="text" class="textbox" id="txtnetbalance" name="txtnetbalance" style="width:15%;text-align: right;" value='<s:property value="txtnetbalance"/>'/></td>
</tr>
</table>
</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>