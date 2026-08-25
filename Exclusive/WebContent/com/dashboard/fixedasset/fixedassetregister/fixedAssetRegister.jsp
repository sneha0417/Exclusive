<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#assetDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Asset Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#assetDetailsWindow').jqxWindow('close');
	     
		 $('#groupDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#groupDetailsWindow').jqxWindow('close');
	     
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		  $('#txtasset').dblclick(function(){
			  assetSearchContent('assetSearchGrid.jsp?check=1');
		  });
		  
		  $('#txtgroup').dblclick(function(){
			  groupSearchContent('groupSearchGrid.jsp?check=1');
		  });
			
	     document.getElementById("rdall").checked=true;
	     
	});
	
	function funExportBtn(){
	    JSONToCSVConvertor(dataExcelExport, 'FixedAssetRegister', true);
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

	
	function assetSearchContent(url) {
	    $('#assetDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#assetDetailsWindow').jqxWindow('setContent', data);
		$('#assetDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function groupSearchContent(url) {
	    $('#groupDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#groupDetailsWindow').jqxWindow('setContent', data);
		$('#groupDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAsset(event){
        var x= event.keyCode;
        if(x==114){
        	assetSearchContent('assetSearchGrid.jsp?check=1');
        }
        else{}
        }
	
	function getGroup(event){
        var x= event.keyCode;
        if(x==114){
        	groupSearchContent('groupSearchGrid.jsp?check=1');
        }
        else{}
        }

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var assetno = $('#txtasset').val();
		 var group = $('#txtgroupno').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdall").checked==true){
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
		 	
		 }else if(document.getElementById("rdsold").checked==true){
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
			 
		 }else{
			 $("#assetDiv").load("fixedAssetRegisterGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&assetno='+assetno+'&group='+group+'&check='+check);
		   }
		}
	
	function  funClearInfo(){
		
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
		document.getElementById("txtasset").value="";
		document.getElementById("txtgroup").value="";
		document.getElementById("txtgroupno").value="";
		
		document.getElementById("rdall").checked=true;
		
		 if (document.getElementById("txtgroup").value == "") {
		        $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtasset").value == "") {
		        $('#txtasset').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		}
	function  funPrint()
	 {
		var branchval = document.getElementById("cmbbranch").value;
		var rpttype=0;
		if(document.getElementById("rdall").checked==true){
			rpttype=1;
		}
		else if(document.getElementById("rdsold").checked==true){
			rpttype=2;
		}
		else{
			rpttype=3;
		}
		
		 var assetno = $('#txtasset').val();
		 var group = $('#txtgroupno').val();	
		 	    if ($("#cldocno").val()!="") {
			        var url=document.URL;
			        var reurl=url.split("fixedAssetRegister.jsp");
			        var win= window.open(reurl[0]+"printfixedassetregister?rpttype="+rpttype+"&branchval="+branchval+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val()+"&assetno="+assetno+"&group="+group,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
			     }
			    else {
					$.messager.alert('Message','Please Select a Client.','warning');
					return;
				}
     }
	  

</script>
</head>
<body onload="getBranch();">
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
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td align="right"><label class="branch">Asset</label></td>
	<td align="left"><input type="text" id="txtasset" name="txtasset" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtasset"/>' onkeydown="getAsset(event);"/></td></tr>
	<tr><td align="right"><label class="branch">Group</label></td>
	<td align="left"><input type="text" id="txtgroup" name="txtgroup" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtgroup"/>' onkeydown="getGroup(event);"/>
		             <input type="hidden" id="txtgroupno" name="txtgroupno" style="width:60%;height:20px;" value='<s:property value="txtgroupno"/>'/></td></tr> 
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="48%" align="center"><input type="radio" id="rdall" name="rdo" value="rdall"><label for="rdall" class="branch">All</label></td>
       <td width="52%" align="center"><input type="radio" id="rdsold" name="rdo" value="rdsold"><label for="rdsold" class="branch">Sold</label></td>
       </tr>
       <tr>
       <td colspan="2" align="center"><input type="radio" id="rdadditions" name="rdo" value="rdadditions"><label for="rdadditions" class="branch">Additions</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td><td align="right"><input type="button" class="myButton" name="btnPrint" id="btnPrint"  value="Print" onclick="funPrint();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="assetDiv"><jsp:include page="fixedAssetRegisterGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="assetDetailsWindow">
	<div></div><div></div>
</div>
<div id="groupDetailsWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>